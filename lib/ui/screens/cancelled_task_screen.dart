import 'package:flutter/material.dart';
import 'package:sakib/data/models/network_response.dart';
import 'package:sakib/data/models/task_list_wrapper_model.dart';
import 'package:sakib/data/models/task_model.dart';
import 'package:sakib/data/network_caller/network_caller.dart';
import 'package:sakib/data/utilities/urls.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/snack_bar_message.dart';
import 'package:sakib/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTasksInProgress = false;
  List<TaskModel> cancelledTasks = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getCompletedTasks(),
        child: Visibility(
          visible: _getCancelledTasksInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: cancelledTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: cancelledTasks[index],
                onUpdateTask: () {
                  _getCompletedTasks();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTasks() async {
    _getCancelledTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelledTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      cancelledTasks = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get cancelled task failed! Try again');
      }
    }

    _getCancelledTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
