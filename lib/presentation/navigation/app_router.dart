import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/di/injector.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_soft_wars/presentation/blocs/task/task_bloc.dart';
import 'package:flutter_soft_wars/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_soft_wars/presentation/pages/home/home_page.dart';
import 'package:flutter_soft_wars/presentation/pages/log_in/log_in_page.dart';
import 'package:flutter_soft_wars/presentation/pages/task/task_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String initial = '/initial';
  static const String tasks = '/tasks';
  static const String creationTask = '/creation_task';

  static List<RouteBase> get routes => [
    GoRoute(
      path: initial,
      builder: (context, state) {
        return BlocProvider(create: (_) => inject<AuthBloc>()..add(const AuthInitEvent()), child: const LogInPage());
      },
    ),
    GoRoute(
      path: tasks,
      builder: (context, state) {
        return BlocProvider(create: (_) => inject<TasksBloc>(), child: const HomePage());
      },
    ),
    GoRoute(
      path: creationTask,
      builder: (context, state) {
        final task = state.extra as TaskDomain?;
        return BlocProvider(
          create: (_) => inject<TaskBloc>(),
          child: TaskPage(task: task),
        );
      },
    ),
  ];
}
