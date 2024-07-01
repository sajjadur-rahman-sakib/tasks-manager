import 'package:flutter/material.dart';
import 'package:sakib/data/models/network_response.dart';
import 'package:sakib/data/models/task_list_wrapper_model.dart';
import 'package:sakib/data/models/task_model.dart';
import 'package:sakib/data/network_caller/network_caller.dart';
import 'package:sakib/data/utilities/urls.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/snack_bar_message.dart';
import 'package:sakib/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTasksInProgress = false;
  List<TaskModel> completedTasks = [];

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
          visible: _getCompletedTasksInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: completedTasks[index],
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
    _getCompletedTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      completedTasks = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get new task failed! Try again');
      }
    }

    _getCompletedTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
