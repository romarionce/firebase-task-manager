import 'package:firebase_auth_example/common/ui/cupertino_icon_button.dart';
import 'package:firebase_auth_example/feature/task/cubit/task_list/task_list_cubit.dart';
import 'package:firebase_auth_example/feature/task/model/task_model.dart';
import 'package:firebase_auth_example/feature/task/pages/task_list_page.dart';
import 'package:firebase_auth_example/feature/task/widgets/cant_create_task_dialog.dart';
import 'package:firebase_auth_example/feature/task/widgets/task_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  static const String path = '/new_task_page';

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy');

  @override
  void dispose() {
    super.dispose();
    //* При закрытии страницы необходимо избавиться от контроллеров
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void setSelectedDate(DateTime date) => setState(() => _selectedDate = date);

  bool get canSave =>
      _titleController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoIconButton(
          icon: CupertinoIcons.back,
          onPressed: () => context.go(TaskListPage.path),
        ),
        middle: const Text('New task'),
        trailing: CupertinoIconButton(
          icon: CupertinoIcons.checkmark_alt,
          onPressed: () async {
            if (!canSave) {
              showCupertinoDialog(
                context: context,
                builder: (context) => const CantCreateTaskDialog(),
              );
              return;
            }

            final newTask = TaskModel(
              title: _titleController.text,
              description: _descriptionController.text,
              dueDate: _selectedDate,
            );

            TaskListCubit.i(context).createTask(newTask);
            context.go(TaskListPage.path);
          },
          color: CupertinoColors.activeGreen,
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoFormRow(
              child: CupertinoTextField(
                controller: _titleController,
                placeholder: 'Task Name',
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
              ),
            ),
            CupertinoFormRow(
              child: CupertinoTextField(
                controller: _descriptionController,
                placeholder: 'Task Description',
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
                maxLines: 3,
              ),
            ),
            CupertinoFormRow(
              child: CupertinoListTile(
                padding: EdgeInsets.zero,
                leading: CupertinoIconButton(
                  icon: CupertinoIcons.calendar,
                  onPressed: () => showCupertinoModalPopup<DateTime>(
                    context: context,
                    builder: (_) => TaskDatePicker(
                      onDateChanged: setSelectedDate,
                      initialDateTime: _selectedDate,
                    ),
                  ),
                ),
                title: const Text('Due Date'),
                subtitle: Text(_dateFormat.format(_selectedDate)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
