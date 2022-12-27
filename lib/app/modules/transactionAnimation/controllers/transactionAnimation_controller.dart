import 'package:get/get.dart';

class TransactionAnimationController extends GetxController {
  final h1 = "Your NFT has been successfully sent to the".obs;
  final state = false.obs;

  final type = "TokenOrNFT".obs;
  @override

  void setType(data) => type.value = data;
  void SetState() => state.value=true;
  void setH1(data) => h1.value=data;
}
