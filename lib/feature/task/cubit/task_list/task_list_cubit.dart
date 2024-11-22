import 'package:firebase_auth_example/feature/task/model/task_model.dart';
import 'package:firebase_auth_example/feature/task/cubit/task_list/task_list_cubit_state.dart';
import 'package:firebase_auth_example/feature/task/repository/task_repository_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListCubit extends Cubit<TaskListCubitState> {
  final ITaskRepository _taskRepository;

  TaskListCubit(this._taskRepository) : super(TaskListStateLoading()) {
    //* при создании кубита мы сразу грузим таски
    loadTasks();
  }

  static TaskListCubit i(BuildContext context) => context.read<TaskListCubit>();

  Future<void> loadTasks({bool withReload = true}) async {
    if (withReload) emit(TaskListStateLoading());
    try {
      final taskList = await _taskRepository.getTasks();
      emit(TaskListStateSuccess(taskList: taskList));
    } catch (e) {
      emit(TaskListStateFailure(error: e));
    }
  }

  Future<void> createTask(TaskModel task) async {
    emit(TaskListStateLoading());
    try {
      await _taskRepository.addTask(task);
      await loadTasks(withReload: false);
    } catch (e) {
      emit(TaskListStateFailure(error: e));
    }
  }

  Future<void> removeTask(TaskModel task) async {
    try {
      await _taskRepository.deleteTask(task.id);
      await loadTasks(withReload: false);
    } catch (e) {
      emit(TaskListStateFailure(error: e));
    }
  }

  Future<void> changeCompleteStatusTask(TaskModel task) async {
    try {
      await _taskRepository.updateTask(
        task.copyWith(isCompleted: !task.isCompleted),
      );
      loadTasks(withReload: false);
    } catch (e) {
      emit(TaskListStateFailure(error: e));
    }
  }
}
