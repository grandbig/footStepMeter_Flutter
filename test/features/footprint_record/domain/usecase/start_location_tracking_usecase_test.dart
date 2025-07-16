import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/usecase/start_location_tracking_usecase.dart';
import 'package:foot_step_meter/features/footprint_record/domain/service/location_permission_service.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';
import 'package:foot_step_meter/core/result.dart';

import 'start_location_tracking_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationRepository>(), MockSpec<LocationPermissionService>()])
void main() {
  late StartLocationTrackingUseCase useCase;
  late MockLocationRepository mockLocationRepository;
  late MockLocationPermissionService mockPermissionService;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    mockPermissionService = MockLocationPermissionService();
    useCase = StartLocationTrackingUseCase(mockLocationRepository, mockPermissionService);
  });

  group('StartLocationTrackingUseCase', () {
    test('権限があり位置情報サービスが有効な場合、位置追跡を開始できる', () async {
      final testFootprints = [
        FootprintRecord(
          id: '1',
          routeId: 'route1',
          latitude: 35.6762,
          longitude: 139.6503,
          direction: 90.0,
          speed: 1.5,
          accuracy: 5.0,
          timestamp: DateTime.now(),
        ),
        FootprintRecord(
          id: '2',
          routeId: 'route1',
          latitude: 35.6763,
          longitude: 139.6504,
          direction: 91.0,
          speed: 1.6,
          accuracy: 4.0,
          timestamp: DateTime.now(),
        ),
      ];

      when(mockPermissionService.checkLocationAccess())
          .thenAnswer((_) async => const Result<void, LocationError>.success(null));
      when(mockLocationRepository.startLocationTracking())
          .thenAnswer((_) => Stream.fromIterable(testFootprints));

      final result = await useCase.execute();

      expect(result.isSuccess, true);
      
      final locationStream = result.data!;
      final receivedFootprints = await locationStream.take(2).toList();
      
      expect(receivedFootprints, testFootprints);
      verify(mockPermissionService.checkLocationAccess()).called(1);
      verify(mockLocationRepository.startLocationTracking()).called(1);
    });

    test('権限がない場合、エラーを返す', () async {
      when(mockPermissionService.checkLocationAccess())
          .thenAnswer((_) async => const Result<void, LocationError>.failure(LocationError.permissionDenied));

      final result = await useCase.execute();

      expect(result.isFailure, true);
      expect(result.error, LocationError.permissionDenied);
      verify(mockPermissionService.checkLocationAccess()).called(1);
      verifyNever(mockLocationRepository.startLocationTracking());
    });

  });
}