import '../../domain/entity/footprint_record.dart';
import '../../domain/repository/location_repository.dart';
import '../datasource/location_datasource.dart';

/// [LocationRepository]の実装クラス
/// 
/// [LocationDatasource]を使用して位置情報関連のビジネスロジックを実装します。
class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource _locationDatasource;
  
  /// コンストラクタ
  /// 
  /// [_locationDatasource] 位置情報データソースの実装
  LocationRepositoryImpl(this._locationDatasource);
  
  @override
  Future<FootprintRecord?> getCurrentLocation() async {
    return await _locationDatasource.getCurrentLocation();
  }
  
  @override
  Stream<FootprintRecord> startLocationTracking() {
    return _locationDatasource.startLocationTracking();
  }
  
  @override
  Future<void> stopLocationTracking() async {
    await _locationDatasource.stopLocationTracking();
  }
  
  @override
  Future<bool> requestLocationPermission() async {
    return await _locationDatasource.requestLocationPermission();
  }
  
  @override
  Future<bool> checkLocationPermission() async {
    return await _locationDatasource.checkLocationPermission();
  }
  
  @override
  Future<bool> isLocationServiceEnabled() async {
    return await _locationDatasource.isLocationServiceEnabled();
  }
}