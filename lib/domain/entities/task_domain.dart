import 'package:equatable/equatable.dart';
import 'package:flutter_soft_wars/core/extensions/date_time_extension.dart';
import 'package:flutter_soft_wars/data/datasources/remote/entities/response/task_response.dart';
import 'package:flutter_soft_wars/domain/enums/task_status.dart';
import 'package:flutter_soft_wars/domain/enums/task_type.dart';
import 'package:flutter_soft_wars/domain/enums/task_urgent.dart';

class TasksContainerDomain {
  const TasksContainerDomain({required this.error, required this.data});

  final String error;
  final List<TaskDomain> data;
}

class TaskDomain extends Equatable {
  const TaskDomain({
    required this.id,
    required this.taskId,
    required this.status,
    required this.name,
    required this.type,
    required this.description,
    required this.file,
    required this.finishDate,
    required this.urgent,
    required this.syncTime,
  });

  const TaskDomain.empty({
    this.id = '',
    required this.taskId,
    this.status = TaskStatus.active,
    this.name = '',
    this.type = TaskType.work,
    this.description = '',
    this.file,
    this.finishDate,
    this.urgent = TaskUrgent.normal,
    this.syncTime,
  });

  final String id;
  final String taskId;
  final TaskStatus status;
  final String name;
  final TaskType type;
  final String description;
  final String? file;
  final DateTime? finishDate;
  final TaskUrgent urgent;
  final DateTime? syncTime;

  TaskResponse toBody() => TaskResponse(
    id: id,
    taskId: taskId,
    status: status.serverValue,
    name: name,
    type: type.serverValue,
    description: description,
    file: file,
    finishDate: finishDate?.yearMonthDay() ?? '',
    urgent: urgent.serverValue,
    syncTime: syncTime,
  );

  @override
  List<Object?> get props => [id, taskId, status, name, type, description, file, finishDate, urgent, syncTime];

  TaskDomain copyWith({
    String? id,
    String? taskId,
    TaskStatus? status,
    String? name,
    TaskType? type,
    String? description,
    String? file,
    DateTime? finishDate,
    TaskUrgent? urgent,
    DateTime? syncTime,
  }) {
    return TaskDomain(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      file: file ?? this.file,
      finishDate: finishDate ?? this.finishDate,
      urgent: urgent ?? this.urgent,
      syncTime: syncTime ?? this.syncTime,
    );
  }
}
