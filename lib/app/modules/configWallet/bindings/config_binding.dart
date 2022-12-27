import 'package:get/get.dart';

import '../controllers/config_controller.dart';

class ConfigWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigWalletController>(
      () => ConfigWalletController(),
    );
  }
}
