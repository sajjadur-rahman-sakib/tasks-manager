import 'package:get/get.dart';
import 'package:sakib/ui/controllers/cancelled_task_controller.dart';
import 'package:sakib/ui/controllers/completed_task_controller.dart';
import 'package:sakib/ui/controllers/new_task_controller.dart';
import 'package:sakib/ui/controllers/progress_task_controller.dart';
import 'package:sakib/ui/controllers/sign_in_controller.dart';
import 'package:sakib/ui/controllers/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelledTaskController());
  }
}
