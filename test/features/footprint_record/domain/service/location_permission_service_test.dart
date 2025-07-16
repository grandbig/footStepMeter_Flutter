import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/service/location_permission_service.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';

import 'location_permission_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationRepository>()])
void main() {
  late LocationPermissionService service;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    service = LocationPermissionService(mockLocationRepository);
  });

  group('LocationPermissionService', () {
    group('checkLocationAccess', () {
      test('権限があり位置情報サービスが有効な場合、成功を返す', () async {
        // Arrange
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => true);
        when(mockLocationRepository.isLocationServiceEnabled())
            .thenAnswer((_) async => true);

        // Act
        final result = await service.checkLocationAccess();

        // Assert
        expect(result.isSuccess, true);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        verify(mockLocationRepository.isLocationServiceEnabled()).called(1);
      });

      test('権限がない場合、permissionDeniedエラーを返す', () async {
        // Arrange
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => false);

        // Act
        final result = await service.checkLocationAccess();

        // Assert
        expect(result.isFailure, true);
        expect(result.error, LocationError.permissionDenied);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        // 権限がない場合、サービス確認は行われない
        verifyNever(mockLocationRepository.isLocationServiceEnabled());
      });

      test('権限はあるが位置情報サービスが無効な場合、serviceDisabledエラーを返す', () async {
        // Arrange
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => true);
        when(mockLocationRepository.isLocationServiceEnabled())
            .thenAnswer((_) async => false);

        // Act
        final result = await service.checkLocationAccess();

        // Assert
        expect(result.isFailure, true);
        expect(result.error, LocationError.serviceDisabled);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        verify(mockLocationRepository.isLocationServiceEnabled()).called(1);
      });
    });
  });
}