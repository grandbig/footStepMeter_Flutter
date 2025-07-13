import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// 成功または失敗を表現する型安全な結果クラス
/// 
/// `Result<T, E>`は、処理の結果を明示的に表現するための汎用クラスです。
/// 成功時は`T`型のデータを、失敗時は`E`型のエラーを保持します。
/// 
/// RustのResult型やSwiftのResult型にインスパイアされており、
/// 例外処理に依存しない関数型プログラミングのアプローチを提供します。
/// 
/// ## 型パラメータ
/// * `T` - 成功時に返されるデータの型
/// * `E` - 失敗時に返されるエラーの型
@freezed
class Result<T, E> with _$Result<T, E> {
  /// 成功を表すResultインスタンスを作成します
  /// 
  /// [data] 成功時のデータ
  const factory Result.success(T data) = Success<T, E>;
  
  /// 失敗を表すResultインスタンスを作成します
  /// 
  /// [error] 失敗時のエラー情報
  const factory Result.failure(E error) = Failure<T, E>;

  const Result._();

  /// このResultが成功を表すかどうかを判定します
  /// 
  /// 成功の場合は`true`、失敗の場合は`false`を返します。
  bool get isSuccess => this is Success<T, E>;
  
  /// このResultが失敗を表すかどうかを判定します
  /// 
  /// 失敗の場合は`true`、成功の場合は`false`を返します。
  bool get isFailure => this is Failure<T, E>;

  /// 成功時のデータを取得します
  /// 
  /// 成功の場合は`T`型のデータを、失敗の場合は`null`を返します。
  T? get data => when(
    success: (data) => data,
    failure: (_) => null,
  );

  /// 失敗時のエラー情報を取得します
  /// 
  /// 失敗の場合は`E`型のエラーを、成功の場合は`null`を返します。
  E? get error => when(
    success: (_) => null,
    failure: (error) => error,
  );
}