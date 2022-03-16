import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';
import '../../../domain/notes/value_objects.dart';
import '../../../presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

part 'notes_form_bloc.freezed.dart';
part 'notes_form_event.dart';
part 'notes_form_state.dart';

@injectable
class NotesFormBloc extends Bloc<NotesFormEvent, NotesFormState> {
  final INoteRepository _noteRepository;

  NotesFormBloc(this._noteRepository) : super(NotesFormState.initial()) {
    on<NotesFormEvent>((event, emit) {
      event.map(
        initialize: (e) {
          emit(e.initialNoteOption.fold(
            () => state,
            (initialNote) => state.copyWith(
              note: initialNote,
              isEditing: true,
            ),
          ));
        },
        bodyChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(body: NoteBody(e.bodyStr)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        colorChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(color: NoteColor(e.color)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        todosChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(
                todos: List3(
                  e.todos.map((primitiveTodo) => primitiveTodo.toDomain()),
                ),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async {
          Either<NoteFailure, Unit>? failureOrSuccess;

          emit(state.copyWith(
            isSaving: true,
            saveFailureOrSuccessOption: none(),
          ));

          if (state.note.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _noteRepository.update(state.note)
                : await _noteRepository.create(state.note);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showError: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
