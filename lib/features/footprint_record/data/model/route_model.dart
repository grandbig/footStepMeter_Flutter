import 'package:realm/realm.dart';
import '../../domain/entity/route.dart';
import '../../domain/entity/footprint_record.dart';

part 'route_model.realm.dart';

/// ルートのRealmデータベースモデル
/// 
/// [Route]エンティティをRealmデータベースに保存するためのデータモデルです。
/// 足跡記録のリストは別途管理され、ルートIDで関連付けられます。
@RealmModel()
class _RouteModel {
  /// ルートのユニークID
  /// 
  /// プライマリキーとして使用され、他のテーブルとの関連付けに使用されます。
  @PrimaryKey()
  late String id;
  
  /// ルート名
  /// 
  /// ユーザーが設定する表示用のルート名です。
  late String name;
  
  /// ルート開始日時
  /// 
  /// 歩行を開始した日時を記録します。
  late DateTime startTime;
  
  /// ルート終了日時
  /// 
  /// 歩行を終了した日時を記録します。
  late DateTime endTime;
  
  /// 総距離（メートル）
  /// 
  /// このルートで歩行した総距離をメートル単位で記録します。
  late double totalDistance;
  
  /// 平均速度（m/s）
  /// 
  /// このルートでの平均歩行速度をメートル毎秒で記録します。
  late double averageSpeed;
  
  /// 所要時間（秒）
  /// 
  /// ルートの歩行にかかった時間を秒単位で記録します。
  /// Durationオブジェクトはプリミティブ型ではないため、秒数として保存します。
  late int durationInSeconds;
}

/// [RouteModel]と[Route]の変換を行う拡張メソッド
extension RouteModelExtension on RouteModel {
  /// RealmモデルからDomainエンティティに変換します。
  /// 
  /// [footprints] このルートに関連する足跡記録のリスト
  /// 戻り値: [Route]エンティティ
  Route toEntity(List<FootprintRecord> footprints) {
    return Route(
      id: id,
      name: name,
      startTime: startTime,
      endTime: endTime,
      footprints: footprints,
      totalDistance: totalDistance,
      averageSpeed: averageSpeed,
      duration: Duration(seconds: durationInSeconds),
    );
  }
  
  /// DomainエンティティからRealmモデルに変換します。
  /// 
  /// [entity] 変換する[Route]エンティティ
  /// 戻り値: [RouteModel]インスタンス
  static RouteModel fromEntity(Route entity) {
    return RouteModel(
      entity.id,
      entity.name,
      entity.startTime,
      entity.endTime,
      entity.totalDistance,
      entity.averageSpeed,
      entity.duration.inSeconds,
    );
  }
}