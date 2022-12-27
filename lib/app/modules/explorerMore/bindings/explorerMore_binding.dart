import 'package:get/get.dart';

import '../controllers/explorerMore_controller.dart';

class ExplorerMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExplorerMoreController>(
      () => ExplorerMoreController(),
    );
  }
}
