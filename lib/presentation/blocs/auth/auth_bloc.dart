import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/domain/usecases/user/get_email_usecase.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._getEmailUseCase) : super(const AuthInitialState()) {
    on<AuthInitEvent>(_onInit);
  }

  final GetEmailUseCase _getEmailUseCase;

  Future<void> _onInit(AuthInitEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());

    try {
      final email = await _getEmailUseCase.execute();
      emit(AuthLoadedState(email: email));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
