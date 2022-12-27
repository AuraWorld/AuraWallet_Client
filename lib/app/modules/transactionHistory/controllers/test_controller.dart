import 'package:get/get.dart';

class TransactionHistoryController extends GetxController {
  final hash  = ''.obs;
  void setHash (data) => hash.value= data;
}
