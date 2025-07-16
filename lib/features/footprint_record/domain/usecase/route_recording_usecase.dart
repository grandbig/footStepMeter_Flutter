import 'dart:async';
import '../entity/footprint_record.dart';
import '../entity/route.dart';
import '../repository/location_repository.dart';
import '../repository/footprint_record_repository.dart';
import '../error/location_error.dart';
import '../../../../core/result.dart';
import '../service/location_permission_service.dart';

/// ルートの記録を管理するユースケース
///
/// 位置情報の追跡を開始・停止し、歩行ルートを記録・保存します。
/// 記録中は継続的に位置情報を取得してFootprintRecordとして保存し、
/// 停止時にはルート統計を計算してRouteとして保存します。
class RouteRecordingUseCase {
  final LocationRepository _locationRepository;
  final FootprintRecordRepository _footprintRecordRepository;
  final LocationPermissionService _permissionService;

  RouteRecordingUseCase(
    this._locationRepository,
    this._footprintRecordRepository,
    this._permissionService,
  );

  /// ルート記録の状態を示すフラグ
  /// 
  /// true: 記録中、false: 記録停止中
  bool _isRecording = false;
  
  /// 現在記録中のルートID
  /// 
  /// 記録開始時に生成されるユニークなID。
  /// 記録停止中はnull。
  String? _currentRouteId;
  
  /// 現在記録中のルート名
  /// 
  /// ユーザーが指定したルート名を保持。
  /// 記録停止中はnull。
  String? _currentRouteName;
  
  /// 位置情報ストリームの購読
  /// 
  /// 位置情報の追跡を開始した際のStreamSubscription。
  /// 記録停止時にキャンセルするために使用。
  StreamSubscription<FootprintRecord>? _locationSubscription;
  
  /// 現在の記録中の足跡データ
  /// 
  /// 記録開始から現在までに取得した全てのFootprintRecordを保持。
  /// 記録停止時にルート統計の計算に使用される。
  final List<FootprintRecord> _currentFootprints = [];
  
  /// 記録開始時刻
  /// 
  /// ルート記録を開始した日時。
  /// 記録停止時の所要時間計算に使用。
  DateTime? _startTime;

  /// ルート記録を開始します
  /// 
  /// 位置情報の権限をチェックし、権限が許可されている場合は
  /// 新しいルートの記録を開始します。
  /// 
  /// [routeName] 記録するルート名
  /// 
  /// Returns:
  /// - 成功時: true を含む Result
  /// - 失敗時: LocationError を含む Result
  Future<Result<bool, LocationError>> startRecording(String routeName) async {
    if (_isRecording) {
      return const Result.failure(LocationError.alreadyRecording);
    }

    final accessResult = await _permissionService.checkLocationAccess();
    if (accessResult.isFailure) {
      return Result.failure(accessResult.error!);
    }

    _currentRouteId = DateTime.now().millisecondsSinceEpoch.toString();
    _currentRouteName = routeName;
    _startTime = DateTime.now();
    _currentFootprints.clear();
    _isRecording = true;

    final locationStream = _locationRepository.startLocationTracking();
    _locationSubscription = locationStream.listen((footprint) {
      final updatedFootprint = footprint.copyWith(
        routeId: _currentRouteId!,
        routeName: _currentRouteName,
      );
      _currentFootprints.add(updatedFootprint);
    });

    return const Result.success(true);
  }

  /// ルート記録を停止します
  /// 
  /// 位置情報の追跡を停止し、記録されたFootprintRecordから
  /// ルート統計を計算してRouteとして保存します。
  /// 
  /// Returns:
  /// - 成功時: 作成されたRoute を含む Result
  /// - 失敗時: LocationError を含む Result
  Future<Result<Route, LocationError>> stopRecording() async {
    if (!_isRecording) {
      return const Result.failure(LocationError.notRecording);
    }

    await _locationRepository.stopLocationTracking();
    await _locationSubscription?.cancel();
    _locationSubscription = null;

    final endTime = DateTime.now();
    final duration = endTime.difference(_startTime!);
    
    // 統計計算（簡略化）
    double totalDistance = 0.0;
    double averageSpeed = 0.0;
    
    if (_currentFootprints.isNotEmpty) {
      averageSpeed = _currentFootprints
          .map((f) => f.speed)
          .reduce((a, b) => a + b) / _currentFootprints.length;
      
      // 簡略化: 実際は地点間の距離を計算
      totalDistance = _currentFootprints.length * 10.0; // 仮の距離計算
    }

    final route = Route(
      id: _currentRouteId!,
      name: _currentRouteName!,
      startTime: _startTime!,
      endTime: endTime,
      footprints: List.from(_currentFootprints),
      totalDistance: totalDistance,
      averageSpeed: averageSpeed,
      duration: duration,
    );

    await _footprintRecordRepository.saveRoute(route);

    // 状態をリセット
    _isRecording = false;
    _currentRouteId = null;
    _currentRouteName = null;
    _startTime = null;
    _currentFootprints.clear();

    return Result.success(route);
  }
}