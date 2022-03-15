part of 'notes_actor_bloc.dart';

@freezed
class NotesActorEvent with _$NotesActorEvent {
  const factory NotesActorEvent.deleted(
    Note note,
  ) = _Deleted;
}
