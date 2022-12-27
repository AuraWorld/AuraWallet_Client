import 'package:get/get.dart';

class ConfigAboutController extends GetxController {

  final WalletName   = "Wallet1".obs;
  final count = 0.obs;
  final netWork = "Main Network Beta".obs;
  final explorer = "W3G".obs;
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

  void setWalletName(data) =>{
    if(data ==""){
     print("错误")
    }else{
      WalletName.value = data
    }

  };


  void setNetWorkState(data) async=>{
    netWork.value = data,
    print(netWork.value)
  } ;
  void setExplorer(data) async=>{
    explorer.value = data,
    print(explorer.value)
  } ;

}
