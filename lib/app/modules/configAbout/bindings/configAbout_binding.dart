import 'package:get/get.dart';

import '../controllers/configAbout_controller.dart';

class ConfigAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigAboutController>(
      () => ConfigAboutController(),
    );
  }
}
