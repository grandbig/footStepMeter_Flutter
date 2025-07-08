// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Route _$RouteFromJson(Map<String, dynamic> json) {
  return _Route.fromJson(json);
}

/// @nodoc
mixin _$Route {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  List<FootprintRecord> get footprints => throw _privateConstructorUsedError;
  double get totalDistance => throw _privateConstructorUsedError;
  double get averageSpeed => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  /// Serializes this Route to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteCopyWith<Route> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteCopyWith<$Res> {
  factory $RouteCopyWith(Route value, $Res Function(Route) then) =
      _$RouteCopyWithImpl<$Res, Route>;
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime startTime,
      DateTime endTime,
      List<FootprintRecord> footprints,
      double totalDistance,
      double averageSpeed,
      Duration duration});
}

/// @nodoc
class _$RouteCopyWithImpl<$Res, $Val extends Route>
    implements $RouteCopyWith<$Res> {
  _$RouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? footprints = null,
    Object? totalDistance = null,
    Object? averageSpeed = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      footprints: null == footprints
          ? _value.footprints
          : footprints // ignore: cast_nullable_to_non_nullable
              as List<FootprintRecord>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeed: null == averageSpeed
          ? _value.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteImplCopyWith<$Res> implements $RouteCopyWith<$Res> {
  factory _$$RouteImplCopyWith(
          _$RouteImpl value, $Res Function(_$RouteImpl) then) =
      __$$RouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime startTime,
      DateTime endTime,
      List<FootprintRecord> footprints,
      double totalDistance,
      double averageSpeed,
      Duration duration});
}

/// @nodoc
class __$$RouteImplCopyWithImpl<$Res>
    extends _$RouteCopyWithImpl<$Res, _$RouteImpl>
    implements _$$RouteImplCopyWith<$Res> {
  __$$RouteImplCopyWithImpl(
      _$RouteImpl _value, $Res Function(_$RouteImpl) _then)
      : super(_value, _then);

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? footprints = null,
    Object? totalDistance = null,
    Object? averageSpeed = null,
    Object? duration = null,
  }) {
    return _then(_$RouteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      footprints: null == footprints
          ? _value._footprints
          : footprints // ignore: cast_nullable_to_non_nullable
              as List<FootprintRecord>,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      averageSpeed: null == averageSpeed
          ? _value.averageSpeed
          : averageSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteImpl extends _Route {
  const _$RouteImpl(
      {required this.id,
      required this.name,
      required this.startTime,
      required this.endTime,
      required final List<FootprintRecord> footprints,
      required this.totalDistance,
      required this.averageSpeed,
      required this.duration})
      : _footprints = footprints,
        super._();

  factory _$RouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  final List<FootprintRecord> _footprints;
  @override
  List<FootprintRecord> get footprints {
    if (_footprints is EqualUnmodifiableListView) return _footprints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_footprints);
  }

  @override
  final double totalDistance;
  @override
  final double averageSpeed;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'Route(id: $id, name: $name, startTime: $startTime, endTime: $endTime, footprints: $footprints, totalDistance: $totalDistance, averageSpeed: $averageSpeed, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other._footprints, _footprints) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.averageSpeed, averageSpeed) ||
                other.averageSpeed == averageSpeed) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(_footprints),
      totalDistance,
      averageSpeed,
      duration);

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      __$$RouteImplCopyWithImpl<_$RouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteImplToJson(
      this,
    );
  }
}

abstract class _Route extends Route {
  const factory _Route(
      {required final String id,
      required final String name,
      required final DateTime startTime,
      required final DateTime endTime,
      required final List<FootprintRecord> footprints,
      required final double totalDistance,
      required final double averageSpeed,
      required final Duration duration}) = _$RouteImpl;
  const _Route._() : super._();

  factory _Route.fromJson(Map<String, dynamic> json) = _$RouteImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  List<FootprintRecord> get footprints;
  @override
  double get totalDistance;
  @override
  double get averageSpeed;
  @override
  Duration get duration;

  /// Create a copy of Route
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteImplCopyWith<_$RouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
