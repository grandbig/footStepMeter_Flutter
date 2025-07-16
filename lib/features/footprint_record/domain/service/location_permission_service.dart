import '../repository/location_repository.dart';
import '../error/location_error.dart';
import '../../../../core/result.dart';

/// 位置情報アクセスの権限と利用可能性をチェックするドメインサービス
///
/// このサービスは複数のUseCaseで共通して使用される位置情報アクセス権限の確認ロジックを
/// カプセル化します。権限の確認とサービスの有効性確認を組み合わせて、
/// 位置情報を安全に利用できる状態かどうかを判定します。
/// 
/// Domain Serviceとして、特定のUseCaseに依存せず、
/// 位置情報に関するドメインロジックを提供します。
class LocationPermissionService {
  final LocationRepository _locationRepository;

  /// LocationPermissionServiceを初期化します
  /// 
  /// [_locationRepository] 位置情報リポジトリの実装
  LocationPermissionService(this._locationRepository);

  /// 位置情報へのアクセスが可能かどうかをチェックします
  ///
  /// このメソッドは以下の順序で確認を行います：
  /// 1. アプリに位置情報の使用許可が与えられているか
  /// 2. デバイスの位置情報サービスが有効になっているか
  ///
  /// どちらかの条件が満たされていない場合、対応するエラーを返します。
  /// 両方の条件が満たされている場合のみ、成功を返します。
  /// 
  /// Returns:
  /// - 成功時: void を含む Result
  /// - 失敗時: LocationError を含む Result
  ///   - LocationError.permissionDenied: 位置情報の使用許可がない
  ///   - LocationError.serviceDisabled: 位置情報サービスが無効
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