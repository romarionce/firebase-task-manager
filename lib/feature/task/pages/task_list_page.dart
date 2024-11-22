import 'package:firebase_auth_example/common/ui/cupertino_icon_button.dart';
import 'package:firebase_auth_example/feature/settings/pages/settings_page.dart';
import 'package:firebase_auth_example/feature/task/cubit/task_list/task_list_cubit.dart';
import 'package:firebase_auth_example/feature/task/cubit/task_list/task_list_cubit_state.dart';
import 'package:firebase_auth_example/feature/task/pages/new_task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static const String path = '/tasks';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoIconButton(
          onPressed: () => context.go(NewTaskPage.path),
          icon: CupertinoIcons.add,
        ),
        middle: const Text("Tasks"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoIconButton(
              onPressed: TaskListCubit.i(context).loadTasks,
              icon: CupertinoIcons.arrow_clockwise,
            ),
            CupertinoIconButton(
              onPressed: () => context.go(SettingsPage.path),
              icon: CupertinoIcons.settings,
            ),
          ],
        ),
      ),
      child: BlocBuilder<TaskListCubit, TaskListCubitState>(
        builder: (context, state) {
          if (state is TaskListStateLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is TaskListStateSuccess) {
            if (state.taskList.isEmpty) {
              return const Center(
                child: Text("Список задач пуст!"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final task = state.taskList[index];
                return Dismissible(
                  key: ValueKey(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: CupertinoColors.systemRed,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(CupertinoIcons.delete,
                          color: CupertinoColors.white),
                    ),
                  ),
                  onDismissed: (direction) =>
                      TaskListCubit.i(context).removeTask(task),
                  child: CupertinoListTile(
                    leading: CupertinoCheckbox(
                      value: task.isCompleted,
                      onChanged: (v) => TaskListCubit.i(context)
                          .changeCompleteStatusTask(task),
                    ),
                    title: Text(task.title),
                    subtitle: Text(
                      task.description,
                      maxLines: 3,
                    ),
                    additionalInfo: Builder(
                      builder: (context) {
                        final isExpired =
                            task.dueDate.isBefore(DateTime.now()) &&
                                !task.isCompleted;

                        return Text(
                          DateFormat.MMMMEEEEd().format(task.dueDate),
                          style: TextStyle(
                            color: isExpired
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemBlue,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: state.taskList.length,
            );
          }
          if (state is TaskListStateFailure) {
            return Center(
              child: Text(
                "ERROR ${state.error}",
                style: const TextStyle(color: CupertinoColors.systemRed),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
