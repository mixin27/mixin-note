import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

// Don't need to use abstract keyword in later version of freezed
// see - https://github.com/rrousselGit/freezed/tree/master/packages/freezed#the-abstract-keyword
@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = _ExceedingLength<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = _Empty<T>;

  const factory ValueFailure.multiline({
    required T failedValue,
  }) = _Multiline<T>;

  const factory ValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) = _ListTooLong<T>;

  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = _InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = _ShortPassword<T>;
}

/**
 * 
 * @freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> f) = _Auth<T>;
  const factory ValueFailure.notes(NotesValueFailure<T> f) = _Notes<T>;
}

@freezed
abstract class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.invalidEmail({
    required String failedValue,
  }) = _InvalidEmail<T>;
  const factory AuthValueFailure.shortPassword({
    required String failedValue,
  }) = _ShortPassword<T>;
}

@freezed
abstract class NotesValueFailure<T> with _$NotesValueFailure<T> {
  const factory NotesValueFailure.exceedingLength({
    required String failedValue,
  }) = _ExceedingLength<T>;
}
 */