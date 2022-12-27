import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TransactionHistory extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionHistoryController>(
      () => TransactionHistoryController(),
    );
  }
}
