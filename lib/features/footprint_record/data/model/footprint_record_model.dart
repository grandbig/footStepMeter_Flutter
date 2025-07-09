import 'package:realm/realm.dart';
import '../../domain/entity/footprint_record.dart';

part 'footprint_record_model.realm.dart';

/// 足跡記録のRealmデータベースモデル
/// 
/// [FootprintRecord]エンティティをRealmデータベースに保存するためのデータモデルです。
@RealmModel()
class _FootprintRecordModel {
  /// 足跡記録のユニークID
  /// 
  /// プライマリキーとして使用され、各足跡記録を一意に識別します。
  @PrimaryKey()
  late String id;
  
  /// 所属するルートのID
  /// 
  /// この足跡記録が属するルートを識別するための外部キーです。
  late String routeId;
  
  /// 緯度
  /// 
  /// GPS座標の緯度を度数で記録します（-90 ≤ latitude ≤ 90）。
  late double latitude;
  
  /// 経度
  /// 
  /// GPS座標の経度を度数で記録します（-180 ≤ longitude ≤ 180）。
  late double longitude;
  
  /// 移動方向（度数）
  /// 
  /// 北を0度とした時計回りの方向を度数で記録します（0 ≤ direction < 360）。
  late double direction;
  
  /// 移動速度（m/s）
  /// 
  /// この地点での移動速度をメートル毎秒で記録します。
  late double speed;
  
  /// 位置情報の精度（メートル）
  /// 
  /// GPS測位の精度をメートル単位で記録します。値が小さいほど高精度です。
  late double accuracy;
  
  /// 記録日時
  /// 
  /// この足跡記録が作成された日時です。
  late DateTime timestamp;
  
  /// ルート名（オプション）
  /// 
  /// 所属するルートの名前です。パフォーマンス向上のため冗長に保存されます。
  late String? routeName;
}

/// [FootprintRecordModel]と[FootprintRecord]の変換を行う拡張メソッド
extension FootprintRecordModelExtension on FootprintRecordModel {
  /// RealmモデルからDomainエンティティに変換します。
  /// 
  /// 戻り値: [FootprintRecord]エンティティ
  FootprintRecord toEntity() {
    return FootprintRecord(
      id: id,
      routeId: routeId,
      latitude: latitude,
      longitude: longitude,
      direction: direction,
      speed: speed,
      accuracy: accuracy,
      timestamp: timestamp,
      routeName: routeName,
    );
  }
  
  /// DomainエンティティからRealmモデルに変換します。
  /// 
  /// [entity] 変換する[FootprintRecord]エンティティ
  /// 戻り値: [FootprintRecordModel]インスタンス
  static FootprintRecordModel fromEntity(FootprintRecord entity) {
    return FootprintRecordModel(
      entity.id,
      entity.routeId,
      entity.latitude,
      entity.longitude,
      entity.direction,
      entity.speed,
      entity.accuracy,
      entity.timestamp,
      routeName: entity.routeName,
    );
  }
}