import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:mixin_note/domain/notes/i_note_repository.dart';

import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'notes_watcher_bloc.freezed.dart';
part 'notes_watcher_event.dart';
part 'notes_watcher_state.dart';

@injectable
class NotesWatcherBloc extends Bloc<NotesWatcherEvent, NotesWatcherState> {
  final INoteRepository _noteRepository;

  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _notesStreamSubscription;

  NotesWatcherBloc(this._noteRepository)
      : super(const NotesWatcherState.initial()) {
    on<NotesWatcherEvent>((event, emit) {
      event.map(
        watchAllStarted: (e) async {
          emit(const NotesWatcherState.loadInProgress());
          await _notesStreamSubscription?.cancel();

          _notesStreamSubscription = _noteRepository.watchAll().listen(
                (failureOrNotes) => add(
                  NotesWatcherEvent.notesReceived(failureOrNotes),
                ),
              );
        },
        watchUncompletedStarted: (e) async {
          emit(const NotesWatcherState.loadInProgress());
          await _notesStreamSubscription?.cancel();

          _notesStreamSubscription = _noteRepository.watchUncompleted().listen(
                (failureOrNotes) => add(
                  NotesWatcherEvent.notesReceived(failureOrNotes),
                ),
              );
        },
        notesReceived: (e) {
          emit(
            e.failureOrNotes.fold(
              (f) => NotesWatcherState.loadFailure(f),
              (notes) => NotesWatcherState.loadSuccess(notes),
            ),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _notesStreamSubscription?.cancel();
    return super.close();
  }
}
