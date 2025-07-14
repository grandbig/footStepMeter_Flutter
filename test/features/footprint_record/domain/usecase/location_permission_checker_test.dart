import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart';
import 'package:foot_step_meter/features/footprint_record/domain/usecase/location_permission_checker.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';

import 'location_permission_checker_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationRepository>()])
void main() {
  late LocationPermissionChecker permissionChecker;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    permissionChecker = LocationPermissionChecker(mockLocationRepository);
  });

  group('LocationPermissionChecker', () {
    group('checkLocationAccess', () {
      test('権限ありサービス有効の場合、成功を返す', () async {
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => true);
        when(mockLocationRepository.isLocationServiceEnabled())
            .thenAnswer((_) async => true);

        final result = await permissionChecker.checkLocationAccess();

        expect(result.isSuccess, true);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        verify(mockLocationRepository.isLocationServiceEnabled()).called(1);
      });

      test('権限なしの場合、permissionDeniedエラーを返す', () async {
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => false);

        final result = await permissionChecker.checkLocationAccess();

        expect(result.isFailure, true);
        expect(result.error, LocationError.permissionDenied);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        verifyNever(mockLocationRepository.isLocationServiceEnabled());
      });

      test('権限ありだがサービス無効の場合、serviceDisabledエラーを返す', () async {
        when(mockLocationRepository.checkLocationPermission())
            .thenAnswer((_) async => true);
        when(mockLocationRepository.isLocationServiceEnabled())
            .thenAnswer((_) async => false);

        final result = await permissionChecker.checkLocationAccess();

        expect(result.isFailure, true);
        expect(result.error, LocationError.serviceDisabled);
        verify(mockLocationRepository.checkLocationPermission()).called(1);
        verify(mockLocationRepository.isLocationServiceEnabled()).called(1);
      });

    });
  });
}