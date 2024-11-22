import 'package:firebase_auth_example/feature/task/model/task_model.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskById(String taskId);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}
