import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import 'note.dart';
import 'note_failure.dart';

abstract class INoteRepository {
  // watch notes
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  // watch uncompleted notes
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  // CUD - Create Update Delete
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
