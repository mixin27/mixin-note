part of 'notes_form_bloc.dart';

@freezed
class NotesFormEvent with _$NotesFormEvent {
  const factory NotesFormEvent.initialize(Option<Note> initialNoteOption) =
      _Initialize;
  const factory NotesFormEvent.bodyChanged(String bodyStr) = _BodyChanged;
  const factory NotesFormEvent.colorChanged(Color color) = _ColorChanged;
  const factory NotesFormEvent.todosChanged(KtList<TodoItemPrimitive> todos) =
      _TodosChanged;
  const factory NotesFormEvent.saved() = _Saved;
}
