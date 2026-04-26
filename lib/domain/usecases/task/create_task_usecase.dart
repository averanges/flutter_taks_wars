import 'package:flutter_soft_wars/core/usecase/usecase.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateTaskUsecase extends UseCase<TasksContainerDomain, TaskDomain> {
  const CreateTaskUsecase(this._repository);

  final TasksRepository _repository;

  @override
  Future<TasksContainerDomain> call(TaskDomain task) => _repository.createTask(task: task);
}
