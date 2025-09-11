/// (T007) Result<T> 型: 成功/失敗を表すシンプルなモナディックラッパー。
///
/// 将来テスト導入時に UseCase / Repository で統一エラーハンドリングを行うための基盤。
/// map / flatMap / fold を提供し、副作用を伴わない変換チェーンを容易にする。
library result;

/// 成功/失敗の共通インタフェース。
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isError => this is Failure<T>;

  T? get data => switch (this) {
    Success(value: final v) => v,
    _ => null,
  };
  Object? get error => switch (this) {
    Failure(error: final e) => e,
    _ => null,
  };

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Object error, StackTrace stackTrace) onFailure,
  }) => switch (this) {
    Success<T>(value: final v) => onSuccess(v),
    Failure<T>(error: final e, stackTrace: final st) => onFailure(e, st),
  };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success<T>(value: final v) => Success(transform(v)),
    Failure<T>(error: final e, stackTrace: final st) => Failure(e, st),
  };

  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
    Success<T>(value: final v) => _guard(transform, v),
    Failure<T>(error: final e, stackTrace: final st) => Failure(e, st),
  };

  /// 例外を Failure に自動変換する安全実行ヘルパ。
  static Result<R> guard<R>(R Function() fn) =>
      _guard((_) => Success(fn()), null);

  static Result<R> _guard<A, R>(Result<R> Function(A value) fn, A value) {
    try {
      return fn(value);
    } catch (e, st) {
      return Failure(e, st);
    }
  }
}

/// 成功状態。
final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
  @override
  String toString() => 'Success($value)';
}

/// 失敗状態。
final class Failure<T> extends Result<T> {
  const Failure(this.error, [this.stackTrace = StackTrace.empty]);
  final Object error;
  final StackTrace stackTrace;
  @override
  String toString() => 'Failure($error)';
}
