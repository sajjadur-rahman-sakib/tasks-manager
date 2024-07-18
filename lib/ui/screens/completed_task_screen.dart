import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/task_item.dart';

import '../controllers/completed_task_controller.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CompletedTaskController>().getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _initialCall(),
        child: GetBuilder<CompletedTaskController>(
          builder: (completedTaskController) {
            return Visibility(
              visible:
                  completedTaskController.getCompletedTasksInProgress == false,
              replacement: const CenteredProgressIndicator(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: completedTaskController.completedTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          completedTaskController.completedTaskList[index],
                      onUpdateTask: () {
                        _initialCall();
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
