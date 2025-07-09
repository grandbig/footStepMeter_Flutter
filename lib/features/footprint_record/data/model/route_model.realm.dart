// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RouteModel extends _RouteModel
    with RealmEntity, RealmObjectBase, RealmObject {
  RouteModel(
    String id,
    String name,
    DateTime startTime,
    DateTime endTime,
    double totalDistance,
    double averageSpeed,
    int durationInSeconds,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'startTime', startTime);
    RealmObjectBase.set(this, 'endTime', endTime);
    RealmObjectBase.set(this, 'totalDistance', totalDistance);
    RealmObjectBase.set(this, 'averageSpeed', averageSpeed);
    RealmObjectBase.set(this, 'durationInSeconds', durationInSeconds);
  }

  RouteModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  DateTime get startTime =>
      RealmObjectBase.get<DateTime>(this, 'startTime') as DateTime;
  @override
  set startTime(DateTime value) =>
      RealmObjectBase.set(this, 'startTime', value);

  @override
  DateTime get endTime =>
      RealmObjectBase.get<DateTime>(this, 'endTime') as DateTime;
  @override
  set endTime(DateTime value) => RealmObjectBase.set(this, 'endTime', value);

  @override
  double get totalDistance =>
      RealmObjectBase.get<double>(this, 'totalDistance') as double;
  @override
  set totalDistance(double value) =>
      RealmObjectBase.set(this, 'totalDistance', value);

  @override
  double get averageSpeed =>
      RealmObjectBase.get<double>(this, 'averageSpeed') as double;
  @override
  set averageSpeed(double value) =>
      RealmObjectBase.set(this, 'averageSpeed', value);

  @override
  int get durationInSeconds =>
      RealmObjectBase.get<int>(this, 'durationInSeconds') as int;
  @override
  set durationInSeconds(int value) =>
      RealmObjectBase.set(this, 'durationInSeconds', value);

  @override
  Stream<RealmObjectChanges<RouteModel>> get changes =>
      RealmObjectBase.getChanges<RouteModel>(this);

  @override
  Stream<RealmObjectChanges<RouteModel>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RouteModel>(this, keyPaths);

  @override
  RouteModel freeze() => RealmObjectBase.freezeObject<RouteModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'startTime': startTime.toEJson(),
      'endTime': endTime.toEJson(),
      'totalDistance': totalDistance.toEJson(),
      'averageSpeed': averageSpeed.toEJson(),
      'durationInSeconds': durationInSeconds.toEJson(),
    };
  }

  static EJsonValue _toEJson(RouteModel value) => value.toEJson();
  static RouteModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'startTime': EJsonValue startTime,
        'endTime': EJsonValue endTime,
        'totalDistance': EJsonValue totalDistance,
        'averageSpeed': EJsonValue averageSpeed,
        'durationInSeconds': EJsonValue durationInSeconds,
      } =>
        RouteModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(startTime),
          fromEJson(endTime),
          fromEJson(totalDistance),
          fromEJson(averageSpeed),
          fromEJson(durationInSeconds),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RouteModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RouteModel, 'RouteModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('startTime', RealmPropertyType.timestamp),
      SchemaProperty('endTime', RealmPropertyType.timestamp),
      SchemaProperty('totalDistance', RealmPropertyType.double),
      SchemaProperty('averageSpeed', RealmPropertyType.double),
      SchemaProperty('durationInSeconds', RealmPropertyType.int),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
