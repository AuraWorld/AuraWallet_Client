import 'package:get/get.dart';

import '../controllers/configAddressBookList_controller.dart';

class ConfigAddressBookListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigAddressBookListController>(
      () => ConfigAddressBookListController(),
    );
  }
}
