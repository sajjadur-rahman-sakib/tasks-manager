import 'package:get/get.dart';
import 'package:sakib/ui/controllers/new_task_controller.dart';
import 'package:sakib/ui/controllers/sign_in_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => NewTaskController());
  }
}
