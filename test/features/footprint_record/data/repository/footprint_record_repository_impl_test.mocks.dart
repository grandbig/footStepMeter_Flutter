// Mocks generated by Mockito 5.4.5 from annotations
// in foot_step_meter/test/features/footprint_record/data/repository/footprint_record_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:foot_step_meter/features/footprint_record/data/datasource/realm_datasource.dart'
    as _i2;
import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart'
    as _i4;
import 'package:foot_step_meter/features/footprint_record/domain/entity/route.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [RealmDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRealmDatasource extends _i1.Mock implements _i2.RealmDatasource {
  MockRealmDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> saveFootprintRecord(_i4.FootprintRecord? record) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFootprintRecord,
          [record],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> saveFootprintRecords(List<_i4.FootprintRecord>? records) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFootprintRecords,
          [records],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i4.FootprintRecord>> getFootprintRecordsByRoute(
          String? routeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFootprintRecordsByRoute,
          [routeId],
        ),
        returnValue: _i3.Future<List<_i4.FootprintRecord>>.value(
            <_i4.FootprintRecord>[]),
      ) as _i3.Future<List<_i4.FootprintRecord>>);

  @override
  _i3.Future<List<_i4.FootprintRecord>> getAllFootprintRecords() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllFootprintRecords,
          [],
        ),
        returnValue: _i3.Future<List<_i4.FootprintRecord>>.value(
            <_i4.FootprintRecord>[]),
      ) as _i3.Future<List<_i4.FootprintRecord>>);

  @override
  _i3.Future<void> deleteFootprintRecord(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteFootprintRecord,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteFootprintRecordsByRoute(String? routeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteFootprintRecordsByRoute,
          [routeId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteAllFootprintRecords() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllFootprintRecords,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> saveRoute(_i5.Route? route) => (super.noSuchMethod(
        Invocation.method(
          #saveRoute,
          [route],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i5.Route>> getAllRoutes() => (super.noSuchMethod(
        Invocation.method(
          #getAllRoutes,
          [],
        ),
        returnValue: _i3.Future<List<_i5.Route>>.value(<_i5.Route>[]),
      ) as _i3.Future<List<_i5.Route>>);

  @override
  _i3.Future<_i5.Route?> getRoute(String? routeId) => (super.noSuchMethod(
        Invocation.method(
          #getRoute,
          [routeId],
        ),
        returnValue: _i3.Future<_i5.Route?>.value(),
      ) as _i3.Future<_i5.Route?>);

  @override
  _i3.Future<void> deleteRoute(String? routeId) => (super.noSuchMethod(
        Invocation.method(
          #deleteRoute,
          [routeId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteAllRoutes() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllRoutes,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<String> exportRouteToJson(String? routeId) => (super.noSuchMethod(
        Invocation.method(
          #exportRouteToJson,
          [routeId],
        ),
        returnValue: _i3.Future<String>.value(_i6.dummyValue<String>(
          this,
          Invocation.method(
            #exportRouteToJson,
            [routeId],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<String> exportAllRoutesToJson() => (super.noSuchMethod(
        Invocation.method(
          #exportAllRoutesToJson,
          [],
        ),
        returnValue: _i3.Future<String>.value(_i6.dummyValue<String>(
          this,
          Invocation.method(
            #exportAllRoutesToJson,
            [],
          ),
        )),
      ) as _i3.Future<String>);
}
