import 'package:flutter/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// 位置情報関連のエラーを表すenumクラス
/// 
/// 位置情報の取得や追跡に関する様々なエラー状態を型安全に表現します。
/// 文字列ベースのエラーメッセージと比較して、
/// コンパイル時にエラー処理の網羅性をチェックできます。
enum LocationError {
  /// 位置情報の使用許可がない
  /// 
  /// ユーザーがアプリに位置情報の使用を許可していない状態
  permissionDenied,
  
  /// 位置情報サービスが無効
  /// 
  /// デバイスの位置情報サービス自体が無効になっている状態
  serviceDisabled,
  
  /// 現在位置の取得に失敗
  /// 
  /// GPS信号の受信失敗やネットワークエラーなどで位置情報を取得できない状態
  locationUnavailable,
  
  /// 位置情報の追跡開始に失敗
  /// 
  /// 連続的な位置情報の取得を開始できない状態
  trackingFailed,
  
  /// タイムアウトエラー
  /// 
  /// 位置情報の取得が指定時間内に完了しなかった状態
  timeout;
  
  /// エラーの説明文を取得します
  /// 
  /// UIでユーザーに表示するためのエラーメッセージを返します。
  /// BuildContextが必要な場合は、getDescription(context)を使用してください。
  String getDescription(BuildContext context) {
    final l10n = L10n.of(context);
    switch (this) {
      case LocationError.permissionDenied:
        return l10n.locationErrorPermissionDenied;
      case LocationError.serviceDisabled:
        return l10n.locationErrorServiceDisabled;
      case LocationError.locationUnavailable:
        return l10n.locationErrorLocationUnavailable;
      case LocationError.trackingFailed:
        return l10n.locationErrorTrackingFailed;
      case LocationError.timeout:
        return l10n.locationErrorTimeout;
    }
  }
  
  /// エラーが一時的なものかどうかを判定します
  /// 
  /// 再試行可能なエラーの場合は`true`を返します。
  bool get isRetryable {
    switch (this) {
      case LocationError.permissionDenied:
      case LocationError.serviceDisabled:
        return false; // ユーザーの設定変更が必要
      case LocationError.locationUnavailable:
      case LocationError.trackingFailed:
      case LocationError.timeout:
        return true; // 再試行可能
    }
  }
}