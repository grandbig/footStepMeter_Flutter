import 'package:flutter_test/flutter_test.dart';
import 'package:foot_step_meter/core/result.dart';

void main() {
  group('Result<T, E>', () {
    group('Success', () {
      test('success factoryで作成されたResultはSuccessインスタンスである', () {
        const result = Result<String, String>.success('test data');
        
        expect(result, isA<Success<String, String>>());
        expect(result.isSuccess, true);
        expect(result.isFailure, false);
      });

      test('success factoryで作成されたResultは正しいデータを保持する', () {
        const testData = 'test data';
        const result = Result<String, String>.success(testData);
        
        expect(result.data, testData);
        expect(result.error, null);
      });

      test('success時のdataゲッターは正しい値を返す', () {
        const testData = 'success data';
        const result = Result<String, String>.success(testData);
        
        expect(result.data, testData); // success: (data) => data をテスト
      });

      test('success時のerrorゲッターはnullを返す', () {
        const result = Result<String, String>.success('any data');
        
        expect(result.error, null); // success: (_) => null をテスト
      });

    });

    group('Failure', () {
      test('failure factoryで作成されたResultはFailureインスタンスである', () {
        const result = Result<String, String>.failure('error message');
        
        expect(result, isA<Failure<String, String>>());
        expect(result.isSuccess, false);
        expect(result.isFailure, true);
      });

      test('failure factoryで作成されたResultは正しいエラーメッセージを保持する', () {
        const errorMessage = 'something went wrong';
        const result = Result<String, String>.failure(errorMessage);
        
        expect(result.error, errorMessage);
        expect(result.data, null);
      });

      test('failure時のerrorゲッターは正しい値を返す', () {
        const errorMessage = 'failure error message';
        const result = Result<String, String>.failure(errorMessage);
        
        expect(result.error, errorMessage); // failure: (error) => error をテスト
      });

      test('failure時のdataゲッターはnullを返す', () {
        const result = Result<String, String>.failure('any error');
        
        expect(result.data, null); // failure: (_) => null をテスト
      });

    });

  });
}