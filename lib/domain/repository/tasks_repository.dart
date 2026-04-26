import 'package:flutter_soft_wars/domain/entities/task_domain.dart';

abstract class TasksRepository {
  Future<TasksContainerDomain> getTasks();

  Future<TasksContainerDomain> createTask({required TaskDomain task});

  Future<TasksContainerDomain> changeTaskStatus({required TaskDomain task});

  Future<TasksContainerDomain> deleteTask({required String taskId});
}
