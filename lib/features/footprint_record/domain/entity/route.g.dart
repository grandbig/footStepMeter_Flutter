// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteImpl _$$RouteImplFromJson(Map<String, dynamic> json) => _$RouteImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      footprints: (json['footprints'] as List<dynamic>)
          .map((e) => FootprintRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDistance: (json['total_distance'] as num).toDouble(),
      averageSpeed: (json['average_speed'] as num).toDouble(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$$RouteImplToJson(_$RouteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'footprints': instance.footprints.map((e) => e.toJson()).toList(),
      'total_distance': instance.totalDistance,
      'average_speed': instance.averageSpeed,
      'duration': instance.duration.inMicroseconds,
    };
