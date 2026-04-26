part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitialState extends TaskState {
  const TaskInitialState() : super();
}

class TaskLoadingState extends TaskState {
  const TaskLoadingState();
}

class TaskSuccessState extends TaskState {
  const TaskSuccessState();
}

class TaskErrorState extends TaskState {
  const TaskErrorState({this.networkError});

  final NetworkError? networkError;

  @override
  List<Object?> get props => [networkError];
}
