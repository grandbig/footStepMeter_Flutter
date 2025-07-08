import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/route.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';

void main() {
  group('Route', () {
    // テスト用のサンプルデータ
    const sampleRouteId = 'route-id-123';
    const sampleRouteName = 'Morning Jog Route';
    final sampleStartTime = DateTime(2023, 12, 25, 8, 0, 0);
    final sampleEndTime = DateTime(2023, 12, 25, 9, 30, 0);
    const sampleTotalDistance = 5000.0; // 5km
    const sampleAverageSpeed = 3.33; // m/s
    const sampleDuration = Duration(hours: 1, minutes: 30);

    // テスト用のFootprintRecordのリスト
    List<FootprintRecord> createSampleFootprints() {
      return [
        FootprintRecord(
          id: 'fp-1',
          routeId: sampleRouteId,
          latitude: 35.6762,
          longitude: 139.6503,
          direction: 0.0,
          speed: 3.0,
          accuracy: 5.0,
          timestamp: sampleStartTime,
        ),
        FootprintRecord(
          id: 'fp-2',
          routeId: sampleRouteId,
          latitude: 35.6763,
          longitude: 139.6504,
          direction: 45.0,
          speed: 3.5,
          accuracy: 5.0,
          timestamp: sampleStartTime.add(const Duration(minutes: 30)),
        ),
        FootprintRecord(
          id: 'fp-3',
          routeId: sampleRouteId,
          latitude: 35.6764,
          longitude: 139.6505,
          direction: 90.0,
          speed: 4.0,
          accuracy: 5.0,
          timestamp: sampleEndTime,
        ),
      ];
    }

    group('コンストラクタのテスト', () {
      test('すべてのパラメータで正しく作成される', () {
        final footprints = createSampleFootprints();
        final route = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: footprints,
          totalDistance: sampleTotalDistance,
          averageSpeed: sampleAverageSpeed,
          duration: sampleDuration,
        );

        expect(route.id, equals(sampleRouteId));
        expect(route.name, equals(sampleRouteName));
        expect(route.startTime, equals(sampleStartTime));
        expect(route.endTime, equals(sampleEndTime));
        expect(route.footprints, equals(footprints));
        expect(route.totalDistance, equals(sampleTotalDistance));
        expect(route.averageSpeed, equals(sampleAverageSpeed));
        expect(route.duration, equals(sampleDuration));
      });

      test('空のfootprintsリストで正しく作成される', () {
        final route = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: const [],
          totalDistance: 0.0,
          averageSpeed: 0.0,
          duration: Duration.zero,
        );

        expect(route.footprints, isEmpty);
        expect(route.totalDistance, equals(0.0));
        expect(route.averageSpeed, equals(0.0));
        expect(route.duration, equals(Duration.zero));
      });
    });

    group('fromJsonのテスト', () {
      test('JSONから正しくオブジェクトを作成する', () {
        final footprints = createSampleFootprints();
        final json = {
          'id': sampleRouteId,
          'name': sampleRouteName,
          'start_time': sampleStartTime.toIso8601String(),
          'end_time': sampleEndTime.toIso8601String(),
          'footprints': footprints.map((fp) => fp.toJson()).toList(),
          'total_distance': sampleTotalDistance,
          'average_speed': sampleAverageSpeed,
          'duration': sampleDuration.inMicroseconds,
        };

        final route = Route.fromJson(json);

        expect(route.id, equals(sampleRouteId));
        expect(route.name, equals(sampleRouteName));
        expect(route.startTime, equals(sampleStartTime));
        expect(route.endTime, equals(sampleEndTime));
        expect(route.footprints.length, equals(footprints.length));
        expect(route.totalDistance, equals(sampleTotalDistance));
        expect(route.averageSpeed, equals(sampleAverageSpeed));
        expect(route.duration, equals(sampleDuration));
      });

    });

    group('ビジネスロジックのテスト', () {
      test('ルートが空かどうかを正しく判定する', () {
        // 空でないルート
        final nonEmptyRoute = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: createSampleFootprints(),
          totalDistance: sampleTotalDistance,
          averageSpeed: sampleAverageSpeed,
          duration: sampleDuration,
        );
        expect(nonEmptyRoute.isEmpty(), isFalse);

        // 空のルート
        final emptyRoute = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: const [],
          totalDistance: 0.0,
          averageSpeed: 0.0,
          duration: Duration.zero,
        );
        expect(emptyRoute.isEmpty(), isTrue);
      });

      test('キロメートル単位での表示に適しているか判定する', () {
        // 1000m以上（キロメートル表示が適切）
        final longRoute = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: createSampleFootprints(),
          totalDistance: 5000.0, // 5km
          averageSpeed: sampleAverageSpeed,
          duration: sampleDuration,
        );
        expect(longRoute.shouldDisplayInKilometers(), isTrue);

        // 1000m未満（メートル表示が適切）
        final shortRoute = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: createSampleFootprints(),
          totalDistance: 500.0, // 500m
          averageSpeed: sampleAverageSpeed,
          duration: sampleDuration,
        );
        expect(shortRoute.shouldDisplayInKilometers(), isFalse);

        // 境界値（ちょうど1000m）
        final boundaryRoute = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: createSampleFootprints(),
          totalDistance: 1000.0, // 1km
          averageSpeed: sampleAverageSpeed,
          duration: sampleDuration,
        );
        expect(boundaryRoute.shouldDisplayInKilometers(), isTrue);
      });

      test('平均速度のkm/h変換を正しく行う', () {
        final route = Route(
          id: sampleRouteId,
          name: sampleRouteName,
          startTime: sampleStartTime,
          endTime: sampleEndTime,
          footprints: createSampleFootprints(),
          totalDistance: sampleTotalDistance,
          averageSpeed: 3.0, // 3 m/s
          duration: sampleDuration,
        );

        // 3 m/s = 10.8 km/h
        expect(route.averageSpeedKmh, closeTo(10.8, 0.01));
      });
    });
  });
}