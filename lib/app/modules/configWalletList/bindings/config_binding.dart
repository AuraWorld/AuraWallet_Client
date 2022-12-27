import 'package:get/get.dart';

import '../controllers/config_controller.dart';

class ConfigWalletListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigWalletListController>(
      () => ConfigWalletListController(),
    );
  }
}
