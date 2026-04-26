part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class TaskSubmitEvent extends TaskEvent {
  const TaskSubmitEvent({required this.task});

  final TaskDomain task;

  @override
  List<Object?> get props => [task];
}

class TaskDeleteEvent extends TaskEvent {
  const TaskDeleteEvent({required this.taskId});

  final String taskId;

  @override
  List<Object?> get props => [taskId];
}
