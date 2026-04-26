import 'package:flutter/material.dart';
import 'package:flutter_soft_wars/core/extensions/date_time_extension.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/enums/task_status.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/checkbox_widget.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key, required this.task, required this.onToggle, required this.onPressed});

  final TaskDomain task;
  final VoidCallback onToggle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: task.urgent.backgroundColor,
        ),
        child: Row(
          children: [
            Icon(task.type.icon, size: 30, color: AppColors.secondaryVariant),
            const SizedBox(width: 5),
            _TaskInfo(task: task),
            const SizedBox(width: 5),
            CheckboxWidget(
              isActive: task.status == TaskStatus.completed,
              activeBorderColor: AppColors.secondaryVariant,
              inactiveBorderColor: AppColors.secondaryVariant,
              onToggle: onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskInfo extends StatelessWidget {
  const _TaskInfo({required this.task});

  final TaskDomain task;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.name,
            style: AppTextStyle.semibold24.copyWith(fontSize: 16, color: AppColors.secondaryVariant),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            task.finishDate == null ? '' : task.finishDate?.frontDayMonthYear() ?? '',
            style: AppTextStyle.regular10.copyWith(color: AppColors.secondaryVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
