import 'package:get/get.dart';

import '../controllers/addTokenList_controller.dart';

class AddTokenListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTokenListController>(
      () => AddTokenListController(),
    );
  }
}
