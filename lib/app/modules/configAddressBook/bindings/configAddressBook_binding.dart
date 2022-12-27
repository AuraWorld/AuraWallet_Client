import 'package:get/get.dart';

import '../controllers/configAddressBook_controller.dart';


class ConfigAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigAddressBookController>(
      () => ConfigAddressBookController(),
    );
  }
}
