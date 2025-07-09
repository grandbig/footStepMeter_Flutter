import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/data/model/footprint_record_model.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';

void main() {
  group('FootprintRecordModel', () {
    late FootprintRecord testEntity;
    late FootprintRecordModel testModel;

    setUp(() {
      testEntity = FootprintRecord(
        id: 'test-id',
        routeId: 'test-route-id',
        latitude: 35.6762,
        longitude: 139.6503,
        direction: 45.0,
        speed: 1.2,
        accuracy: 5.0,
        timestamp: DateTime(2023, 1, 1, 10, 0, 0),
        routeName: 'Test Route',
      );

      testModel = FootprintRecordModel(
        'test-id',
        'test-route-id',
        35.6762,
        139.6503,
        45.0,
        1.2,
        5.0,
        DateTime(2023, 1, 1, 10, 0, 0),
        routeName: 'Test Route',
      );
    });

    group('fromEntity', () {
      test('should convert FootprintRecord entity to FootprintRecordModel correctly', () {
        final model = FootprintRecordModelExtension.fromEntity(testEntity);

        expect(model.id, equals('test-id'));
        expect(model.routeId, equals('test-route-id'));
        expect(model.latitude, equals(35.6762));
        expect(model.longitude, equals(139.6503));
        expect(model.direction, equals(45.0));
        expect(model.speed, equals(1.2));
        expect(model.accuracy, equals(5.0));
        expect(model.timestamp, equals(DateTime(2023, 1, 1, 10, 0, 0)));
        expect(model.routeName, equals('Test Route'));
      });
    });

    group('toEntity', () {
      test('should convert FootprintRecordModel to FootprintRecord entity correctly', () {
        final entity = testModel.toEntity();

        expect(entity.id, equals('test-id'));
        expect(entity.routeId, equals('test-route-id'));
        expect(entity.latitude, equals(35.6762));
        expect(entity.longitude, equals(139.6503));
        expect(entity.direction, equals(45.0));
        expect(entity.speed, equals(1.2));
        expect(entity.accuracy, equals(5.0));
        expect(entity.timestamp, equals(DateTime(2023, 1, 1, 10, 0, 0)));
        expect(entity.routeName, equals('Test Route'));
      });
    });
  });
}