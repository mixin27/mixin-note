import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/auth/auth_failure.dart';
import '../../../../domain/auth/i_auth_facade.dart';
import '../../../../domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      await event.map(
        emailChanged: (e) {
          emit(
            state.copyWith(
              emailAddress: EmailAddress(e.email),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        passwordChanged: (e) {
          emit(
            state.copyWith(
              password: Password(e.password),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerWithEmailAndPasswordPressed: (e) async {
          final failureOrSuccess =
              await _performActionOnAuthFacadeWithEmailAndPassword(
            emit,
            _authFacade.registerWithEmailAndPassword,
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              showError: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        signInWithEmailAndPasswordPressed: (e) async {
          final failureOrSuccess =
              await _performActionOnAuthFacadeWithEmailAndPassword(
            emit,
            _authFacade.signInWithEmailAndPassword,
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              showError: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        signInWithGooglePressed: (e) async {
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          final failureOrSuccess = await _authFacade.signInWithGoogle();
          emit(
            state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  Future<Either<AuthFailure, Unit>?>
      _performActionOnAuthFacadeWithEmailAndPassword(
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardCall,
  ) async {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );

      failureOrSuccess = await forwardCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    return failureOrSuccess;
  }
}
