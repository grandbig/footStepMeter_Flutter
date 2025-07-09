import 'package:realm/realm.dart';
import 'package:flutter/foundation.dart';
import '../model/footprint_record_model.dart';
import '../model/route_model.dart';
import '../../domain/entity/footprint_record.dart';
import '../../domain/entity/route.dart';
import 'dart:convert';

/// Realmデータベースへのデータアクセスを抽象化するインターフェース
/// 
/// 足跡記録とルートデータのRealmデータベース操作を定義します。
abstract interface class RealmDatasource {
  /// 単一の足跡記録を保存します。
  /// 
  /// [record] 保存する足跡記録
  Future<void> saveFootprintRecord(FootprintRecord record);
  
  /// 複数の足跡記録を一括保存します。
  /// 
  /// [records] 保存する足跡記録のリスト
  Future<void> saveFootprintRecords(List<FootprintRecord> records);
  
  /// 指定されたルートIDに関連する足跡記録を取得します。
  /// 
  /// [routeId] ルートID
  /// 戻り値: 指定されたルートに属する足跡記録のリスト
  Future<List<FootprintRecord>> getFootprintRecordsByRoute(String routeId);
  
  /// すべての足跡記録を取得します。
  /// 
  /// 戻り値: すべての足跡記録のリスト
  Future<List<FootprintRecord>> getAllFootprintRecords();
  
  /// 指定されたIDの足跡記録を削除します。
  /// 
  /// [id] 削除する足跡記録のID
  Future<void> deleteFootprintRecord(String id);
  
  /// 指定されたルートIDに関連するすべての足跡記録を削除します。
  /// 
  /// [routeId] ルートID
  Future<void> deleteFootprintRecordsByRoute(String routeId);
  
  /// すべての足跡記録を削除します。
  Future<void> deleteAllFootprintRecords();
  
  /// ルートを保存します。
  /// 
  /// [route] 保存するルート
  Future<void> saveRoute(Route route);
  
  /// すべてのルートを取得します。
  /// 
  /// 戻り値: すべてのルートのリスト
  Future<List<Route>> getAllRoutes();
  
  /// 指定されたIDのルートを取得します。
  /// 
  /// [routeId] ルートID
  /// 戻り値: 指定されたルート、存在しない場合はnull
  Future<Route?> getRoute(String routeId);
  
  /// 指定されたIDのルートを削除します。
  /// 
  /// [routeId] 削除するルートのID
  Future<void> deleteRoute(String routeId);
  
  /// すべてのルートを削除します。
  Future<void> deleteAllRoutes();
  
  /// 指定されたルートをJSON形式でエクスポートします。
  /// 
  /// [routeId] エクスポートするルートのID
  /// 戻り値: JSON形式のルートデータ
  Future<String> exportRouteToJson(String routeId);
  
  /// すべてのルートをJSON形式でエクスポートします。
  /// 
  /// 戻り値: JSON形式のすべてのルートデータ
  Future<String> exportAllRoutesToJson();
}

/// [RealmDatasource]の実装クラス
/// 
/// Realmデータベースを使用して足跡記録とルートデータの永続化を行います。
class RealmDatasourceImpl implements RealmDatasource {
  late final Realm _realm;
  
  /// コンストラクタ
  /// 
  /// [realm] テスト用にRealmインスタンスを注入可能にします。
  /// nullの場合は本番用のRealmインスタンスを作成します。
  RealmDatasourceImpl([Realm? realm]) {
    if (realm != null) {
      _realm = realm;
    } else {
      final config = Configuration.local([
        FootprintRecordModel.schema,
        RouteModel.schema,
      ]);
      _realm = Realm(config);
    }
  }
  
  @override
  Future<void> saveFootprintRecord(FootprintRecord record) async {
    final model = FootprintRecordModelExtension.fromEntity(record);
    _realm.write(() {
      _realm.add(model);
    });
  }
  
  @override
  Future<void> saveFootprintRecords(List<FootprintRecord> records) async {
    final models = records.map((record) => 
        FootprintRecordModelExtension.fromEntity(record)).toList();
    _realm.write(() {
      _realm.addAll(models);
    });
  }
  
  @override
  Future<List<FootprintRecord>> getFootprintRecordsByRoute(String routeId) async {
    final results = _realm.query<FootprintRecordModel>(
        'routeId == \$0', [routeId]);
    return results.map((model) => model.toEntity()).toList();
  }
  
  @override
  Future<List<FootprintRecord>> getAllFootprintRecords() async {
    final results = _realm.all<FootprintRecordModel>();
    return results.map((model) => model.toEntity()).toList();
  }
  
  @override
  Future<void> deleteFootprintRecord(String id) async {
    final record = _realm.find<FootprintRecordModel>(id);
    if (record != null) {
      _realm.write(() {
        _realm.delete(record);
      });
    }
  }
  
  @override
  Future<void> deleteFootprintRecordsByRoute(String routeId) async {
    final records = _realm.query<FootprintRecordModel>(
        'routeId == \$0', [routeId]);
    _realm.write(() {
      _realm.deleteMany(records);
    });
  }
  
  @override
  Future<void> deleteAllFootprintRecords() async {
    final records = _realm.all<FootprintRecordModel>();
    _realm.write(() {
      _realm.deleteMany(records);
    });
  }
  
  @override
  Future<void> saveRoute(Route route) async {
    final model = RouteModelExtension.fromEntity(route);
    _realm.write(() {
      _realm.add(model);
    });
    
    // 関連するfootprintRecordsも保存
    await saveFootprintRecords(route.footprints);
  }
  
  @override
  Future<List<Route>> getAllRoutes() async {
    final results = _realm.all<RouteModel>();
    final routes = <Route>[];
    
    for (final model in results) {
      final footprints = await getFootprintRecordsByRoute(model.id);
      routes.add(model.toEntity(footprints));
    }
    
    return routes;
  }
  
  @override
  Future<Route?> getRoute(String routeId) async {
    final model = _realm.find<RouteModel>(routeId);
    if (model == null) return null;
    
    final footprints = await getFootprintRecordsByRoute(routeId);
    return model.toEntity(footprints);
  }
  
  @override
  Future<void> deleteRoute(String routeId) async {
    final route = _realm.find<RouteModel>(routeId);
    if (route != null) {
      _realm.write(() {
        _realm.delete(route);
      });
    }
    
    // 関連するfootprintRecordsも削除
    await deleteFootprintRecordsByRoute(routeId);
  }
  
  @override
  Future<void> deleteAllRoutes() async {
    final routes = _realm.all<RouteModel>();
    _realm.write(() {
      _realm.deleteMany(routes);
    });
    
    // 関連するfootprintRecordsも削除
    await deleteAllFootprintRecords();
  }
  
  @override
  Future<String> exportRouteToJson(String routeId) async {
    final route = await getRoute(routeId);
    if (route == null) return '{}';
    
    return jsonEncode(route.toJson());
  }
  
  @override
  Future<String> exportAllRoutesToJson() async {
    final routes = await getAllRoutes();
    return jsonEncode(routes.map((route) => route.toJson()).toList());
  }
  
  /// リソースを解放します。
  /// 
  /// Realmデータベースへの接続を閉じます。
  void dispose() {
    _realm.close();
  }
}