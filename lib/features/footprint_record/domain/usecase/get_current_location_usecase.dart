import '../entity/footprint_record.dart';
import '../repository/location_repository.dart';
import '../error/location_error.dart';
import '../../../../core/result.dart';
import '../service/location_permission_service.dart';

/// 現在の位置情報を取得するユースケース
///
/// 位置情報の権限チェックを行い、権限が許可されている場合は
/// 現在の位置情報を取得して FootprintRecord として返します。
/// 権限が拒否されている場合や位置情報が取得できない場合は適切なエラーを返します。
class GetCurrentLocationUseCase {
  final LocationRepository _locationRepository;
  final LocationPermissionService _permissionService;

  GetCurrentLocationUseCase(this._locationRepository, this._permissionService);

  /// 現在の位置情報を取得します
  ///
  /// まず位置情報の権限をチェックし、権限が許可されている場合は
  /// 現在の位置情報を取得します。
  ///
  /// Returns:
  /// - 成功時: FootprintRecord を含む Result
  /// - 失敗時: LocationError を含む Result
  ///   - 権限エラー、位置情報サービス無効、位置情報取得不可など
  Future<Result<FootprintRecord, LocationError>> execute() async {
    final accessResult = await _permissionService.checkLocationAccess();
    if (accessResult.isFailure) {
      return Result.failure(accessResult.error!);
    }

    final footprintRecord = await _locationRepository.getCurrentLocation();
    if (footprintRecord == null) {
      return const Result.failure(LocationError.locationUnavailable);
    }

    return Result.success(footprintRecord);
  }
}