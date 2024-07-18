import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  List<TaskModel> _taskList = [];
  String _errorMessage = '';

  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;

  List<TaskModel> get cancelledTaskList => _taskList;

  String get errorMessage => _errorMessage;

  Future<bool> getCancelledTasks() async {
    bool isSuccess = false;
    _getCancelledTasksInProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? 'Get cancelled task failed! Try again';
    }

    _getCancelledTasksInProgress = false;
    update();

    return isSuccess;
  }
}
