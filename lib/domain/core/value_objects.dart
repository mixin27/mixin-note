import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'value_failure.dart';

/// Base value objects
@immutable
abstract class ValueObjects<T> {
  const ValueObjects();

  Either<ValueFailure<T>, T> get value;

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
