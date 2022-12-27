import 'dart:convert';
import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';
// import 'package:w3_wallet/web3/balance.dart';


class ConfigController extends GetxController {

  final box = GetStorage();

  final walletIndex = 0.obs;
  final walletInfo  = [].obs;
  final count = 0.obs;
  final netWork = {}.obs;
  final explorer = ''.obs;


  String interceptAddress (address){
   final str = address;
   final i = 4;
   final newAddressTop = str.substring(0,i);
   final newAddressBottom = str.substring(str.length-i);

   final newAddress = newAddressTop+"..."+newAddressBottom;
   return newAddress;
  }
  @override

  void onInit() {
    super.onInit();
  }

  void addressIndex (value){
    if(box.read('addressIndex')==null) {
      box.write("addressIndex", 0);
    }else{
      box.write("addressIndex", value);
    }
    setWalletsInfo();
  }

  void createAddress (value) {

    if(box.read('address')==null){
      box.write("address", [value]);
      print('第一次------------$value');

    }else{
      //添加
      box.read('address').add(value);
      box.write("address",box.read('address'));
      //修改
      // box.read('address')[0]["address"] = "xxxxxxxx";

      // box.write("address",newData );
      print("第二次--------------${box.read('address')}",);
    }

  }

  void removeAddress(index){

      box.read('address').removeAt(index);
      box.write("address",box.read('address'));
      box.write("addressIndex", 0);
      setWalletsInfo();
  }

  void setWalletsInfo() =>{
    walletInfo.value = box.read('address'),
    walletIndex.value = box.read('addressIndex'),
    walletInfo.refresh(),
    walletIndex.refresh(),
  };

  void setNFTImg(data) =>{
    box.read('address')[box.read('addressIndex')]["nft"] = data,
    box.write("address",box.read('address')),
    setWalletsInfo(),
  };

  void setWalletName(name,index) =>{
    box.read('address')[index]["name"] = name,
    box.write("address",box.read('address')),
    setWalletsInfo(),
    // box.read('address')[0]["address"] = "xxxxxxxx";
  };

  void setNetWorkInfo() =>{
    netWork.value = box.read('NetWork'),
    netWork.refresh(),
  };

  void setNetWorksState(data) async=>{
    box.write("NetWork",data),
    setNetWorkInfo(),

  };

  void setExplorerInfo() =>{
    explorer.value = box.read('Explorer'),

    explorer.refresh(),
  };

  void setExplorer(data) async=>{
    box.write("Explorer",data),
    setExplorerInfo()
  } ;


}
