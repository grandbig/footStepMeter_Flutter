import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foot_step_meter/features/footprint_record/domain/error/location_error.dart';
import 'package:foot_step_meter/l10n/generated/app_localizations.dart';

void main() {
  group('LocationError', () {
    group('enum values', () {
      test('全てのエラー値が定義されている', () {
        expect(LocationError.values, [
          LocationError.permissionDenied,
          LocationError.serviceDisabled,
          LocationError.locationUnavailable,
          LocationError.trackingFailed,
          LocationError.timeout,
        ]);
      });

      test('enum値の数が期待値と一致する', () {
        expect(LocationError.values.length, 5);
      });
    });

    group('isRetryable', () {
      test('permissionDeniedは再試行不可', () {
        expect(LocationError.permissionDenied.isRetryable, false);
      });

      test('serviceDisabledは再試行不可', () {
        expect(LocationError.serviceDisabled.isRetryable, false);
      });

      test('locationUnavailableは再試行可能', () {
        expect(LocationError.locationUnavailable.isRetryable, true);
      });

      test('trackingFailedは再試行可能', () {
        expect(LocationError.trackingFailed.isRetryable, true);
      });

      test('timeoutは再試行可能', () {
        expect(LocationError.timeout.isRetryable, true);
      });
    });

    group('getDescription', () {
      late Widget app;

      setUp(() {
        app = MaterialApp(
          locale: const Locale('ja'),
          localizationsDelegates: const [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.supportedLocales,
          home: const Scaffold(body: Text('Test')),
        );
      });

      testWidgets('permissionDeniedが正しいメッセージを返す（日本語）', (tester) async {
        await tester.pumpWidget(app);
        final context = tester.element(find.byType(Scaffold));

        final message = LocationError.permissionDenied.getDescription(context);
        expect(message, '位置情報の使用許可がありません');
      });

      testWidgets('serviceDisabledが正しいメッセージを返す（日本語）', (tester) async {
        await tester.pumpWidget(app);
        final context = tester.element(find.byType(Scaffold));

        final message = LocationError.serviceDisabled.getDescription(context);
        expect(message, '位置情報サービスが無効です');
      });

      testWidgets('locationUnavailableが正しいメッセージを返す（日本語）', (tester) async {
        await tester.pumpWidget(app);
        final context = tester.element(find.byType(Scaffold));

        final message = LocationError.locationUnavailable.getDescription(context);
        expect(message, '現在位置を取得できませんでした');
      });

      testWidgets('trackingFailedが正しいメッセージを返す（日本語）', (tester) async {
        await tester.pumpWidget(app);
        final context = tester.element(find.byType(Scaffold));

        final message = LocationError.trackingFailed.getDescription(context);
        expect(message, '位置情報の追跡を開始できませんでした');
      });

      testWidgets('timeoutが正しいメッセージを返す（日本語）', (tester) async {
        await tester.pumpWidget(app);
        final context = tester.element(find.byType(Scaffold));

        final message = LocationError.timeout.getDescription(context);
        expect(message, '位置情報の取得がタイムアウトしました');
      });

      group('英語ロケール', () {
        late Widget appEn;

        setUp(() {
          appEn = MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              L10n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.supportedLocales,
            home: const Scaffold(body: Text('Test')),
          );
        });

        testWidgets('permissionDeniedが正しいメッセージを返す（英語）', (tester) async {
          await tester.pumpWidget(appEn);
          final context = tester.element(find.byType(Scaffold));

          final message = LocationError.permissionDenied.getDescription(context);
          expect(message, 'Location permission is not granted');
        });

        testWidgets('serviceDisabledが正しいメッセージを返す（英語）', (tester) async {
          await tester.pumpWidget(appEn);
          final context = tester.element(find.byType(Scaffold));

          final message = LocationError.serviceDisabled.getDescription(context);
          expect(message, 'Location service is disabled');
        });

        testWidgets('locationUnavailableが正しいメッセージを返す（英語）', (tester) async {
          await tester.pumpWidget(appEn);
          final context = tester.element(find.byType(Scaffold));

          final message = LocationError.locationUnavailable.getDescription(context);
          expect(message, 'Current location could not be obtained');
        });

        testWidgets('trackingFailedが正しいメッセージを返す（英語）', (tester) async {
          await tester.pumpWidget(appEn);
          final context = tester.element(find.byType(Scaffold));

          final message = LocationError.trackingFailed.getDescription(context);
          expect(message, 'Failed to start location tracking');
        });

        testWidgets('timeoutが正しいメッセージを返す（英語）', (tester) async {
          await tester.pumpWidget(appEn);
          final context = tester.element(find.byType(Scaffold));

          final message = LocationError.timeout.getDescription(context);
          expect(message, 'Location request timed out');
        });
      });
    });

  });
}