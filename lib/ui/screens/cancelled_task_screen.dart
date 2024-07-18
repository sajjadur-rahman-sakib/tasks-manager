import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/task_item.dart';
import '../controllers/cancelled_task_controller.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CancelledTaskController>().getCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _initialCall(),
        child: GetBuilder<CancelledTaskController>(
          builder: (cancelledTaskController) {
            return Visibility(
              visible:
                  cancelledTaskController.getCancelledTasksInProgress == false,
              replacement: const CenteredProgressIndicator(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: cancelledTaskController.cancelledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          cancelledTaskController.cancelledTaskList[index],
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
