part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInSubmittedEvent extends SignInEvent {
  const SignInSubmittedEvent(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}
