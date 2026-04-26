part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class TasksLoadEvent extends TasksEvent {
  const TasksLoadEvent({this.category, this.showLoading = true});

  final TaskType? category;
  final bool showLoading;
}

class TasksChangeStatusEvent extends TasksEvent {
  const TasksChangeStatusEvent({required this.task});

  final TaskDomain task;
}
