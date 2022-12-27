import 'package:get/get.dart';

import '../controllers/NFTInfo_controller.dart';


class NFTInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NFTInfoController>(
      () => NFTInfoController(),
    );
  }
}
