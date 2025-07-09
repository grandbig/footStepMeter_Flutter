import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/features/footprint_record/data/datasource/realm_datasource.dart';
import 'package:foot_step_meter/features/footprint_record/data/model/footprint_record_model.dart';
import 'package:foot_step_meter/features/footprint_record/data/model/route_model.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart';
import 'package:foot_step_meter/features/footprint_record/domain/entity/route.dart';
import 'package:realm/realm.dart';


void main() {
  group('RealmDatasourceImpl', () {
    group('Constructor', () {
      test('should initialize with provided Realm instance', () {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);

          expect(datasource, isNotNull);
          expect(datasource, isA<RealmDatasourceImpl>());
          expect(datasource, isA<RealmDatasource>());
          
          // Clean up
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });

      test('should initialize with default Realm when null or no realm is provided', () {
        try {
          // Test with null parameter
          final datasourceWithNull = RealmDatasourceImpl(null);
          expect(datasourceWithNull, isNotNull);
          expect(datasourceWithNull, isA<RealmDatasourceImpl>());
          
          // Test with no parameter
          final datasourceWithoutParam = RealmDatasourceImpl();
          expect(datasourceWithoutParam, isNotNull);
          expect(datasourceWithoutParam, isA<RealmDatasourceImpl>());
          
          // Clean up
          datasourceWithNull.dispose();
          datasourceWithoutParam.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('saveFootprintRecord', () {
      test('should save FootprintRecord and retrieve it correctly', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test FootprintRecord with UTC timestamp
          final testRecord = FootprintRecord(
            id: 'test-id-001',
            routeId: 'route-001',
            latitude: 35.6762,
            longitude: 139.6503,
            direction: 45.0,
            speed: 1.2,
            accuracy: 5.0,
            timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
            routeName: 'Test Route',
          );
          
          // Save the record
          await datasource.saveFootprintRecord(testRecord);
          
          // Retrieve all records
          final savedRecords = await datasource.getAllFootprintRecords();
          
          // Verify the saved record
          expect(savedRecords, hasLength(1));
          final savedRecord = savedRecords.first;
          
          expect(savedRecord.id, equals(testRecord.id));
          expect(savedRecord.routeId, equals(testRecord.routeId));
          expect(savedRecord.latitude, equals(testRecord.latitude));
          expect(savedRecord.longitude, equals(testRecord.longitude));
          expect(savedRecord.direction, equals(testRecord.direction));
          expect(savedRecord.speed, equals(testRecord.speed));
          expect(savedRecord.accuracy, equals(testRecord.accuracy));
          expect(savedRecord.timestamp, equals(testRecord.timestamp));
          expect(savedRecord.routeName, equals(testRecord.routeName));
          
          // Clean up
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('saveFootprintRecords', () {
      test('should save multiple FootprintRecords and retrieve them correctly', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test FootprintRecords with UTC timestamps
          final testRecords = [
            FootprintRecord(
              id: 'test-id-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              routeName: 'Test Route',
            ),
            FootprintRecord(
              id: 'test-id-002',
              routeId: 'route-001',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
              routeName: 'Test Route',
            ),
            FootprintRecord(
              id: 'test-id-003',
              routeId: 'route-002',
              latitude: 35.6764,
              longitude: 139.6505,
              direction: 47.0,
              speed: 1.4,
              accuracy: 7.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 2, 0),
              routeName: 'Test Route 2',
            ),
          ];
          
          // Save the records
          await datasource.saveFootprintRecords(testRecords);
          
          // Retrieve all records
          final savedRecords = await datasource.getAllFootprintRecords();
          
          // Verify the saved records
          expect(savedRecords, hasLength(3));
          
          // Sort records by id for consistent comparison
          savedRecords.sort((a, b) => a.id.compareTo(b.id));
          
          // Verify each record
          for (int i = 0; i < testRecords.length; i++) {
            final testRecord = testRecords[i];
            final savedRecord = savedRecords[i];
            
            expect(savedRecord.id, equals(testRecord.id));
            expect(savedRecord.routeId, equals(testRecord.routeId));
            expect(savedRecord.latitude, equals(testRecord.latitude));
            expect(savedRecord.longitude, equals(testRecord.longitude));
            expect(savedRecord.direction, equals(testRecord.direction));
            expect(savedRecord.speed, equals(testRecord.speed));
            expect(savedRecord.accuracy, equals(testRecord.accuracy));
            expect(savedRecord.timestamp, equals(testRecord.timestamp));
            expect(savedRecord.routeName, equals(testRecord.routeName));
          }
          
          // Clean up
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('getFootprintRecordsByRoute', () {
      test('should return records for specified route', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test records for different routes
          final testRecords = [
            FootprintRecord(
              id: 'test-id-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              routeName: 'Route 1',
            ),
            FootprintRecord(
              id: 'test-id-002',
              routeId: 'route-002',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
              routeName: 'Route 2',
            ),
            FootprintRecord(
              id: 'test-id-003',
              routeId: 'route-001',
              latitude: 35.6764,
              longitude: 139.6505,
              direction: 47.0,
              speed: 1.4,
              accuracy: 7.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 2, 0),
              routeName: 'Route 1',
            ),
          ];
          
          await datasource.saveFootprintRecords(testRecords);
          
          // Get records for route-001
          final route1Records = await datasource.getFootprintRecordsByRoute('route-001');
          
          expect(route1Records, hasLength(2));
          expect(route1Records.every((record) => record.routeId == 'route-001'), isTrue);
          
          // Get records for route-002
          final route2Records = await datasource.getFootprintRecordsByRoute('route-002');
          
          expect(route2Records, hasLength(1));
          expect(route2Records.first.routeId, equals('route-002'));
          
          // Get records for non-existent route
          final nonExistentRecords = await datasource.getFootprintRecordsByRoute('route-999');
          
          expect(nonExistentRecords, isEmpty);
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('deleteFootprintRecord', () {
      test('should delete specific record by ID', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test records
          final testRecords = [
            FootprintRecord(
              id: 'test-id-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
            ),
            FootprintRecord(
              id: 'test-id-002',
              routeId: 'route-001',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
            ),
          ];
          
          await datasource.saveFootprintRecords(testRecords);
          
          // Verify records exist
          final beforeDelete = await datasource.getAllFootprintRecords();
          expect(beforeDelete, hasLength(2));
          
          // Delete one record
          await datasource.deleteFootprintRecord('test-id-001');
          
          // Verify record was deleted
          final afterDelete = await datasource.getAllFootprintRecords();
          expect(afterDelete, hasLength(1));
          expect(afterDelete.first.id, equals('test-id-002'));
          
          // Try to delete non-existent record (should not throw)
          await datasource.deleteFootprintRecord('non-existent-id');
          
          // Verify count remains the same
          final afterNonExistent = await datasource.getAllFootprintRecords();
          expect(afterNonExistent, hasLength(1));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('deleteFootprintRecordsByRoute', () {
      test('should delete all records for specified route', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test records for different routes
          final testRecords = [
            FootprintRecord(
              id: 'test-id-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
            ),
            FootprintRecord(
              id: 'test-id-002',
              routeId: 'route-002',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
            ),
            FootprintRecord(
              id: 'test-id-003',
              routeId: 'route-001',
              latitude: 35.6764,
              longitude: 139.6505,
              direction: 47.0,
              speed: 1.4,
              accuracy: 7.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 2, 0),
            ),
          ];
          
          await datasource.saveFootprintRecords(testRecords);
          
          // Verify all records exist
          final beforeDelete = await datasource.getAllFootprintRecords();
          expect(beforeDelete, hasLength(3));
          
          // Delete records for route-001
          await datasource.deleteFootprintRecordsByRoute('route-001');
          
          // Verify only route-002 records remain
          final afterDelete = await datasource.getAllFootprintRecords();
          expect(afterDelete, hasLength(1));
          expect(afterDelete.first.routeId, equals('route-002'));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('deleteAllFootprintRecords', () {
      test('should delete all footprint records', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test records
          final testRecords = [
            FootprintRecord(
              id: 'test-id-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
            ),
            FootprintRecord(
              id: 'test-id-002',
              routeId: 'route-002',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
            ),
          ];
          
          await datasource.saveFootprintRecords(testRecords);
          
          // Verify records exist
          final beforeDelete = await datasource.getAllFootprintRecords();
          expect(beforeDelete, hasLength(2));
          
          // Delete all records
          await datasource.deleteAllFootprintRecords();
          
          // Verify all records are deleted
          final afterDelete = await datasource.getAllFootprintRecords();
          expect(afterDelete, isEmpty);
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('saveRoute', () {
      test('should save Route and retrieve it correctly', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test route with footprints
          final testFootprints = [
            FootprintRecord(
              id: 'footprint-001',
              routeId: 'route-001',
              latitude: 35.6762,
              longitude: 139.6503,
              direction: 45.0,
              speed: 1.2,
              accuracy: 5.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
            ),
            FootprintRecord(
              id: 'footprint-002',
              routeId: 'route-001',
              latitude: 35.6763,
              longitude: 139.6504,
              direction: 46.0,
              speed: 1.3,
              accuracy: 6.0,
              timestamp: DateTime.utc(2023, 1, 1, 10, 1, 0),
            ),
          ];
          
          final testRoute = Route(
            id: 'route-001',
            name: 'Test Route',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: testFootprints,
            totalDistance: 1000.0,
            averageSpeed: 1.5,
            duration: Duration(minutes: 10),
          );
          
          // Save the route
          await datasource.saveRoute(testRoute);
          
          // Verify route was saved
          final savedRoute = await datasource.getRoute('route-001');
          expect(savedRoute, isNotNull);
          expect(savedRoute!.id, equals(testRoute.id));
          expect(savedRoute.name, equals(testRoute.name));
          expect(savedRoute.startTime, equals(testRoute.startTime));
          expect(savedRoute.endTime, equals(testRoute.endTime));
          expect(savedRoute.totalDistance, equals(testRoute.totalDistance));
          expect(savedRoute.averageSpeed, equals(testRoute.averageSpeed));
          expect(savedRoute.duration, equals(testRoute.duration));
          
          // Verify footprints were saved
          expect(savedRoute.footprints, hasLength(2));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('getAllRoutes', () {
      test('should return all routes with footprints', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test routes
          final testRoute1 = Route(
            id: 'route-001',
            name: 'Route 1',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          final testRoute2 = Route(
            id: 'route-002',
            name: 'Route 2',
            startTime: DateTime.utc(2023, 1, 2, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 2, 10, 20, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-002',
                routeId: 'route-002',
                latitude: 35.6763,
                longitude: 139.6504,
                direction: 46.0,
                speed: 1.3,
                accuracy: 6.0,
                timestamp: DateTime.utc(2023, 1, 2, 10, 0, 0),
              ),
            ],
            totalDistance: 1000.0,
            averageSpeed: 1.5,
            duration: Duration(minutes: 10),
          );
          
          await datasource.saveRoute(testRoute1);
          await datasource.saveRoute(testRoute2);
          
          // Get all routes
          final allRoutes = await datasource.getAllRoutes();
          
          expect(allRoutes, hasLength(2));
          
          // Sort by id for consistent comparison
          allRoutes.sort((a, b) => a.id.compareTo(b.id));
          
          expect(allRoutes[0].id, equals('route-001'));
          expect(allRoutes[0].name, equals('Route 1'));
          expect(allRoutes[0].footprints, hasLength(1));
          
          expect(allRoutes[1].id, equals('route-002'));
          expect(allRoutes[1].name, equals('Route 2'));
          expect(allRoutes[1].footprints, hasLength(1));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('getRoute', () {
      test('should return specific route by ID', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          final testRoute = Route(
            id: 'route-001',
            name: 'Test Route',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          await datasource.saveRoute(testRoute);
          
          // Get existing route
          final existingRoute = await datasource.getRoute('route-001');
          expect(existingRoute, isNotNull);
          expect(existingRoute!.id, equals('route-001'));
          expect(existingRoute.name, equals('Test Route'));
          expect(existingRoute.footprints, hasLength(1));
          
          // Get non-existent route
          final nonExistentRoute = await datasource.getRoute('route-999');
          expect(nonExistentRoute, isNull);
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('deleteRoute', () {
      test('should delete route and its footprints', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          final testRoute = Route(
            id: 'route-001',
            name: 'Test Route',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          await datasource.saveRoute(testRoute);
          
          // Verify route and footprints exist
          final beforeDelete = await datasource.getRoute('route-001');
          expect(beforeDelete, isNotNull);
          
          final footprintsBefore = await datasource.getFootprintRecordsByRoute('route-001');
          expect(footprintsBefore, hasLength(1));
          
          // Delete route
          await datasource.deleteRoute('route-001');
          
          // Verify route is deleted
          final afterDelete = await datasource.getRoute('route-001');
          expect(afterDelete, isNull);
          
          // Verify footprints are also deleted
          final footprintsAfter = await datasource.getFootprintRecordsByRoute('route-001');
          expect(footprintsAfter, isEmpty);
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('deleteAllRoutes', () {
      test('should delete all routes and footprints', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Create test routes
          final testRoute1 = Route(
            id: 'route-001',
            name: 'Route 1',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          final testRoute2 = Route(
            id: 'route-002',
            name: 'Route 2',
            startTime: DateTime.utc(2023, 1, 2, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 2, 10, 20, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-002',
                routeId: 'route-002',
                latitude: 35.6763,
                longitude: 139.6504,
                direction: 46.0,
                speed: 1.3,
                accuracy: 6.0,
                timestamp: DateTime.utc(2023, 1, 2, 10, 0, 0),
              ),
            ],
            totalDistance: 1000.0,
            averageSpeed: 1.5,
            duration: Duration(minutes: 10),
          );
          
          await datasource.saveRoute(testRoute1);
          await datasource.saveRoute(testRoute2);
          
          // Verify routes and footprints exist
          final routesBefore = await datasource.getAllRoutes();
          expect(routesBefore, hasLength(2));
          
          final footprintsBefore = await datasource.getAllFootprintRecords();
          expect(footprintsBefore, hasLength(2));
          
          // Delete all routes
          await datasource.deleteAllRoutes();
          
          // Verify all routes are deleted
          final routesAfter = await datasource.getAllRoutes();
          expect(routesAfter, isEmpty);
          
          // Verify all footprints are also deleted
          final footprintsAfter = await datasource.getAllFootprintRecords();
          expect(footprintsAfter, isEmpty);
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('exportRouteToJson', () {
      test('should export route to JSON format', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          final testRoute = Route(
            id: 'route-001',
            name: 'Test Route',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          await datasource.saveRoute(testRoute);
          
          // Export existing route
          final jsonString = await datasource.exportRouteToJson('route-001');
          expect(jsonString, isNotEmpty);
          expect(jsonString, contains('route-001'));
          expect(jsonString, contains('Test Route'));
          
          // Export non-existent route
          final emptyJsonString = await datasource.exportRouteToJson('route-999');
          expect(emptyJsonString, equals('{}'));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('exportAllRoutesToJson', () {
      test('should export all routes to JSON format', () async {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);
          
          // Test with empty routes
          final emptyJsonString = await datasource.exportAllRoutesToJson();
          expect(emptyJsonString, equals('[]'));
          
          // Create test routes
          final testRoute1 = Route(
            id: 'route-001',
            name: 'Route 1',
            startTime: DateTime.utc(2023, 1, 1, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 1, 10, 10, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-001',
                routeId: 'route-001',
                latitude: 35.6762,
                longitude: 139.6503,
                direction: 45.0,
                speed: 1.2,
                accuracy: 5.0,
                timestamp: DateTime.utc(2023, 1, 1, 10, 0, 0),
              ),
            ],
            totalDistance: 500.0,
            averageSpeed: 1.0,
            duration: Duration(minutes: 5),
          );
          
          final testRoute2 = Route(
            id: 'route-002',
            name: 'Route 2',
            startTime: DateTime.utc(2023, 1, 2, 10, 0, 0),
            endTime: DateTime.utc(2023, 1, 2, 10, 20, 0),
            footprints: [
              FootprintRecord(
                id: 'footprint-002',
                routeId: 'route-002',
                latitude: 35.6763,
                longitude: 139.6504,
                direction: 46.0,
                speed: 1.3,
                accuracy: 6.0,
                timestamp: DateTime.utc(2023, 1, 2, 10, 0, 0),
              ),
            ],
            totalDistance: 1000.0,
            averageSpeed: 1.5,
            duration: Duration(minutes: 10),
          );
          
          await datasource.saveRoute(testRoute1);
          await datasource.saveRoute(testRoute2);
          
          // Export all routes
          final jsonString = await datasource.exportAllRoutesToJson();
          expect(jsonString, isNotEmpty);
          expect(jsonString, contains('route-001'));
          expect(jsonString, contains('route-002'));
          expect(jsonString, contains('Route 1'));
          expect(jsonString, contains('Route 2'));
          
          datasource.dispose();
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });

    group('dispose', () {
      test('should close the realm without throwing', () {
        try {
          final testRealm = Realm(Configuration.inMemory([
            FootprintRecordModel.schema,
            RouteModel.schema,
          ]));
          final datasource = RealmDatasourceImpl(testRealm);

          expect(() => datasource.dispose(), returnsNormally);
          expect(testRealm.isClosed, isTrue);
        } catch (e) {
          fail('Error occurred: $e');
        }
      });
    });
  });
}