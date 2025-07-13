// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get locationErrorPermissionDenied =>
      'Location permission is not granted';

  @override
  String get locationErrorServiceDisabled => 'Location service is disabled';

  @override
  String get locationErrorLocationUnavailable =>
      'Current location could not be obtained';

  @override
  String get locationErrorTrackingFailed => 'Failed to start location tracking';

  @override
  String get locationErrorTimeout => 'Location request timed out';
}
