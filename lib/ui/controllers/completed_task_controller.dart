import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CompletedTaskController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;

  List<TaskModel> get completedTaskList => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getCompletedTasks() async {
    bool isSuccess = false;
    _getCompletedTasksInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get completed task failed! Try again';
    }

    _getCompletedTasksInProgress = false;
    update();

    return isSuccess;
  }
}
