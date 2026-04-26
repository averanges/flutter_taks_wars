import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/api_exception.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/network_error.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/enums/task_type.dart';
import 'package:flutter_soft_wars/domain/usecases/task/change_task_status_usecase.dart';
import 'package:flutter_soft_wars/domain/usecases/task/get_tasks_usecase.dart';
import 'package:injectable/injectable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

@Injectable()
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc(this._getTasksUseCase, this._changeTaskStatusUsecase) : super(const TasksInitialState()) {
    on<TasksLoadEvent>(_onLoadTasks);
    on<TasksChangeStatusEvent>(_onChangeStatus);
  }

  final GetTasksUseCase _getTasksUseCase;
  final ChangeTaskStatusUsecase _changeTaskStatusUsecase;

  Future<void> _onLoadTasks(TasksLoadEvent event, Emitter<TasksState> emit) async {
    final categoryResult = event.category ?? state.category;

    try {
      if (event.showLoading) {
        emit(TasksLoadingState(tasks: state.tasks, category: categoryResult));
      }

      final tasks = await _getTasksUseCase.execute();

      emit(TasksLoadedState(tasks: tasks.data, category: categoryResult));
    } on ApiException catch (e) {
      emit(TasksErrorState(networkError: e.networkError, tasks: state.tasks, category: categoryResult));
    } catch (_) {
      emit(TasksErrorState(tasks: state.tasks, category: categoryResult));
    }
  }

  Future<void> _onChangeStatus(TasksChangeStatusEvent event, Emitter<TasksState> emit) async {
    try {
      final result = await _changeTaskStatusUsecase.call(event.task);

      if (result.error.isNotEmpty) {
        emit(
          TasksErrorState(
            tasks: state.tasks,
            category: state.category,
            networkError: NetworkError(error: result.error),
          ),
        );
      } else {
        add(const TasksLoadEvent(showLoading: false));
      }
    } on ApiException catch (e) {
      emit(TasksErrorState(category: state.category, tasks: state.tasks, networkError: e.networkError));
    } catch (_) {
      emit(TasksErrorState(category: state.category, tasks: state.tasks));
    }
  }
}
