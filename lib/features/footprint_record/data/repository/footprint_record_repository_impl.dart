import '../../domain/entity/footprint_record.dart';
import '../../domain/entity/route.dart';
import '../../domain/repository/footprint_record_repository.dart';
import '../datasource/realm_datasource.dart';

/// [FootprintRecordRepository]の実装クラス
/// 
/// [RealmDatasource]を使用して足跡記録とルートデータの永続化ロジックを実装します。
class FootprintRecordRepositoryImpl implements FootprintRecordRepository {
  final RealmDatasource _realmDatasource;
  
  /// コンストラクタ
  /// 
  /// [_realmDatasource] Realmデータソースの実装
  FootprintRecordRepositoryImpl(this._realmDatasource);
  
  @override
  Future<void> saveFootprintRecord(FootprintRecord record) async {
    await _realmDatasource.saveFootprintRecord(record);
  }
  
  @override
  Future<void> saveFootprintRecords(List<FootprintRecord> records) async {
    await _realmDatasource.saveFootprintRecords(records);
  }
  
  @override
  Future<List<FootprintRecord>> getFootprintRecordsByRoute(String routeId) async {
    return await _realmDatasource.getFootprintRecordsByRoute(routeId);
  }
  
  @override
  Future<List<FootprintRecord>> getAllFootprintRecords() async {
    return await _realmDatasource.getAllFootprintRecords();
  }
  
  @override
  Future<void> deleteFootprintRecord(String id) async {
    await _realmDatasource.deleteFootprintRecord(id);
  }
  
  @override
  Future<void> deleteFootprintRecordsByRoute(String routeId) async {
    await _realmDatasource.deleteFootprintRecordsByRoute(routeId);
  }
  
  @override
  Future<void> deleteAllFootprintRecords() async {
    await _realmDatasource.deleteAllFootprintRecords();
  }
  
  @override
  Future<void> saveRoute(Route route) async {
    await _realmDatasource.saveRoute(route);
  }
  
  @override
  Future<List<Route>> getAllRoutes() async {
    return await _realmDatasource.getAllRoutes();
  }
  
  @override
  Future<Route?> getRoute(String routeId) async {
    return await _realmDatasource.getRoute(routeId);
  }
  
  @override
  Future<void> deleteRoute(String routeId) async {
    await _realmDatasource.deleteRoute(routeId);
  }
  
  @override
  Future<void> deleteAllRoutes() async {
    await _realmDatasource.deleteAllRoutes();
  }
  
  @override
  Future<String> exportRouteToJson(String routeId) async {
    return await _realmDatasource.exportRouteToJson(routeId);
  }
  
  @override
  Future<String> exportAllRoutesToJson() async {
    return await _realmDatasource.exportAllRoutesToJson();
  }
}