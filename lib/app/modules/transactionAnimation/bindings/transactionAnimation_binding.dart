import 'package:get/get.dart';

import '../controllers/transactionAnimation_controller.dart';

class TransactionAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionAnimationController>(
      () => TransactionAnimationController(),
    );
  }
}
