part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitialState extends SignInState {
  const SignInInitialState();
}

class SignInInputState extends SignInState {
  const SignInInputState();
}

class SignInLoadingState extends SignInState {
  const SignInLoadingState();
}

class SignInSuccessState extends SignInState {
  const SignInSuccessState();
}

class SignInErrorState extends SignInState {
  const SignInErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
