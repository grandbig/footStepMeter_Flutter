import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/data/model/route_model.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/route.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';

void main() {
  group('RouteModel', () {
    late Route testRoute;
    late RouteModel testRouteModel;
    late List<FootprintRecord> testFootprintRecords;

    setUp(() {
      testFootprintRecords = [
        FootprintRecord(
          id: 'footprint-1',
          routeId: 'test-route-id',
          latitude: 35.6762,
          longitude: 139.6503,
          direction: 45.0,
          speed: 1.2,
          accuracy: 5.0,
          timestamp: DateTime(2023, 1, 1, 10, 0, 0),
          routeName: 'Test Route',
        ),
        FootprintRecord(
          id: 'footprint-2',
          routeId: 'test-route-id',
          latitude: 35.6763,
          longitude: 139.6504,
          direction: 50.0,
          speed: 1.3,
          accuracy: 4.0,
          timestamp: DateTime(2023, 1, 1, 10, 1, 0),
          routeName: 'Test Route',
        ),
      ];

      testRoute = Route(
        id: 'test-route-id',
        name: 'Test Route',
        startTime: DateTime(2023, 1, 1, 10, 0, 0),
        endTime: DateTime(2023, 1, 1, 10, 30, 0),
        footprints: testFootprintRecords,
        totalDistance: 1000.0,
        averageSpeed: 1.5,
        duration: Duration(minutes: 30),
      );

      testRouteModel = RouteModel(
        'test-route-id',
        'Test Route',
        DateTime(2023, 1, 1, 10, 0, 0),
        DateTime(2023, 1, 1, 10, 30, 0),
        1000.0,
        1.5,
        1800, // 30 minutes in seconds
      );
    });

    group('fromEntity', () {
      test('should convert Route entity to RouteModel correctly', () {
        final model = RouteModelExtension.fromEntity(testRoute);

        expect(model.id, equals('test-route-id'));
        expect(model.name, equals('Test Route'));
        expect(model.startTime, equals(DateTime(2023, 1, 1, 10, 0, 0)));
        expect(model.endTime, equals(DateTime(2023, 1, 1, 10, 30, 0)));
        expect(model.totalDistance, equals(1000.0));
        expect(model.averageSpeed, equals(1.5));
        expect(model.durationInSeconds, equals(1800)); // 30 minutes = 1800 seconds
      });

    });

    group('toEntity', () {
      test('should convert RouteModel to Route entity correctly', () {
        final entity = testRouteModel.toEntity(testFootprintRecords);

        expect(entity.id, equals('test-route-id'));
        expect(entity.name, equals('Test Route'));
        expect(entity.startTime, equals(DateTime(2023, 1, 1, 10, 0, 0)));
        expect(entity.endTime, equals(DateTime(2023, 1, 1, 10, 30, 0)));
        expect(entity.footprints, equals(testFootprintRecords));
        expect(entity.totalDistance, equals(1000.0));
        expect(entity.averageSpeed, equals(1.5));
        expect(entity.duration, equals(Duration(minutes: 30)));
      });

    });


  });
}