import 'package:get/get.dart';

class TokenController extends GetxController {

  final tokenName = "".obs;
  final copyState = "Copy".obs;

  final sendAddress = "".obs;

  final sendAddressToken ="0.00".obs;

  final AddressBalance = "0.00".obs;
  final TokenDecimals = "".obs;

  final TokenID = "".obs;
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
  void setSendAddress(data) =>{
    sendAddress.value = data
  };

  void setAddressBalance(data) =>{
    AddressBalance.value = data
  };

  void setTokenDecimals(data) =>{
    TokenDecimals.value = data
  };

  void setTokenID(data) =>{
    TokenID.value = data
  };


  void setSendAddressToken(data) =>{
      sendAddressToken.value = data,
      print(data)
  };
}
