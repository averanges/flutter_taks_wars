import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/api_exception.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/network_error.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/usecases/task/create_task_usecase.dart';
import 'package:flutter_soft_wars/domain/usecases/task/delete_task_usecase.dart';
import 'package:injectable/injectable.dart';

part 'task_state.dart';
part 'task_event.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this._createTaskUsecase, this._deleteTaskUsecase) : super(const TaskInitialState()) {
    on<TaskSubmitEvent>(_onSubmit);
    on<TaskDeleteEvent>(_onDelete);
  }

  final CreateTaskUsecase _createTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  Future<void> _onSubmit(TaskSubmitEvent event, Emitter<TaskState> emit) async {
    emit(const TaskLoadingState());

    try {
      final result = await _createTaskUsecase(event.task);

      if (result.error.isNotEmpty) {
        emit(TaskErrorState(networkError: NetworkError(error: result.error)));
      } else {
        emit(const TaskSuccessState());
      }
    } on ApiException catch (e) {
      emit(TaskErrorState(networkError: e.networkError));
    } catch (_) {
      emit(const TaskErrorState());
    }
  }

  Future<void> _onDelete(TaskDeleteEvent event, Emitter<TaskState> emit) async {
    emit(const TaskLoadingState());

    try {
      final result = await _deleteTaskUsecase(event.taskId);

      if (result.error.isNotEmpty) {
        emit(TaskErrorState(networkError: NetworkError(error: result.error)));
      } else {
        emit(const TaskSuccessState());
      }
    } on ApiException catch (e) {
      emit(TaskErrorState(networkError: e.networkError));
    } catch (_) {
      emit(const TaskErrorState());
    }
  }
}
