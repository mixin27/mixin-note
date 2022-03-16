part of 'notes_form_bloc.dart';

@freezed
class NotesFormState with _$NotesFormState {
  const factory NotesFormState({
    required Note note,
    required bool showError,
    required bool isSaving,
    required bool isEditing,
    required Option<Either<NoteFailure, Unit>> saveFailureOrSuccessOption,
  }) = _NotesFormState;

  factory NotesFormState.initial() => NotesFormState(
        note: Note.empty(),
        showError: false,
        isSaving: false,
        isEditing: false,
        saveFailureOrSuccessOption: none(),
      );
}
