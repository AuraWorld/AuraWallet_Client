import 'package:get/get.dart';

import '../controllers/manageTokenList_controller.dart';

class ManageTokenListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageTokenListController>(
      () => ManageTokenListController(),
    );
  }
}
