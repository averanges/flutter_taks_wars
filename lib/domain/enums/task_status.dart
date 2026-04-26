import 'package:collection/collection.dart';

enum TaskStatus {
  active,
  completed;

  static TaskStatus fromValue(int? value) {
    return TaskStatus.values.firstWhereOrNull((e) => e.serverValue == value) ?? TaskStatus.active;
  }

  int get serverValue {
    return switch (this) {
      TaskStatus.active => 1,
      TaskStatus.completed => 2,
    };
  }
}
