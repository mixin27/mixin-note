import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mixin_note/domain/core/errors.dart';

import 'value_failure.dart';

/// Base value objects
@immutable
abstract class ValueObjects<T> {
  const ValueObjects();

  Either<ValueFailure<T>, T> get value;

  /// Throw `UnexpectedValueError` containing the `ValueFailure`
  ///
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((l) => throw UnexpectedValueError(l), id);
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'ValueObjects(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObjects<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
