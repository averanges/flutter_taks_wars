part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState({required this.tasks, required this.category});

  final List<TaskDomain> tasks;
  final TaskType category;

  @override
  List<Object?> get props => [tasks, category];
}

class TasksInitialState extends TasksState {
  const TasksInitialState() : super(tasks: const [], category: TaskType.all);
}

class TasksLoadingState extends TasksState {
  const TasksLoadingState({required super.tasks, required super.category});
}

class TasksLoadedState extends TasksState {
  const TasksLoadedState({required super.tasks, required super.category});
}

class TasksErrorState extends TasksState {
  const TasksErrorState({this.networkError, required super.tasks, required super.category});

  final NetworkError? networkError;

  @override
  List<Object?> get props => [tasks, networkError, category];
}
