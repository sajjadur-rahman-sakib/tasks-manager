import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/task_item.dart';
import '../controllers/progress_task_controller.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<ProgressTaskController>().getProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _initialCall(),
        child: GetBuilder<ProgressTaskController>(
            builder: (progressTaskController) {
          return Visibility(
            visible: progressTaskController.getProgressTasksInProgress == false,
            replacement: const CenteredProgressIndicator(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: progressTaskController.progressTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: progressTaskController.progressTaskList[index],
                    onUpdateTask: () {
                      _initialCall();
                    },
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
