import 'package:get/get.dart';

import '../controllers/avatar_controller.dart';


class AvatarInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AvatarInfoController>(
      () => AvatarInfoController(),
    );
  }
}
