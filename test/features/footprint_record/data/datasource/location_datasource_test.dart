import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/data/datasource/location_datasource.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

/// Test implementation of GeolocatorPlatform
class TestGeolocatorPlatform extends GeolocatorPlatform {
  Position? _currentPosition;
  bool _locationServiceEnabled = true;
  LocationPermission _locationPermission = LocationPermission.whileInUse;
  bool _shouldRequestPermissionSucceed = true;
  StreamController<Position>? _positionStreamController;
  bool _shouldThrowException = false;
  String? _exceptionMessage;

  // Test configuration methods
  void setCurrentPosition(Position? position) {
    _currentPosition = position;
  }

  void setLocationServiceEnabled(bool enabled) {
    _locationServiceEnabled = enabled;
  }

  void setLocationPermission(LocationPermission permission) {
    _locationPermission = permission;
  }

  void setShouldRequestPermissionSucceed(bool shouldSucceed) {
    _shouldRequestPermissionSucceed = shouldSucceed;
  }

  void setShouldThrowException(bool shouldThrow, [String? message]) {
    _shouldThrowException = shouldThrow;
    _exceptionMessage = message;
  }

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    if (_shouldThrowException) {
      throw Exception(_exceptionMessage ?? 'Test exception');
    }
    if (_currentPosition == null) {
      throw Exception('No position available');
    }
    return _currentPosition!;
  }

  @override
  Stream<Position> getPositionStream({
    LocationSettings? locationSettings,
  }) {
    _positionStreamController = StreamController<Position>();
    return _positionStreamController!.stream;
  }

  @override
  Future<LocationPermission> checkPermission() async {
    return _locationPermission;
  }

  @override
  Future<LocationPermission> requestPermission() async {
    if (_shouldRequestPermissionSucceed) {
      _locationPermission = LocationPermission.whileInUse;
      return LocationPermission.whileInUse;
    }
    return LocationPermission.denied;
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return _locationServiceEnabled;
  }

  // Test utility methods
  void simulatePositionUpdate(Position position) {
    _positionStreamController?.add(position);
  }

  void simulatePositionError(dynamic error) {
    _positionStreamController?.addError(error);
  }

  void closePositionStream() {
    _positionStreamController?.close();
  }
}

void main() {
  group('LocationDatasourceImpl', () {
    late LocationDatasourceImpl datasource;
    late TestGeolocatorPlatform mockGeolocator;
    late Position testPosition;

    setUp(() {
      mockGeolocator = TestGeolocatorPlatform();
      datasource = LocationDatasourceImpl(mockGeolocator);
      testPosition = Position(
        latitude: 35.6762,
        longitude: 139.6503,
        timestamp: DateTime(2023, 1, 1, 10, 0, 0),
        accuracy: 5.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 45.0,
        headingAccuracy: 0.0,
        speed: 1.2,
        speedAccuracy: 0.0,
      );
    });

    tearDown(() {
      datasource.dispose();
      mockGeolocator.closePositionStream();
    });

    group('getCurrentLocation', () {
      test('should return FootprintRecord when location is available', () async {
        mockGeolocator.setCurrentPosition(testPosition);
        mockGeolocator.setLocationServiceEnabled(true);
        mockGeolocator.setLocationPermission(LocationPermission.whileInUse);

        final result = await datasource.getCurrentLocation();

        expect(result, isNotNull);
        expect(result!.latitude, equals(35.6762));
        expect(result.longitude, equals(139.6503));
        expect(result.direction, equals(45.0));
        expect(result.speed, equals(1.2));
        expect(result.accuracy, equals(5.0));
        expect(result.routeId, equals(''));
      });

      test('should return null when location service is disabled', () async {
        mockGeolocator.setCurrentPosition(testPosition);
        mockGeolocator.setLocationServiceEnabled(false);
        mockGeolocator.setLocationPermission(LocationPermission.whileInUse);

        final result = await datasource.getCurrentLocation();

        expect(result, isNull);
      });

      test('should return null when permission is denied', () async {
        mockGeolocator.setCurrentPosition(testPosition);
        mockGeolocator.setLocationServiceEnabled(true);
        mockGeolocator.setLocationPermission(LocationPermission.denied);

        final result = await datasource.getCurrentLocation();

        expect(result, isNull);
      });

      test('should return null when exception occurs', () async {
        mockGeolocator.setLocationServiceEnabled(true);
        mockGeolocator.setLocationPermission(LocationPermission.whileInUse);
        mockGeolocator.setShouldThrowException(true, 'GPS error');

        final result = await datasource.getCurrentLocation();

        expect(result, isNull);
      });
    });

    group('startLocationTracking', () {
      test('should return Stream<FootprintRecord>', () {
        final stream = datasource.startLocationTracking();

        expect(stream, isA<Stream<FootprintRecord>>());
      });

      test('should emit FootprintRecord when position is updated', () async {
        final stream = datasource.startLocationTracking();
        
        final streamData = <FootprintRecord>[];
        final subscription = stream.listen(streamData.add);

        mockGeolocator.simulatePositionUpdate(testPosition);
        await Future.delayed(Duration(milliseconds: 10));

        expect(streamData, hasLength(1));
        expect(streamData.first.latitude, equals(35.6762));
        expect(streamData.first.longitude, equals(139.6503));
        
        await subscription.cancel();
      });

      test('should emit error when position stream has error', () async {
        final stream = datasource.startLocationTracking();
        
        final streamErrors = <dynamic>[];
        final subscription = stream.listen(
          (_) {},
          onError: streamErrors.add,
        );

        final testError = Exception('Position error');
        mockGeolocator.simulatePositionError(testError);
        await Future.delayed(Duration(milliseconds: 10));

        expect(streamErrors, hasLength(1));
        expect(streamErrors.first, equals(testError));
        
        await subscription.cancel();
      });
    });

    group('stopLocationTracking', () {
      test('should complete without error', () async {
        final stream = datasource.startLocationTracking();
        
        // Subscribe to stream briefly to ensure it's set up
        final subscription = stream.listen((_) {});
        
        // Give a moment for the stream to be set up
        await Future.delayed(Duration(milliseconds: 10));

        await datasource.stopLocationTracking();
        
        // Clean up subscription
        await subscription.cancel();
      });

      test('should handle stop when not tracking', () async {
        await datasource.stopLocationTracking();
        
        // Should complete without error
        expect(true, isTrue);
      });
    });

    group('requestLocationPermission', () {
      test('should return true when permission is granted', () async {
        mockGeolocator.setLocationPermission(LocationPermission.denied);
        mockGeolocator.setShouldRequestPermissionSucceed(true);

        final result = await datasource.requestLocationPermission();

        expect(result, isTrue);
      });

      test('should return false when permission is denied', () async {
        mockGeolocator.setLocationPermission(LocationPermission.denied);
        mockGeolocator.setShouldRequestPermissionSucceed(false);

        final result = await datasource.requestLocationPermission();

        expect(result, isFalse);
      });

      test('should return true when permission is already granted', () async {
        mockGeolocator.setLocationPermission(LocationPermission.whileInUse);

        final result = await datasource.requestLocationPermission();

        expect(result, isTrue);
      });

      test('should return true when permission is always granted', () async {
        mockGeolocator.setLocationPermission(LocationPermission.always);

        final result = await datasource.requestLocationPermission();

        expect(result, isTrue);
      });
    });

    group('checkLocationPermission', () {
      test('should return true when permission is whileInUse', () async {
        mockGeolocator.setLocationPermission(LocationPermission.whileInUse);

        final result = await datasource.checkLocationPermission();

        expect(result, isTrue);
      });

      test('should return true when permission is always', () async {
        mockGeolocator.setLocationPermission(LocationPermission.always);

        final result = await datasource.checkLocationPermission();

        expect(result, isTrue);
      });

      test('should return false when permission is denied', () async {
        mockGeolocator.setLocationPermission(LocationPermission.denied);

        final result = await datasource.checkLocationPermission();

        expect(result, isFalse);
      });

      test('should return false when permission is deniedForever', () async {
        mockGeolocator.setLocationPermission(LocationPermission.deniedForever);

        final result = await datasource.checkLocationPermission();

        expect(result, isFalse);
      });
    });

    group('isLocationServiceEnabled', () {
      test('should return true when service is enabled', () async {
        mockGeolocator.setLocationServiceEnabled(true);

        final result = await datasource.isLocationServiceEnabled();

        expect(result, isTrue);
      });

      test('should return false when service is disabled', () async {
        mockGeolocator.setLocationServiceEnabled(false);

        final result = await datasource.isLocationServiceEnabled();

        expect(result, isFalse);
      });
    });

    group('dispose', () {
      test('should call stopLocationTracking', () async {
        datasource.startLocationTracking();
        
        // Should complete without error
        expect(() => datasource.dispose(), returnsNormally);
      });
    });
  });
}