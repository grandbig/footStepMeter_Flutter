import '../entity/footprint_record.dart';
import '../repository/location_repository.dart';
import '../error/location_error.dart';
import '../../../../core/result.dart';
import '../service/location_permission_service.dart';

/// 位置情報の追跡を開始するユースケース
///
/// 位置情報の権限チェックを行い、権限が許可されている場合は
/// 位置情報の追跡を開始して FootprintRecord のストリームを返します。
/// 権限が拒否されている場合は適切なエラーを返します。
class StartLocationTrackingUseCase {
  final LocationRepository _locationRepository;
  final LocationPermissionService _permissionService;

  StartLocationTrackingUseCase(this._locationRepository, this._permissionService);

  /// 位置情報の追跡を開始します
  ///
  /// まず位置情報の権限をチェックし、権限が許可されている場合は
  /// 位置情報の追跡を開始します。
  ///
  /// Returns:
  /// - 成功時: FootprintRecord のストリームを含む Result
  /// - 失敗時: LocationError を含む Result
  Future<Result<Stream<FootprintRecord>, LocationError>> execute() async {
    final accessResult = await _permissionService.checkLocationAccess();
    if (accessResult.isFailure) {
      return Result.failure(accessResult.error!);
    }

    final locationStream = _locationRepository.startLocationTracking();
    return Result.success(locationStream);
  }
}