import '../repository/location_repository.dart';
import '../error/location_error.dart';
import '../../../../core/result.dart';

/// 位置情報アクセスの権限と利用可能性をチェックするヘルパークラス
///
/// このクラスは複数のUseCaseで共通して使用される位置情報アクセス権限の確認ロジックを
/// カプセル化します。権限の確認とサービスの有効性確認を組み合わせて、
/// 位置情報を安全に利用できる状態かどうかを判定します。
class LocationPermissionChecker {
  final LocationRepository _locationRepository;

  /// LocationPermissionCheckerを初期化します
  LocationPermissionChecker(this._locationRepository);

  /// 位置情報へのアクセスが可能かどうかをチェックします
  ///
  /// このメソッドは以下の順序で確認を行います：
  /// 1. アプリに位置情報の使用許可が与えられているか
  /// 2. デバイスの位置情報サービスが有効になっているか
  ///
  /// どちらかの条件が満たされていない場合、対応するエラーを返します。
  /// 両方の条件が満たされている場合のみ、成功を返します。
  Future<Result<void, LocationError>> checkLocationAccess() async {
    final hasPermission = await _locationRepository.checkLocationPermission();
    if (!hasPermission) {
      return const Result.failure(LocationError.permissionDenied);
    }

    final isServiceEnabled = await _locationRepository.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return const Result.failure(LocationError.serviceDisabled);
    }

    return const Result.success(null);
  }
}