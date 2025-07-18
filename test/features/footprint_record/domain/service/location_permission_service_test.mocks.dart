// Mocks generated by Mockito 5.4.5 from annotations
// in foot_step_meter/test/features/footprint_record/domain/service/location_permission_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:foot_step_meter/features/footprint_record/domain/entity/footprint_record.dart'
    as _i4;
import 'package:foot_step_meter/features/footprint_record/domain/repository/location_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [LocationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationRepository extends _i1.Mock
    implements _i2.LocationRepository {
  @override
  _i3.Future<_i4.FootprintRecord?> getCurrentLocation() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentLocation,
          [],
        ),
        returnValue: _i3.Future<_i4.FootprintRecord?>.value(),
        returnValueForMissingStub: _i3.Future<_i4.FootprintRecord?>.value(),
      ) as _i3.Future<_i4.FootprintRecord?>);

  @override
  _i3.Stream<_i4.FootprintRecord> startLocationTracking() =>
      (super.noSuchMethod(
        Invocation.method(
          #startLocationTracking,
          [],
        ),
        returnValue: _i3.Stream<_i4.FootprintRecord>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.FootprintRecord>.empty(),
      ) as _i3.Stream<_i4.FootprintRecord>);

  @override
  _i3.Future<void> stopLocationTracking() => (super.noSuchMethod(
        Invocation.method(
          #stopLocationTracking,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> requestLocationPermission() => (super.noSuchMethod(
        Invocation.method(
          #requestLocationPermission,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<bool> checkLocationPermission() => (super.noSuchMethod(
        Invocation.method(
          #checkLocationPermission,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<bool> isLocationServiceEnabled() => (super.noSuchMethod(
        Invocation.method(
          #isLocationServiceEnabled,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
