import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class ProgressTaskController extends GetxController {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getProgressTasksInProgress => _getProgressTasksInProgress;

  List<TaskModel> get progressTaskList => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getProgressTasks() async {
    bool isSuccess = false;
    _getProgressTasksInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.progressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get progress task failed! Try again';
    }

    _getProgressTasksInProgress = false;
    update();

    return isSuccess;
  }
}
