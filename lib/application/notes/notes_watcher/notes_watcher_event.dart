part of 'notes_watcher_bloc.dart';

@freezed
class NotesWatcherEvent with _$NotesWatcherEvent {
  const factory NotesWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory NotesWatcherEvent.watchUncompletedStarted() =
      _WatchUncompletedStarted;
  const factory NotesWatcherEvent.notesReceived(
    Either<NoteFailure, KtList<Note>> failureOrNotes,
  ) = _NotesReceived;
}
