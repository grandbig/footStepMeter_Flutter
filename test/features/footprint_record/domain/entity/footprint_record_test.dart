import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';

void main() {
  group('FootprintRecord', () {
    // テスト用のサンプルデータ
    const sampleId = 'test-id-123';
    const sampleRouteId = 'route-id-456';
    const sampleLatitude = 35.6762;
    const sampleLongitude = 139.6503;
    const sampleDirection = 180.0;
    const sampleSpeed = 5.0;
    const sampleAccuracy = 10.0;
    final sampleTimestamp = DateTime(2023, 12, 25, 10, 30, 0);
    const sampleRouteName = 'Morning Walk';

    group('コンストラクタのテスト', () {
      test('必須パラメータで正しく作成される', () {
        final record = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: sampleAccuracy,
          timestamp: sampleTimestamp,
        );

        expect(record.id, equals(sampleId));
        expect(record.routeId, equals(sampleRouteId));
        expect(record.latitude, equals(sampleLatitude));
        expect(record.longitude, equals(sampleLongitude));
        expect(record.direction, equals(sampleDirection));
        expect(record.speed, equals(sampleSpeed));
        expect(record.accuracy, equals(sampleAccuracy));
        expect(record.timestamp, equals(sampleTimestamp));
        expect(record.routeName, isNull);
      });

      test('オプショナルパラメータを含めて正しく作成される', () {
        final record = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: sampleAccuracy,
          timestamp: sampleTimestamp,
          routeName: sampleRouteName,
        );

        expect(record.routeName, equals(sampleRouteName));
      });
    });

    group('fromJsonのテスト', () {
      test('JSONから正しくオブジェクトを作成する', () {
        final json = {
          'id': sampleId,
          'route_id': sampleRouteId,
          'latitude': sampleLatitude,
          'longitude': sampleLongitude,
          'direction': sampleDirection,
          'speed': sampleSpeed,
          'accuracy': sampleAccuracy,
          'timestamp': sampleTimestamp.toIso8601String(),
          'route_name': sampleRouteName,
        };

        final record = FootprintRecord.fromJson(json);

        expect(record.id, equals(sampleId));
        expect(record.routeId, equals(sampleRouteId));
        expect(record.latitude, equals(sampleLatitude));
        expect(record.longitude, equals(sampleLongitude));
        expect(record.direction, equals(sampleDirection));
        expect(record.speed, equals(sampleSpeed));
        expect(record.accuracy, equals(sampleAccuracy));
        expect(record.timestamp, equals(sampleTimestamp));
        expect(record.routeName, equals(sampleRouteName));
      });

      test('routeNameがnullのJSONから正しくオブジェクトを作成する', () {
        final json = {
          'id': sampleId,
          'route_id': sampleRouteId,
          'latitude': sampleLatitude,
          'longitude': sampleLongitude,
          'direction': sampleDirection,
          'speed': sampleSpeed,
          'accuracy': sampleAccuracy,
          'timestamp': sampleTimestamp.toIso8601String(),
          'route_name': null,
        };

        final record = FootprintRecord.fromJson(json);

        expect(record.routeName, isNull);
      });
    });

    group('ビジネスロジックのテスト', () {
      test('位置情報の有効性を正しく判定する', () {
        // 有効な位置情報
        final validRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude, // 35.6762 (有効)
          longitude: sampleLongitude, // 139.6503 (有効)
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: sampleAccuracy,
          timestamp: sampleTimestamp,
        );
        expect(validRecord.isValidLocation(), isTrue);

        // 無効な緯度
        final invalidLatRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: 91.0, // 無効 (> 90)
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: sampleAccuracy,
          timestamp: sampleTimestamp,
        );
        expect(invalidLatRecord.isValidLocation(), isFalse);

        // 無効な経度
        final invalidLngRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: 181.0, // 無効 (> 180)
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: sampleAccuracy,
          timestamp: sampleTimestamp,
        );
        expect(invalidLngRecord.isValidLocation(), isFalse);
      });

      test('精度の判定を正しく行う', () {
        // 高精度（10m以下）
        final highAccuracyRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: 5.0, // 高精度
          timestamp: sampleTimestamp,
        );
        expect(highAccuracyRecord.isHighAccuracy(), isTrue);

        // 低精度（10mを超える）
        final lowAccuracyRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: 15.0, // 低精度
          timestamp: sampleTimestamp,
        );
        expect(lowAccuracyRecord.isHighAccuracy(), isFalse);

        // 境界値（ちょうど10m）
        final boundaryRecord = FootprintRecord(
          id: sampleId,
          routeId: sampleRouteId,
          latitude: sampleLatitude,
          longitude: sampleLongitude,
          direction: sampleDirection,
          speed: sampleSpeed,
          accuracy: 10.0, // 境界値
          timestamp: sampleTimestamp,
        );
        expect(boundaryRecord.isHighAccuracy(), isTrue);
      });
    });
  });
}