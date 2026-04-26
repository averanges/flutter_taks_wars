import 'package:flutter_soft_wars/core/utils/exceptions/error_handler.dart';
import 'package:flutter_soft_wars/data/datasources/local/data_providers/auth_data_provider.dart';
import 'package:flutter_soft_wars/data/datasources/remote/client/rest_client.dart';
import 'package:flutter_soft_wars/data/datasources/remote/entities/request/change_task_status_body.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TasksRepository)
class TasksRepositoryImpl implements TasksRepository {
  TasksRepositoryImpl(this._restClient, this._authDataProvider);

  final RestClient _restClient;
  final AuthDataProvider _authDataProvider;

  @override
  Future<TasksContainerDomain> getTasks() async {
    final email = _authDataProvider.getEmail() ?? '';

    try {
      final response = await _restClient.getTasks(email);
      return response.toDomain();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<TasksContainerDomain> createTask({required TaskDomain task}) async {
    final email = _authDataProvider.getEmail() ?? '';

    final request = task.toBody();

    try {
      final response = await _restClient.createTasks(email: email, tasks: [request]);
      return response.toDomain();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<TasksContainerDomain> changeTaskStatus({required TaskDomain task}) async {
    final email = _authDataProvider.getEmail() ?? '';

    final request = ChangeTaskStatusBody(status: task.status.serverValue);

    try {
      final response = await _restClient.changeTaskStatus(email: email, body: request, taskId: task.taskId);
      return response.toDomain();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<TasksContainerDomain> deleteTask({required String taskId}) async {
    final email = _authDataProvider.getEmail() ?? '';

    try {
      final response = await _restClient.deleteTask(email: email, taskId: taskId);
      return response.toDomain();
    } catch (e, stackTrace) {
      ErrorHandler.handle(error: e, stackTrace: stackTrace);
    }
  }
}
