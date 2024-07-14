import 'package:flutter/material.dart';
import 'package:sakib/data/models/network_response.dart';
import 'package:sakib/data/models/task_list_wrapper_model.dart';
import 'package:sakib/data/models/task_model.dart';
import 'package:sakib/data/network_caller/network_caller.dart';
import 'package:sakib/data/utilities/urls.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/snack_bar_message.dart';
import 'package:sakib/ui/widgets/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> progressTasks = [];

  @override
  void initState() {
    super.initState();
    _getProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getProgressTasks(),
        child: Visibility(
          visible: _getProgressTasksInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: progressTasks.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskModel: progressTasks[index],
                  onUpdateTask: () {
                    _getProgressTasks();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.progressTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      progressTasks = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get progress task failed! Try again');
      }
    }

    _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
