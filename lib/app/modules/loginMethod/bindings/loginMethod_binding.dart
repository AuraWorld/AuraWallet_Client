import 'package:get/get.dart';

import '../controllers/loginMethod_controller.dart';

class LoginMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginMethodController>(
      () => LoginMethodController(),
    );
  }
}
