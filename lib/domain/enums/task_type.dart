import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum TaskType {
  all,
  work,
  personal;

  String get title {
    return switch (this) {
      TaskType.all => 'Усі',
      TaskType.work => 'Робочі',
      TaskType.personal => 'Особисті',
    };
  }

  IconData get icon {
    return switch (this) {
      TaskType.all => Icons.format_list_bulleted,
      TaskType.work => Icons.work_outline,
      TaskType.personal => Icons.home_outlined,
    };
  }

  static TaskType fromValue(int? value) {
    return TaskType.values.firstWhereOrNull((e) => e.serverValue == value) ?? TaskType.personal;
  }

  int get serverValue {
    return switch (this) {
      TaskType.work => 1,
      TaskType.personal => 2,
      TaskType.all => -1,
    };
  }

  static const List<TaskType> creatable = [TaskType.work, TaskType.personal];
}
