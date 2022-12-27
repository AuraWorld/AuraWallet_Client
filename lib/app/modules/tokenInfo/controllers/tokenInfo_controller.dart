import 'package:get/get.dart';

class TokenInfoController extends GetxController {
  //TODO: Implement HomeController
  final copyState = "Copy".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCopyState() =>{
    copyState.value = "Copied !",
    Future.delayed(Duration(seconds: 2), (){
      copyState.value = "Copy";
    })
  } ;
}
