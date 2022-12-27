import 'package:get/get.dart';

class ConfigWalletListController extends GetxController {

  final copyState = false.obs;
  @override


  void setCopyState() =>{
    copyState.value = true,
    Future.delayed(Duration(seconds: 2), (){
      copyState.value = false;
    }),
    print(copyState.value)
  } ;
}
