import 'package:get/get.dart';

import '../controllers/createAccountStep2_controller.dart';



class CreateAccountStep2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAccountStep2Controller>(
      () => CreateAccountStep2Controller(),
    );
  }
}
