import 'package:get/get.dart';

import '../controllers/configEditAddressBook_controller.dart';


class ConfigEditAddressBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigEditAddressBookController>(
      () => ConfigEditAddressBookController(),
    );
  }
}
