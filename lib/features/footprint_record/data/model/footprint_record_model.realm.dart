// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footprint_record_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FootprintRecordModel extends _FootprintRecordModel
    with RealmEntity, RealmObjectBase, RealmObject {
  FootprintRecordModel(
    String id,
    String routeId,
    double latitude,
    double longitude,
    double direction,
    double speed,
    double accuracy,
    DateTime timestamp, {
    String? routeName,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'routeId', routeId);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'direction', direction);
    RealmObjectBase.set(this, 'speed', speed);
    RealmObjectBase.set(this, 'accuracy', accuracy);
    RealmObjectBase.set(this, 'timestamp', timestamp);
    RealmObjectBase.set(this, 'routeName', routeName);
  }

  FootprintRecordModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get routeId => RealmObjectBase.get<String>(this, 'routeId') as String;
  @override
  set routeId(String value) => RealmObjectBase.set(this, 'routeId', value);

  @override
  double get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double;
  @override
  set latitude(double value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double;
  @override
  set longitude(double value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  double get direction =>
      RealmObjectBase.get<double>(this, 'direction') as double;
  @override
  set direction(double value) => RealmObjectBase.set(this, 'direction', value);

  @override
  double get speed => RealmObjectBase.get<double>(this, 'speed') as double;
  @override
  set speed(double value) => RealmObjectBase.set(this, 'speed', value);

  @override
  double get accuracy =>
      RealmObjectBase.get<double>(this, 'accuracy') as double;
  @override
  set accuracy(double value) => RealmObjectBase.set(this, 'accuracy', value);

  @override
  DateTime get timestamp =>
      RealmObjectBase.get<DateTime>(this, 'timestamp') as DateTime;
  @override
  set timestamp(DateTime value) =>
      RealmObjectBase.set(this, 'timestamp', value);

  @override
  String? get routeName =>
      RealmObjectBase.get<String>(this, 'routeName') as String?;
  @override
  set routeName(String? value) => RealmObjectBase.set(this, 'routeName', value);

  @override
  Stream<RealmObjectChanges<FootprintRecordModel>> get changes =>
      RealmObjectBase.getChanges<FootprintRecordModel>(this);

  @override
  Stream<RealmObjectChanges<FootprintRecordModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<FootprintRecordModel>(this, keyPaths);

  @override
  FootprintRecordModel freeze() =>
      RealmObjectBase.freezeObject<FootprintRecordModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'routeId': routeId.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
      'direction': direction.toEJson(),
      'speed': speed.toEJson(),
      'accuracy': accuracy.toEJson(),
      'timestamp': timestamp.toEJson(),
      'routeName': routeName.toEJson(),
    };
  }

  static EJsonValue _toEJson(FootprintRecordModel value) => value.toEJson();
  static FootprintRecordModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'routeId': EJsonValue routeId,
        'latitude': EJsonValue latitude,
        'longitude': EJsonValue longitude,
        'direction': EJsonValue direction,
        'speed': EJsonValue speed,
        'accuracy': EJsonValue accuracy,
        'timestamp': EJsonValue timestamp,
      } =>
        FootprintRecordModel(
          fromEJson(id),
          fromEJson(routeId),
          fromEJson(latitude),
          fromEJson(longitude),
          fromEJson(direction),
          fromEJson(speed),
          fromEJson(accuracy),
          fromEJson(timestamp),
          routeName: fromEJson(ejson['routeName']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FootprintRecordModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, FootprintRecordModel, 'FootprintRecordModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('routeId', RealmPropertyType.string),
      SchemaProperty('latitude', RealmPropertyType.double),
      SchemaProperty('longitude', RealmPropertyType.double),
      SchemaProperty('direction', RealmPropertyType.double),
      SchemaProperty('speed', RealmPropertyType.double),
      SchemaProperty('accuracy', RealmPropertyType.double),
      SchemaProperty('timestamp', RealmPropertyType.timestamp),
      SchemaProperty('routeName', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
