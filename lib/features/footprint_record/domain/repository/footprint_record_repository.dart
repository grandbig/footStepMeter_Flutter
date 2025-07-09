import '../entity/footprint_record.dart';
import '../entity/route.dart';

/// 足跡記録とルートデータの永続化を扱うリポジトリインターフェース
/// 
/// ローカルデータベースに足跡記録とルート情報を保存、取得、削除、
/// エクスポートする機能を提供します。
abstract interface class FootprintRecordRepository {
  /// 足跡記録を保存します。
  /// 
  /// [record] 保存する足跡記録
  Future<void> saveFootprintRecord(FootprintRecord record);
  
  /// 複数の足跡記録を一括保存します。
  /// 
  /// [records] 保存する足跡記録のリスト
  Future<void> saveFootprintRecords(List<FootprintRecord> records);
  
  /// 特定のルートIDの足跡記録を取得します。
  /// 
  /// [routeId] ルートのID
  /// 戻り値: 足跡記録のリスト
  Future<List<FootprintRecord>> getFootprintRecordsByRoute(String routeId);
  
  /// 全ての足跡記録を取得します。
  /// 
  /// 戻り値: 全ての足跡記録のリスト
  Future<List<FootprintRecord>> getAllFootprintRecords();
  
  /// 足跡記録を削除します。
  /// 
  /// [id] 削除する足跡記録のID
  Future<void> deleteFootprintRecord(String id);
  
  /// 特定のルートの足跡記録を削除します。
  /// 
  /// [routeId] ルートのID
  Future<void> deleteFootprintRecordsByRoute(String routeId);
  
  /// 全ての足跡記録を削除します。
  Future<void> deleteAllFootprintRecords();
  
  /// ルートを保存します。
  /// 
  /// [route] 保存するルート
  Future<void> saveRoute(Route route);
  
  /// 全てのルートを取得します。
  /// 
  /// 戻り値: 全てのルートのリスト
  Future<List<Route>> getAllRoutes();
  
  /// 特定のルートを取得します。
  /// 
  /// [routeId] ルートのID
  /// 戻り値: ルート、または見つからない場合はnull
  Future<Route?> getRoute(String routeId);
  
  /// ルートを削除します。
  /// 
  /// [routeId] 削除するルートのID
  Future<void> deleteRoute(String routeId);
  
  /// 全てのルートを削除します。
  Future<void> deleteAllRoutes();
  
  /// ルートをJSON形式でエクスポートします。
  /// 
  /// メール送信などで使用されるデータエクスポート機能です。
  /// 
  /// [routeId] エクスポートするルートのID
  /// 戻り値: JSON形式の文字列
  Future<String> exportRouteToJson(String routeId);
  
  /// 全てのルートをJSON形式でエクスポートします。
  /// 
  /// 戻り値: 全ルートのJSON形式の文字列
  Future<String> exportAllRoutesToJson();
}