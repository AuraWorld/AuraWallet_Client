import 'package:get/get.dart';

import '../controllers/tokenInfo_controller.dart';

class TokenInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TokenInfoController>(
      () => TokenInfoController(),
    );
  }
}
