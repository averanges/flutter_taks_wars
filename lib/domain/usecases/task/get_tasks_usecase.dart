import 'package:flutter_soft_wars/core/usecase/usecase.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetTasksUseCase extends ExecuteUseCase<TasksContainerDomain> {
  const GetTasksUseCase(this._repository);

  final TasksRepository _repository;

  @override
  Future<TasksContainerDomain> execute() => _repository.getTasks();
}
