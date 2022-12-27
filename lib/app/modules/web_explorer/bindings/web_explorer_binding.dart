import 'package:get/get.dart';

import '../controllers/web_explorer_controller.dart';

class WebExplorerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebExplorerController>(
      () => WebExplorerController(),
    );
  }
}
