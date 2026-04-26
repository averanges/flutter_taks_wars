import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';

enum TaskUrgent {
  normal,
  urgent;

  static TaskUrgent fromValue(int? value) {
    return TaskUrgent.values.firstWhereOrNull((e) => e.serverValue == value) ?? TaskUrgent.normal;
  }

  int get serverValue {
    return switch (this) {
      TaskUrgent.normal => 0,
      TaskUrgent.urgent => 1,
    };
  }

  Color get backgroundColor {
    return switch (this) {
      TaskUrgent.normal => AppColors.primary,
      TaskUrgent.urgent => AppColors.accentRed,
    };
  }
}
