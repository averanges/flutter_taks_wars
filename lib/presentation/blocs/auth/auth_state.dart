part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthInputState extends AuthState {
  const AuthInputState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthLoadedState extends AuthState {
  const AuthLoadedState({required this.email});

  final String? email;
}

class AuthErrorState extends AuthState {
  const AuthErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
