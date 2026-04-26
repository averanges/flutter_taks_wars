import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_soft_wars/core/extensions/date_time_extension.dart';
import 'package:flutter_soft_wars/core/utils/validators/field_validator.dart';
import 'package:flutter_soft_wars/domain/entities/task_domain.dart';
import 'package:flutter_soft_wars/domain/enums/task_type.dart';
import 'package:flutter_soft_wars/domain/enums/task_urgent.dart';
import 'package:flutter_soft_wars/presentation/blocs/task/task_bloc.dart';
import 'package:flutter_soft_wars/presentation/navigation/routes.dart';
import 'package:flutter_soft_wars/resources/themes/app_colors.dart';
import 'package:flutter_soft_wars/resources/themes/app_text_style.dart';
import 'package:flutter_soft_wars/widget/button/custom_radio_widget.dart';
import 'package:flutter_soft_wars/widget/button/main_button_widget.dart';
import 'package:flutter_soft_wars/widget/button/checkbox_widget.dart';
import 'package:flutter_soft_wars/widget/dialogs/dialog_helper.dart';
import 'package:flutter_soft_wars/widget/scaffold_widget.dart';
import 'package:flutter_soft_wars/widget/text_field_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.task});

  final TaskDomain? task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late TaskDomain _task;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _task = widget.task ?? TaskDomain.empty(taskId: const Uuid().v4());
    _init();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _init() {
    _nameController.text = _task.name;
    _descriptionController.text = _task.description;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_task.finishDate == null) {
      await DialogHelper.showErrorDialog(
        context,
        message: 'Будь ласка, оберіть дату завершення, щоб створити завдання.',
      );
      return;
    }

    final task = _task.copyWith(name: _nameController.text.trim(), description: _descriptionController.text.trim());

    context.read<TaskBloc>().add(TaskSubmitEvent(task: task));
  }

  void _delete() {
    context.read<TaskBloc>().add(TaskDeleteEvent(taskId: _task.taskId));
  }

  Future<void> _onDatePickTap() async {
    final today = DateTime.now();

    final result = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365 * 10)),
      helpText: 'Виберіть дату',
      cancelText: 'Скасувати',
      confirmText: 'Вибрати',
    );

    if (result != null) {
      setState(() {
        _task = _task.copyWith(finishDate: result);
      });
    }
  }

  Future<void> _onImagePickTap() async {
    final imagePicker = ImagePicker();

    try {
      final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file == null) return;

      final bytes = await file.readAsBytes();
      final image = base64Encode(bytes);

      setState(() {
        _task = _task.copyWith(file: image);
      });
    } catch (_) {
      return;
    }
  }

  String? _nameValidator(String? value) {
    final text = (value ?? _nameController.text).trim();

    final failure = FieldValidator.required(text, 'Назва');
    return failure?.message;
  }

  Widget _buildSubmitOrDeleteButton() {
    if (_task.id.isEmpty) {
      return _SubmitButtonWidget(onPressed: _submit);
    } else {
      return _DeleteButtonWidget(onPressed: _delete);
    }
  }

  void _onUrgentToggle() {
    setState(() {
      final newUrgent = _task.urgent == TaskUrgent.normal ? TaskUrgent.urgent : TaskUrgent.normal;

      _task = _task.copyWith(urgent: newUrgent);
    });
  }

  void _onCategoryChanged(TaskType type) {
    setState(() {
      _task = _task.copyWith(type: type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) async {
        if (state is TaskErrorState && state.networkError != null) {
          await DialogHelper.showErrorDialog(context, message: state.networkError?.userMessage ?? '');
        }
        if (state is TaskSuccessState) {
          Routes.pop(context);
        }
      },
      child: ScaffoldWidget(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 32, bottom: 23, right: 18),
                  child: _AppBarWidget(
                    controller: _nameController,
                    validator: _nameValidator,
                    onPressed: _task.id.isEmpty ? null : _submit,
                  ),
                ),
                _TaskCategoryRadioGroupWidget(
                  categories: TaskType.creatable,
                  selected: _task.type,
                  onChanged: _onCategoryChanged,
                ),
                const SizedBox(height: 8),
                _DescriptionWidget(controller: _descriptionController),
                const SizedBox(height: 8),
                _ImageInsertionButtonWidget(task: _task, onTap: _onImagePickTap),
                const SizedBox(height: 8),
                _DateInsertionButtonWidget(task: _task, onTap: _onDatePickTap),
                const SizedBox(height: 8),
                _ImportantFlagButtonWidget(urgent: _task.urgent, onToggle: _onUrgentToggle),
                const SizedBox(height: 24),
                _buildSubmitOrDeleteButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({required this.controller, this.validator, required this.onPressed});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: AppColors.primaryVariant),
          onPressed: () {
            Routes.pop(context);
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFieldWidget(
            controller: controller,
            hintText: 'Назва завдання...',
            validator: validator,
            textStyle: AppTextStyle.semibold24.copyWith(color: AppColors.primary),
            hintStyle: AppTextStyle.semibold24.copyWith(color: AppColors.secondary),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
        ),
        if (onPressed != null)
          IconButton(
            icon: const Icon(Icons.done, color: AppColors.primaryVariant, size: 30),
            onPressed: onPressed,
          ),
      ],
    );
  }
}

class _TaskCategoryRadioGroupWidget extends StatelessWidget {
  const _TaskCategoryRadioGroupWidget({required this.categories, required this.selected, required this.onChanged});

  final List<TaskType> categories;
  final TaskType selected;
  final ValueChanged<TaskType> onChanged;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;
    const spacingBetweenItems = 90.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - horizontalPadding - spacingBetweenItems) / 2;

    return Container(
      height: 50,
      color: AppColors.secondaryVariant,
      padding: const EdgeInsets.only(left: horizontalPadding, top: 10),
      child: Wrap(
        spacing: spacingBetweenItems,
        children: categories.map((category) {
          return SizedBox(
            width: itemWidth,
            child: CustomRadioWidget(
              label: category.title,
              isSelected: category == selected,
              onTap: () => onChanged(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: controller,
      hintText: 'Додати опис…',
      isMultiline: true,
      height: 98,
      textStyle: AppTextStyle.semibold24.copyWith(fontSize: 16, color: AppColors.primary),
      hintStyle: AppTextStyle.semibold24.copyWith(fontSize: 16, color: AppColors.secondary),
    );
  }
}

class _ImageInsertionButtonWidget extends StatelessWidget {
  const _ImageInsertionButtonWidget({required this.task, required this.onTap});

  final TaskDomain task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool hasFile = task.file?.isNotEmpty == true;

    return _CustomButtonWidget(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hasFile ? 'Вкладене зображення' : 'Прикріпити файл',
            style: AppTextStyle.semibold24.copyWith(fontSize: 18, color: AppColors.primary),
          ),
          if (hasFile)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.memory(width: 236, height: 236, base64ToImage(task.file ?? ''), fit: BoxFit.cover),
            ),
        ],
      ),
    );
  }

  Uint8List base64ToImage(String base64String) {
    return base64Decode(base64String);
  }
}

class _DateInsertionButtonWidget extends StatelessWidget {
  const _DateInsertionButtonWidget({required this.task, required this.onTap});

  final TaskDomain task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _CustomButtonWidget(
      onTap: onTap,
      child: Text(
        task.finishDate == null ? 'Дата завершення:' : task.finishDate?.dayMonthYear() ?? '',
        style: AppTextStyle.semibold24.copyWith(fontSize: 18, color: AppColors.primary),
      ),
    );
  }
}

class _ImportantFlagButtonWidget extends StatelessWidget {
  const _ImportantFlagButtonWidget({required this.urgent, required this.onToggle});

  final TaskUrgent urgent;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondaryVariant,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          CheckboxWidget(
            isActive: urgent == TaskUrgent.urgent,
            activeBorderColor: AppColors.secondaryVariant,
            inactiveBorderColor: AppColors.secondary,
            onToggle: onToggle,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text('Термінове', style: AppTextStyle.medium18.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _CustomButtonWidget extends StatelessWidget {
  const _CustomButtonWidget({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: AppColors.secondaryVariant,
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 13, right: 16),
        child: child,
      ),
    );
  }
}

class _SubmitButtonWidget extends StatelessWidget {
  const _SubmitButtonWidget({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainButtonWidget(title: 'Створити', onPressed: onPressed),
    );
  }
}

class _DeleteButtonWidget extends StatelessWidget {
  const _DeleteButtonWidget({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainButtonWidget(title: 'Видалити', backgroundColor: AppColors.accentRed, onPressed: onPressed),
    );
  }
}
