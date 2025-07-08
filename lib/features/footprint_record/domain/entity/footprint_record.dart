import 'package:freezed_annotation/freezed_annotation.dart';

part 'footprint_record.freezed.dart';
part 'footprint_record.g.dart';

/// 足跡の記録を表すエンティティクラス
/// 
/// 位置情報（緯度、経度）、方向、速度、精度、タイムスタンプなどの
/// 歩行ルートの一点を記録する情報を保持します。
@freezed
class FootprintRecord with _$FootprintRecord {
  /// 足跡記録を作成します。
  ///
  /// [id] 記録のユニークID
  /// [routeId] 所属するルートのID
  /// [latitude] 緯度
  /// [longitude] 経度
  /// [direction] 方向（度数）
  /// [speed] 速度（m/s）
  /// [accuracy] 位置情報の精度（メートル）
  /// [timestamp] 記録した日時
  /// [routeName] ルート名（オプション）
  const factory FootprintRecord({
    required String id,
    required String routeId,
    required double latitude,
    required double longitude,
    required double direction,
    required double speed,
    required double accuracy,
    required DateTime timestamp,
    String? routeName,
  }) = _FootprintRecord;
  
  const FootprintRecord._();

  /// JSONからFootprintRecordを作成します。
  factory FootprintRecord.fromJson(Map<String, dynamic> json) =>
      _$FootprintRecordFromJson(json);
      
  /// 位置情報が有効かどうかを判定します。
  /// 
  /// 緯度と経度が有効な範囲内にあるかをチェックします。
  /// 緯度: -90 ≤ latitude ≤ 90
  /// 経度: -180 ≤ longitude ≤ 180
  bool isValidLocation() {
    return latitude >= -90 && latitude <= 90 && 
           longitude >= -180 && longitude <= 180;
  }
  
  /// 精度が高精度かどうかを判定します。
  /// 
  /// 精度が10メートル以下の場合を高精度とみなします。
  bool isHighAccuracy() {
    return accuracy <= 10.0;
  }
}