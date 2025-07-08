import 'package:freezed_annotation/freezed_annotation.dart';
import 'footprint_record.dart';

part 'route.freezed.dart';
part 'route.g.dart';

/// 歩行ルートを表すエンティティクラス
/// 
/// 足跡記録の集合で構成される歩行ルートの情報を保持します。
/// ルート名、開始・終了時刻、総距離、平均速度などの統計情報を含みます。
@freezed
class Route with _$Route {
  /// ルートを作成します。
  ///
  /// [id] ルートのユニークID
  /// [name] ルート名
  /// [startTime] 開始日時
  /// [endTime] 終了日時
  /// [footprints] 足跡記録のリスト
  /// [totalDistance] 総距離（メートル）
  /// [averageSpeed] 平均速度（m/s）
  /// [duration] 所要時間
  const factory Route({
    required String id,
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required List<FootprintRecord> footprints,
    required double totalDistance,
    required double averageSpeed,
    required Duration duration,
  }) = _Route;
  
  const Route._();

  /// JSONからRouteを作成します。
  factory Route.fromJson(Map<String, dynamic> json) =>
      _$RouteFromJson(json);
      
  /// ルートが空かどうかを判定します。
  /// 
  /// 足跡記録が存在しないルートを空とみなします。
  bool isEmpty() {
    return footprints.isEmpty;
  }
  
  /// ルートの距離がキロメートル単位での表示に適しているかを判定します。
  /// 
  /// 1000メートル以上の場合にキロメートル表示が適していると判定します。
  bool shouldDisplayInKilometers() {
    return totalDistance >= 1000.0;
  }
  
  /// 平均速度を時速（km/h）で取得します。
  /// 
  /// m/sからkm/hに変換した値を返します。
  double get averageSpeedKmh {
    return averageSpeed * 3.6;
  }
}