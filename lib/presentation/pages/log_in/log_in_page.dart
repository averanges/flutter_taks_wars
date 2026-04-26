import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/core/utils/validators/field_validator.dart';
import 'package:flutter_soft_wars/di/injector.dart';
import 'package:flutter_soft_wars/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_soft_wars/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:flutter_soft_wars/presentation/navigation/app_router.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/main_button_widget.dart';
import 'package:flutter_soft_wars/widget/scaffold_widget.dart';
import 'package:flutter_soft_wars/widget/text_field_border_widget.dart';
import 'package:go_router/go_router.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  void _showEmailDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(create: (context) => inject<SignInBloc>(), child: const _EmailInputDialog()),
    );
    if (result == true) {
      context.go(AppRouter.tasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadedState && state.email?.isNotEmpty == true) {
          context.go(AppRouter.tasks);
        }
      },
      child: ScaffoldWidget(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                const Spacer(flex: 556),
                MainButtonWidget(title: 'Вхід', onPressed: () => _showEmailDialog(context)),
                const Spacer(flex: 206),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInputDialog extends StatefulWidget {
  const _EmailInputDialog();

  @override
  State<_EmailInputDialog> createState() => _EmailInputDialogState();
}

class _EmailInputDialogState extends State<_EmailInputDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          context.pop(true);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Введіть пошту',
                style: AppTextStyle.semibold24.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return TextFieldBorderWidget(
                    controller: _controller,
                    focusNode: _focusNode,
                    hintText: 'e.example@gmail.com',
                    enabled: state is! SignInLoadingState,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => context.read<SignInBloc>().add(SignInSubmittedEvent(value.trim())),
                    errorText: state is SignInErrorState
                        ? state.error
                        : (_controller.text.trim().isNotEmpty
                              ? FieldValidator.validateEmail(_controller.text.trim())?.message
                              : null),
                  );
                },
              ),

              const SizedBox(height: 32),

              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  final isLoading = state is SignInLoadingState;

                  return MainButtonWidget(
                    title: isLoading ? 'Вхід...' : 'Увійти',
                    backgroundColor: isLoading
                        ? AppColors.primaryVariant.withValues(alpha: 0.7)
                        : AppColors.primaryVariant,
                    onPressed: isLoading
                        ? null
                        : () => context.read<SignInBloc>().add(SignInSubmittedEvent(_controller.text.trim())),
                  );
                },
              ),

              const SizedBox(height: 12),
              MainButtonWidget(
                title: 'Скасувати',
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.primary,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
