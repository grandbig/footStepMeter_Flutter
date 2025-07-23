// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get locationErrorPermissionDenied => '位置情報の使用許可がありません';

  @override
  String get locationErrorServiceDisabled => '位置情報サービスが無効です';

  @override
  String get locationErrorLocationUnavailable => '現在位置を取得できませんでした';

  @override
  String get locationErrorTrackingFailed => '位置情報の追跡を開始できませんでした';

  @override
  String get locationErrorTimeout => '位置情報の取得がタイムアウトしました';

  @override
  String get locationErrorAlreadyRecording => '既にルート記録中です';

  @override
  String get locationErrorNotRecording => 'ルート記録を開始していません';
}
