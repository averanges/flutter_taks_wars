import 'package:flutter_soft_wars/core/usecase/usecase.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteTaskUsecase extends UseCase<TasksContainerDomain, String> {
  const DeleteTaskUsecase(this._repository);

  final TasksRepository _repository;

  @override
  Future<TasksContainerDomain> call(String task) => _repository.deleteTask(taskId: task);
}
