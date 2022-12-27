import 'package:get/get.dart';

import '../controllers/createAccountStep1_controller.dart';


class CreateAccountStep1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountStep1Controller>(
      () => CreateAccountStep1Controller(),
    );
  }
}
