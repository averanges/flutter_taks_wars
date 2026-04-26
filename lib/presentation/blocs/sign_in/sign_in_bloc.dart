import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/core/utils/validators/field_validator.dart';
import 'package:flutter_soft_wars/domain/usecases/user/sign_in_with_email_usecase.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInWithEmailUseCase) : super(const SignInInitialState()) {
    on<SignInSubmittedEvent>(_onSubmitted);
  }

  final SignInWithEmailUseCase _signInWithEmailUseCase;

  Future<void> _onSubmitted(SignInSubmittedEvent event, Emitter<SignInState> emit) async {
    if (state is SignInLoadingState) return;

    final failure = FieldValidator.validateEmail(event.email);

    if (failure != null) {
      emit(SignInErrorState(error: failure.message));
      return;
    }

    emit(const SignInLoadingState());

    try {
      await _signInWithEmailUseCase.call(event.email);
      emit(const SignInSuccessState());
    } catch (e) {
      emit(SignInErrorState(error: e.toString()));
    }
  }
}
