import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:foot_step_meter/features/footprint_record/data/repository/footprint_record_repository_impl.dart';
import 'package:foot_step_meter/features/footprint_record/data/datasource/realm_datasource.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/route.dart';

import 'footprint_record_repository_impl_test.mocks.dart';

@GenerateMocks([RealmDatasource])
void main() {
  group('FootprintRecordRepositoryImpl', () {
    late MockRealmDatasource mockRealmDatasource;
    late FootprintRecordRepositoryImpl repository;

    setUp(() {
      mockRealmDatasource = MockRealmDatasource();
      repository = FootprintRecordRepositoryImpl(mockRealmDatasource);
    });

    group('saveFootprintRecord', () {
      test('should call datasource saveFootprintRecord', () async {
        // Arrange
        when(mockRealmDatasource.saveFootprintRecord(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.saveFootprintRecord(FootprintRecord(
          id: 'test-id',
          routeId: 'route-id',
          latitude: 0.0,
          longitude: 0.0,
          direction: 0.0,
          speed: 0.0,
          accuracy: 0.0,
          timestamp: DateTime.now(),
        ));

        // Assert
        verify(mockRealmDatasource.saveFootprintRecord(any)).called(1);
      });
    });

    group('saveFootprintRecords', () {
      test('should call datasource saveFootprintRecords', () async {
        // Arrange
        when(mockRealmDatasource.saveFootprintRecords(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.saveFootprintRecords([]);

        // Assert
        verify(mockRealmDatasource.saveFootprintRecords(any)).called(1);
      });
    });

    group('getFootprintRecordsByRoute', () {
      test('should call datasource getFootprintRecordsByRoute', () async {
        // Arrange
        when(mockRealmDatasource.getFootprintRecordsByRoute(any))
            .thenAnswer((_) async => []);

        // Act
        await repository.getFootprintRecordsByRoute('route-id');

        // Assert
        verify(mockRealmDatasource.getFootprintRecordsByRoute('route-id')).called(1);
      });
    });

    group('getAllFootprintRecords', () {
      test('should call datasource getAllFootprintRecords', () async {
        // Arrange
        when(mockRealmDatasource.getAllFootprintRecords())
            .thenAnswer((_) async => []);

        // Act
        await repository.getAllFootprintRecords();

        // Assert
        verify(mockRealmDatasource.getAllFootprintRecords()).called(1);
      });
    });

    group('deleteFootprintRecord', () {
      test('should call datasource deleteFootprintRecord', () async {
        // Arrange
        when(mockRealmDatasource.deleteFootprintRecord(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.deleteFootprintRecord('test-id');

        // Assert
        verify(mockRealmDatasource.deleteFootprintRecord('test-id')).called(1);
      });
    });

    group('deleteFootprintRecordsByRoute', () {
      test('should call datasource deleteFootprintRecordsByRoute', () async {
        // Arrange
        when(mockRealmDatasource.deleteFootprintRecordsByRoute(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.deleteFootprintRecordsByRoute('route-id');

        // Assert
        verify(mockRealmDatasource.deleteFootprintRecordsByRoute('route-id')).called(1);
      });
    });

    group('deleteAllFootprintRecords', () {
      test('should call datasource deleteAllFootprintRecords', () async {
        // Arrange
        when(mockRealmDatasource.deleteAllFootprintRecords())
            .thenAnswer((_) async => {});

        // Act
        await repository.deleteAllFootprintRecords();

        // Assert
        verify(mockRealmDatasource.deleteAllFootprintRecords()).called(1);
      });
    });

    group('saveRoute', () {
      test('should call datasource saveRoute', () async {
        // Arrange
        when(mockRealmDatasource.saveRoute(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.saveRoute(Route(
          id: 'route-id',
          name: 'Test Route',
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          footprints: [],
          totalDistance: 0.0,
          averageSpeed: 0.0,
          duration: Duration.zero,
        ));

        // Assert
        verify(mockRealmDatasource.saveRoute(any)).called(1);
      });
    });

    group('getAllRoutes', () {
      test('should call datasource getAllRoutes', () async {
        // Arrange
        when(mockRealmDatasource.getAllRoutes())
            .thenAnswer((_) async => []);

        // Act
        await repository.getAllRoutes();

        // Assert
        verify(mockRealmDatasource.getAllRoutes()).called(1);
      });
    });

    group('getRoute', () {
      test('should call datasource getRoute', () async {
        // Arrange
        when(mockRealmDatasource.getRoute(any))
            .thenAnswer((_) async => null);

        // Act
        await repository.getRoute('route-id');

        // Assert
        verify(mockRealmDatasource.getRoute('route-id')).called(1);
      });
    });

    group('deleteRoute', () {
      test('should call datasource deleteRoute', () async {
        // Arrange
        when(mockRealmDatasource.deleteRoute(any))
            .thenAnswer((_) async => {});

        // Act
        await repository.deleteRoute('route-id');

        // Assert
        verify(mockRealmDatasource.deleteRoute('route-id')).called(1);
      });
    });

    group('deleteAllRoutes', () {
      test('should call datasource deleteAllRoutes', () async {
        // Arrange
        when(mockRealmDatasource.deleteAllRoutes())
            .thenAnswer((_) async => {});

        // Act
        await repository.deleteAllRoutes();

        // Assert
        verify(mockRealmDatasource.deleteAllRoutes()).called(1);
      });
    });

    group('exportRouteToJson', () {
      test('should call datasource exportRouteToJson', () async {
        // Arrange
        when(mockRealmDatasource.exportRouteToJson(any))
            .thenAnswer((_) async => '{}');

        // Act
        await repository.exportRouteToJson('route-id');

        // Assert
        verify(mockRealmDatasource.exportRouteToJson('route-id')).called(1);
      });
    });

    group('exportAllRoutesToJson', () {
      test('should call datasource exportAllRoutesToJson', () async {
        // Arrange
        when(mockRealmDatasource.exportAllRoutesToJson())
            .thenAnswer((_) async => '[]');

        // Act
        await repository.exportAllRoutesToJson();

        // Assert
        verify(mockRealmDatasource.exportAllRoutesToJson()).called(1);
      });
    });
  });
}