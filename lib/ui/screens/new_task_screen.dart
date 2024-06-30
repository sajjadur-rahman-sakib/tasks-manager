import 'package:flutter/material.dart';
import 'package:sakib/data/models/network_response.dart';
import 'package:sakib/data/models/task_list_wrapper_model.dart';
import 'package:sakib/data/models/task_model.dart';
import 'package:sakib/data/network_caller/network_caller.dart';
import 'package:sakib/data/utilities/urls.dart';
import 'package:sakib/ui/screens/add_new_task_screen.dart';
import 'package:sakib/ui/utility/app_colors.dart';
import 'package:sakib/ui/widgets/centered_progress_indicator.dart';
import 'package:sakib/ui/widgets/snack_bar_message.dart';
import 'package:sakib/ui/widgets/task_item.dart';
import 'package:sakib/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTasksInProgress = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTasks();
                },
                child: Visibility(
                  visible: _getNewTasksInProgress == false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Widget _buildSummarySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            count: '12',
            title: 'New Task',
          ),
          TaskSummaryCard(
            count: '23',
            title: 'Progress',
          ),
          TaskSummaryCard(
            count: '45',
            title: 'Completed',
          ),
          TaskSummaryCard(
            count: '08',
            title: 'Cancelled',
          ),
        ],
      ),
    );
  }

  Future<void> _getNewTasks() async {
    _getNewTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get new task failed! Try again');
      }
    }

    _getNewTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
