import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:foot_step_meter/core/result.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/footprint_record_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/service/location_permission_service.dart';
import 'package:foot_step_meter/features/footprint_record/domain/usecase/route_recording_usecase.dart';

import 'route_recording_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LocationRepository>(),
  MockSpec<FootprintRecordRepository>(),
  MockSpec<LocationPermissionService>(),
])
void main() {
  late RouteRecordingUseCase useCase;
  late MockLocationRepository mockLocationRepository;
  late MockFootprintRecordRepository mockFootprintRecordRepository;
  late MockLocationPermissionService mockPermissionService;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    mockFootprintRecordRepository = MockFootprintRecordRepository();
    mockPermissionService = MockLocationPermissionService();
    useCase = RouteRecordingUseCase(
      mockLocationRepository,
      mockFootprintRecordRepository,
      mockPermissionService,
    );
  });

  group('RouteRecordingUseCase', () {
    group('startRecording', () {
      test('権限が許可されている場合、ルート記録を開始できる', () async {
        // Arrange
        const routeName = 'テストルート';
        when(mockPermissionService.checkLocationAccess())
            .thenAnswer((_) async => const Result<void, LocationError>.success(null));
        
        final footprintStream = Stream<FootprintRecord>.fromIterable([
          FootprintRecord(
            id: '1',
            routeId: 'route1',
            latitude: 35.6762,
            longitude: 139.6503,
            direction: 0.0,
            speed: 1.5,
            accuracy: 5.0,
            timestamp: DateTime.now(),
          ),
        ]);
        when(mockLocationRepository.startLocationTracking())
            .thenAnswer((_) => footprintStream);

        // Act
        final result = await useCase.startRecording(routeName);

        // Assert
        expect(result.isSuccess, true);
        verify(mockPermissionService.checkLocationAccess()).called(1);
        verify(mockLocationRepository.startLocationTracking()).called(1);
      });

      test('権限が拒否されている場合、LocationErrorを返す', () async {
        // Arrange
        const routeName = 'テストルート';
        when(mockPermissionService.checkLocationAccess())
            .thenAnswer((_) async => const Result<void, LocationError>.failure(LocationError.permissionDenied));

        // Act
        final result = await useCase.startRecording(routeName);

        // Assert
        expect(result.isFailure, true);
        expect(result.error, LocationError.permissionDenied);
        verify(mockPermissionService.checkLocationAccess()).called(1);
        verifyNever(mockLocationRepository.startLocationTracking());
      });

      test('既に記録中の場合、エラーを返す', () async {
        // Arrange
        const routeName1 = 'テストルート1';
        const routeName2 = 'テストルート2';
        
        when(mockPermissionService.checkLocationAccess())
            .thenAnswer((_) async => const Result<void, LocationError>.success(null));
        
        final footprintStream = Stream<FootprintRecord>.fromIterable([]);
        when(mockLocationRepository.startLocationTracking())
            .thenAnswer((_) => footprintStream);

        // 最初の記録を開始
        await useCase.startRecording(routeName1);

        // Act - 2回目の記録開始を試行
        final result = await useCase.startRecording(routeName2);

        // Assert
        expect(result.isFailure, true);
        expect(result.error, LocationError.alreadyRecording);
      });
    });

    group('stopRecording', () {
      test('記録中の場合、ルートを正常に停止・保存できる', () async {
        // Arrange
        const routeName = 'テストルート';
        
        when(mockPermissionService.checkLocationAccess())
            .thenAnswer((_) async => const Result<void, LocationError>.success(null));
        
        final footprintRecord = FootprintRecord(
          id: '1',
          routeId: 'route1',
          latitude: 35.6762,
          longitude: 139.6503,
          direction: 0.0,
          speed: 1.5,
          accuracy: 5.0,
          timestamp: DateTime.now(),
        );
        
        final footprintStream = Stream<FootprintRecord>.fromIterable([footprintRecord]);
        when(mockLocationRepository.startLocationTracking())
            .thenAnswer((_) => footprintStream);
        when(mockLocationRepository.stopLocationTracking())
            .thenAnswer((_) async {});
        when(mockFootprintRecordRepository.saveRoute(any))
            .thenAnswer((_) async {});

        // 記録を開始
        await useCase.startRecording(routeName);
        
        // 少し待機してFootprintRecordが記録されるのを待つ
        await Future.delayed(const Duration(milliseconds: 100));

        // Act
        final result = await useCase.stopRecording();

        // Assert
        expect(result.isSuccess, true);
        verify(mockLocationRepository.stopLocationTracking()).called(1);
        verify(mockFootprintRecordRepository.saveRoute(any)).called(1);
      });

      test('記録していない場合、エラーを返す', () async {
        // Act
        final result = await useCase.stopRecording();

        // Assert
        expect(result.isFailure, true);
        expect(result.error, LocationError.notRecording);
        verifyNever(mockLocationRepository.stopLocationTracking());
        verifyNever(mockFootprintRecordRepository.saveRoute(any));
      });
    });
  });
}