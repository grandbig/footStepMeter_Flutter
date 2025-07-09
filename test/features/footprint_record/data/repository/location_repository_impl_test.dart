import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/data/repository/location_repository_impl.dart';
import 'package:foot_step_meter/features/footprint_record/data/datasource/location_datasource.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';

import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationDatasource])
void main() {
  group('LocationRepositoryImpl', () {
    late MockLocationDatasource mockLocationDatasource;
    late LocationRepositoryImpl repository;

    setUp(() {
      mockLocationDatasource = MockLocationDatasource();
      repository = LocationRepositoryImpl(mockLocationDatasource);
    });

    group('getCurrentLocation', () {
      test('should call datasource getCurrentLocation', () async {
        // Arrange
        when(mockLocationDatasource.getCurrentLocation())
            .thenAnswer((_) async => null);

        // Act
        await repository.getCurrentLocation();

        // Assert
        verify(mockLocationDatasource.getCurrentLocation()).called(1);
      });
    });

    group('startLocationTracking', () {
      test('should call datasource startLocationTracking', () {
        // Arrange
        final controller = StreamController<FootprintRecord>();
        when(mockLocationDatasource.startLocationTracking())
            .thenAnswer((_) => controller.stream);

        // Act
        repository.startLocationTracking();

        // Assert
        verify(mockLocationDatasource.startLocationTracking()).called(1);
        
        controller.close();
      });
    });

    group('stopLocationTracking', () {
      test('should call datasource stopLocationTracking', () async {
        // Arrange
        when(mockLocationDatasource.stopLocationTracking())
            .thenAnswer((_) async => {});

        // Act
        await repository.stopLocationTracking();

        // Assert
        verify(mockLocationDatasource.stopLocationTracking()).called(1);
      });

    });

    group('requestLocationPermission', () {
      test('should call datasource requestLocationPermission and return result', () async {
        // Arrange
        when(mockLocationDatasource.requestLocationPermission())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.requestLocationPermission();

        // Assert
        expect(result, isTrue);
        verify(mockLocationDatasource.requestLocationPermission()).called(1);
      });

    });

    group('checkLocationPermission', () {
      test('should call datasource checkLocationPermission and return result', () async {
        // Arrange
        when(mockLocationDatasource.checkLocationPermission())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.checkLocationPermission();

        // Assert
        expect(result, isFalse);
        verify(mockLocationDatasource.checkLocationPermission()).called(1);
      });

    });

    group('isLocationServiceEnabled', () {
      test('should call datasource isLocationServiceEnabled and return result', () async {
        // Arrange
        when(mockLocationDatasource.isLocationServiceEnabled())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.isLocationServiceEnabled();

        // Assert
        expect(result, isTrue);
        verify(mockLocationDatasource.isLocationServiceEnabled()).called(1);
      });

    });
  });
}