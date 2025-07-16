import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/usecase/get_current_location_usecase.dart';
import 'package:foot_step_meter/features/footprint_record/domain/service/location_permission_service.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';
import 'package:foot_step_meter/core/result.dart';

import 'get_current_location_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationRepository>(), MockSpec<LocationPermissionService>()])
void main() {
  late GetCurrentLocationUseCase useCase;
  late MockLocationRepository mockLocationRepository;
  late MockLocationPermissionService mockPermissionService;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    mockPermissionService = MockLocationPermissionService();
    useCase = GetCurrentLocationUseCase(mockLocationRepository, mockPermissionService);
  });

  group('GetCurrentLocationUseCase', () {
    test('権限があり位置情報サービスが有効な場合、現在位置を取得できる', () async {
      final expectedFootprint = FootprintRecord(
        id: '1',
        routeId: 'route1',
        latitude: 35.6762,
        longitude: 139.6503,
        direction: 90.0,
        speed: 1.5,
        accuracy: 5.0,
        timestamp: DateTime.now(),
      );

      when(mockPermissionService.checkLocationAccess())
          .thenAnswer((_) async => const Result<void, LocationError>.success(null));
      when(mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => expectedFootprint);

      final result = await useCase.execute();

      expect(result.isSuccess, true);
      expect(result.data, expectedFootprint);
      verify(mockPermissionService.checkLocationAccess()).called(1);
      verify(mockLocationRepository.getCurrentLocation()).called(1);
    });

    test('権限がない場合、エラーを返す', () async {
      when(mockPermissionService.checkLocationAccess())
          .thenAnswer((_) async => const Result<void, LocationError>.failure(LocationError.permissionDenied));

      final result = await useCase.execute();

      expect(result.isFailure, true);
      expect(result.error, LocationError.permissionDenied);
      verify(mockPermissionService.checkLocationAccess()).called(1);
      verifyNever(mockLocationRepository.getCurrentLocation());
    });

    test('位置情報取得に失敗した場合、エラーを返す', () async {
      when(mockPermissionService.checkLocationAccess())
          .thenAnswer((_) async => const Result<void, LocationError>.success(null));
      when(mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => null);

      final result = await useCase.execute();

      expect(result.isFailure, true);
      expect(result.error, LocationError.locationUnavailable);
      verify(mockPermissionService.checkLocationAccess()).called(1);
      verify(mockLocationRepository.getCurrentLocation()).called(1);
    });
  });
}