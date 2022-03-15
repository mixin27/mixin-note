import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/notes/i_note_repository.dart';
import '../../../domain/notes/note.dart';
import '../../../domain/notes/note_failure.dart';

part 'notes_actor_bloc.freezed.dart';
part 'notes_actor_event.dart';
part 'notes_actor_state.dart';

@injectable
class NotesActorBloc extends Bloc<NotesActorEvent, NotesActorState> {
  final INoteRepository _noteRepository;

  NotesActorBloc(this._noteRepository)
      : super(const NotesActorState.initial()) {
    on<NotesActorEvent>((event, emit) {
      event.map(
        deleted: (e) async {
          emit(const NotesActorState.actionInProgress());
          final possibleFailure = await _noteRepository.delete(e.note);

          emit(
            possibleFailure.fold(
              (f) => NotesActorState.deleteFailure(f),
              (r) => const NotesActorState.deleteSuccess(),
            ),
          );
        },
      );
    });
  }
}
