import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/enums/task_status.dart';
import 'package:flutter_soft_wars/domain/enums/task_type.dart';
import 'package:flutter_soft_wars/domain/enums/task_urgent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_response.g.dart';

@JsonSerializable(createToJson: false)
class TasksContainerResponse {
  const TasksContainerResponse({required this.error, required this.data});

  factory TasksContainerResponse.fromJson(Map<String, dynamic> json) => _$TasksContainerResponseFromJson(json);

  final String? error;
  final List<TaskResponse>? data;

  TasksContainerDomain toDomain() =>
      TasksContainerDomain(error: error ?? '', data: data?.map((e) => e.toDomain()).toList() ?? []);
}

@JsonSerializable()
class TaskResponse {
  const TaskResponse({
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

  factory TaskResponse.fromJson(Map<String, dynamic> json) => _$TaskResponseFromJson(json);

  final String id;
  final String? taskId;
  final int? status;
  final String? name;
  final int? type;
  final String? description;
  final String? file;
  final String finishDate;
  final int? urgent;
  final DateTime? syncTime;

  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);

  TaskDomain toDomain() => TaskDomain(
    id: id,
    taskId: taskId ?? '',
    status: TaskStatus.fromValue(status),
    name: name ?? '',
    type: TaskType.fromValue(type),
    description: description ?? '',
    file: file,
    finishDate: DateTime.tryParse(finishDate),
    urgent: TaskUrgent.fromValue(urgent),
    syncTime: syncTime,
  );
}
