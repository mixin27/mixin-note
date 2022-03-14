import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';

import '../core/value_failure.dart';
import '../core/value_objects.dart';
import '../core/value_transformer.dart';
import '../core/value_validators.dart';

class NoteBody extends ValueObjects<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory NoteBody(String input) {
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(
        // equal to => (valueFromPreviousF) => validateStringNotEmpty(valueFromPreviousF)
        validateStringNotEmpty,
      ),
    );
  }

  const NoteBody._(this.value);
}

class TodoName extends ValueObjects<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory TodoName(String input) {
    return TodoName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const TodoName._(this.value);
}

class NoteColor extends ValueObjects<Color> {
  static const List<Color> predefinedColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // crean
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  static const maxLength = 1000;

  factory NoteColor(Color input) {
    return NoteColor._(
      right(makeColorOpaque(input)),
    );
  }

  const NoteColor._(this.value);
}

class List3<T> extends ValueObjects<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  factory List3(KtList<T> input) {
    return List3<T>._(
      validateMaxListLength(input, maxLength),
    );
  }

  const List3._(this.value);

  int get length => value.getOrElse(() => emptyList()).size;

  bool get isFull => length == maxLength;
}
