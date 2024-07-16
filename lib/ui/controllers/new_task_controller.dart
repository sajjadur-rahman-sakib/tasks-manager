import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class NewTaskController extends GetxController {
  bool _getNewTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getNewTasksInProgress => _getNewTasksInProgress;

  List<TaskModel> get newTaskList => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getNewTasks() async {
    bool isSuccess = false;
    _getNewTasksInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? 'Get new task failed! Try again';
    }

    _getNewTasksInProgress = false;
    update();

    return isSuccess;
  }
}
