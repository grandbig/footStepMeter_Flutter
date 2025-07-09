import '../entity/footprint_record.dart';

/// 位置情報の取得や追跡を扱うリポジトリインターフェース
/// 
/// GPSやネットワークベースの位置情報サービスを使用して、
/// ユーザーの位置情報を取得、追跡します。
abstract interface class LocationRepository {
  /// 現在の位置情報を取得します。
  /// 
  /// 成功した場合は[FootprintRecord]を返し、失敗した場合はnullを返します。
  Future<FootprintRecord?> getCurrentLocation();
  
  /// 位置情報の追跡を開始します。
  /// 
  /// 位置情報の更新をストリームで取得します。
  /// 追跡を停止するには[stopLocationTracking]を呼び出してください。
  Stream<FootprintRecord> startLocationTracking();
  
  /// 位置情報の追跡を停止します。
  Future<void> stopLocationTracking();
  
  /// 位置情報の使用許可を要求します。
  /// 
  /// ユーザーに位置情報の使用許可を求めるダイアログを表示します。
  /// 許可が得られた場合はtrue、拒否された場合はfalseを返します。
  Future<bool> requestLocationPermission();
  
  /// 位置情報の使用許可状態を確認します。
  /// 
  /// 許可が得られている場合はtrue、そうでない場合はfalseを返します。
  Future<bool> checkLocationPermission();
  
  /// 位置情報サービスが有効かどうかを確認します。
  /// 
  /// デバイスの位置情報サービスが有効な場合はtrue、無効な場合はfalseを返します。
  Future<bool> isLocationServiceEnabled();
}