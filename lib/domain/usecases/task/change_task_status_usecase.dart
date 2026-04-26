import 'package:flutter_soft_wars/core/usecase/usecase.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ChangeTaskStatusUsecase extends UseCase<TasksContainerDomain, TaskDomain> {
  const ChangeTaskStatusUsecase(this._repository);

  final TasksRepository _repository;

  @override
  Future<TasksContainerDomain> call(TaskDomain task) => _repository.changeTaskStatus(task: task);
}
