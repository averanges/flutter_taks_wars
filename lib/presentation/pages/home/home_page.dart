import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/domain/enums/task_status.dart';
import 'package:flutter_soft_wars/domain/enums/task_type.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_soft_wars/presentation/navigation/app_router.dart';
import 'package:flutter_soft_wars/widget/dialogs/dialog_helper.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/filter_button_widget.dart';
import 'package:flutter_soft_wars/widget/card/task_card_widget.dart';
import 'package:flutter_soft_wars/widget/scaffold_widget.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TasksBloc>().add(const TasksLoadEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) async {
        if (state is TasksErrorState && state.networkError != null) {
          await DialogHelper.showErrorDialog(context, message: state.networkError?.userMessage ?? '');
        }
      },
      child: ScaffoldWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.push(AppRouter.creationTask);
            context.read<TasksBloc>().add(const TasksLoadEvent());
          },
          backgroundColor: AppColors.primaryVariant,
          child: const Icon(Icons.add, color: AppColors.secondaryVariant, size: 40),
        ),
        body: const _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          _FilterCategoryWidget(),
          Expanded(child: _TasksWidget()),
        ],
      ),
    );
  }
}

class _FilterCategoryWidget extends StatelessWidget {
  const _FilterCategoryWidget();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Row(
            children: List.generate(TaskType.values.length, (index) {
              final category = TaskType.values[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterButtonWidget(
                  title: category.title,
                  isSelected: state.category == category,
                  onPressed: () {
                    context.read<TasksBloc>().add(TasksLoadEvent(category: category));
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _TasksWidget extends StatelessWidget {
  const _TasksWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        return state.tasks.isEmpty ? const _EmptyTasksWidget() : _TaskListWidget(tasks: state.tasks);
      },
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({required this.tasks});

  final List<TaskDomain> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCardWidget(
          task: task,
          onPressed: () async {
            await context.push(AppRouter.creationTask, extra: task);
            context.read<TasksBloc>().add(const TasksLoadEvent());
          },
          onToggle: () {
            final newStatus = task.status == TaskStatus.active ? TaskStatus.completed : TaskStatus.active;
            final newTask = task.copyWith(status: newStatus);
            context.read<TasksBloc>().add(TasksChangeStatusEvent(task: newTask));
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}

class _EmptyTasksWidget extends StatelessWidget {
  const _EmptyTasksWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Схоже, список порожній. Додайте завдання',
        style: AppTextStyle.medium18.copyWith(color: AppColors.accentRed),
        textAlign: TextAlign.center,
      ),
    );
  }
}
