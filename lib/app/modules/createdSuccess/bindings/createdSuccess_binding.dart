import 'package:get/get.dart';

import '../views/createdSuccess_view.dart';

class CreatedSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatedSuccessView>(
      () => CreatedSuccessView(),
    );
  }
}
