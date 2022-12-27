import 'package:get/get.dart';

import '../controllers/explorer_Info_controller.dart';

class Explorer_InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Explorer_InfoController>(
      () => Explorer_InfoController(),
    );
  }
}
