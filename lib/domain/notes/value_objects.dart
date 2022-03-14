import 'package:dartz/dartz.dart';

import '../core/value_failure.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class NoteBody extends ValueObjects<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory NoteBody(String input) {
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(
        (valueFromPreviousF) => validateStringNotEmpty(valueFromPreviousF),
      ),
    );
  }

  const NoteBody._(this.value);
}
