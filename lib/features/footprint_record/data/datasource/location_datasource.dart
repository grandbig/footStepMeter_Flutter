import 'package:geolocator/geolocator.dart';
import '../../domain/entity/footprint_record.dart';
import 'dart:async';
import 'dart:math' as math;

/// 位置情報サービスへのアクセスを抽象化するインターフェース
/// 
/// GPSやネットワークベースの位置情報サービスを使用した位置情報取得を定義します。
abstract interface class LocationDatasource {
  /// 現在の位置情報を取得します。
  /// 
  /// 戻り値: 現在の位置情報を含む[FootprintRecord]、取得できない場合はnull
  Future<FootprintRecord?> getCurrentLocation();
  
  /// 位置情報の継続的な追跡を開始します。
  /// 
  /// 戻り値: 位置情報の更新を配信する[Stream<FootprintRecord>]
  Stream<FootprintRecord> startLocationTracking();
  
  /// 位置情報の追跡を停止します。
  Future<void> stopLocationTracking();
  
  /// 位置情報の使用許可をリクエストします。
  /// 
  /// 戻り値: 許可が得られた場合はtrue、拒否された場合はfalse
  Future<bool> requestLocationPermission();
  
  /// 位置情報の使用許可の状態を確認します。
  /// 
  /// 戻り値: 許可されている場合はtrue、許可されていない場合はfalse
  Future<bool> checkLocationPermission();
  
  /// 位置情報サービスが有効になっているかを確認します。
  /// 
  /// 戻り値: 有効な場合はtrue、無効な場合はfalse
  Future<bool> isLocationServiceEnabled();
}

/// [LocationDatasource]の実装クラス
/// 
/// Geolocatorパッケージを使用して実際の位置情報取得を行います。
class LocationDatasourceImpl implements LocationDatasource {
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamController<FootprintRecord>? _locationStreamController;
  
  /// コンストラクタ
  /// 
  /// [_geolocator] テスト用にGeolocatorを注入可能にします
  LocationDatasourceImpl([GeolocatorPlatform? geolocator]) : _geolocator = geolocator ?? GeolocatorPlatform.instance;
  
  /// 注入されたGeolocatorインスタンス
  final GeolocatorPlatform _geolocator;
  
  @override
  Future<FootprintRecord?> getCurrentLocation() async {
    try {
      // 位置情報サービスが有効かチェック
      if (!await isLocationServiceEnabled()) {
        return null;
      }
      
      // 権限をチェック
      if (!await checkLocationPermission()) {
        return null;
      }
      
      final position = await _geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      
      return _positionToFootprintRecord(position);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Stream<FootprintRecord> startLocationTracking() {
    _locationStreamController = StreamController<FootprintRecord>();
    
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1, // 1メートル以上移動したら更新
    );
    
    _positionStreamSubscription = _geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        final footprint = _positionToFootprintRecord(position);
        _locationStreamController?.add(footprint);
      },
      onError: (error) {
        _locationStreamController?.addError(error);
      },
    );
    
    return _locationStreamController!.stream;
  }
  
  @override
  Future<void> stopLocationTracking() async {
    await _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    
    await _locationStreamController?.close();
    _locationStreamController = null;
  }
  
  @override
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await _geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
    }
    
    return permission == LocationPermission.whileInUse ||
           permission == LocationPermission.always;
  }
  
  @override
  Future<bool> checkLocationPermission() async {
    final permission = await _geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
           permission == LocationPermission.always;
  }
  
  @override
  Future<bool> isLocationServiceEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }
  
  /// PositionオブジェクトをFootprintRecordに変換します。
  /// 
  /// [position] Geolocatorから取得した位置情報
  /// 戻り値: 変換された[FootprintRecord]
  FootprintRecord _positionToFootprintRecord(Position position) {
    return FootprintRecord(
      id: _generateId(),
      routeId: '', // ルートIDは後で設定
      latitude: position.latitude,
      longitude: position.longitude,
      direction: position.heading,
      speed: position.speed,
      accuracy: position.accuracy,
      timestamp: DateTime.now(),
    );
  }
  
  /// ユニークなIDを生成します。
  /// 
  /// 現在時刻とランダム値を組み合わせてユニークIDを作成します。
  /// 戻り値: 生成されたID文字列
  String _generateId() {
    final now = DateTime.now();
    final random = math.Random();
    return '${now.millisecondsSinceEpoch}_${random.nextInt(1000)}';
  }
  
  /// リソースを解放します。
  /// 
  /// 位置情報の追跡を停止し、関連ストリームをクリーンアップします。
  void dispose() {
    stopLocationTracking();
  }
}