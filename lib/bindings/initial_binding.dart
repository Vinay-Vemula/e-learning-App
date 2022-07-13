import 'package:get/instance_manager.dart';
import 'package:perfex_e_learning/controllers/appcontroller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(
      AppController(),
      permanent: true,
    );
  }
}
