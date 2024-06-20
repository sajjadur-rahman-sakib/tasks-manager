import 'package:flutter/material.dart';
import 'package:sakib/ui/screens/add_new_task_screen.dart';
import 'package:sakib/ui/utility/app_colors.dart';
import 'package:sakib/ui/widgets/task_item.dart';
import 'package:sakib/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskItem();
                },
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen(),),);
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
}
