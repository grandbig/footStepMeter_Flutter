// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footprint_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FootprintRecordImpl _$$FootprintRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$FootprintRecordImpl(
      id: json['id'] as String,
      routeId: json['route_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      direction: (json['direction'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      routeName: json['route_name'] as String?,
    );

Map<String, dynamic> _$$FootprintRecordImplToJson(
        _$FootprintRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'route_id': instance.routeId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'direction': instance.direction,
      'speed': instance.speed,
      'accuracy': instance.accuracy,
      'timestamp': instance.timestamp.toIso8601String(),
      if (instance.routeName case final value?) 'route_name': value,
    };
