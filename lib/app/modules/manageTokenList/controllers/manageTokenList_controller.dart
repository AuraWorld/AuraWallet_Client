import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';
import 'package:w3_wallet/utils/format.dart';

class ManageTokenListController extends GetxController {
  var dio = Dio();
  final box = GetStorage();
  final tokenList = [].obs;
  // tokenList = [{"name":"Web3Games","title":"W3G","showState":true,"amount":"0"}]

  void setTokenList () =>{
    tokenList.value = box.read('address')[box.read('addressIndex')]["tokenList"],
    tokenList.refresh()
  };
  void TokenList_add (data) =>{
    box.read('address')[box.read('addressIndex')]["tokenList"].add(data),
    box.write("addressBook",box.read('addressBook')),
    setTokenList(),

  };

  void seTokenListkName (index,name) =>{
    box.read('address')[box.read('addressIndex')]["tokenList"][index]["name"] =name,
    box.write("addressBook",box.read('addressBook')),
    setTokenList(),
  };

  void setTokenListToken (index,token) =>{
    box.read('address')[box.read('addressIndex')]["tokenList"][index]["token"] =token,
    box.write("addressBook",box.read('addressBook')),
    setTokenList(),

  };

  void setTokenListShowState (index,showState) =>{
    box.read('address')[box.read('addressIndex')]["tokenList"][index]["showState"] =showState,
    box.write("addressBook",box.read('addressBook')),
    setTokenList(),
  };

  formatNum(double num,int postion){
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      //小数点后有几位小数
      return( num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
    }else{
      return( num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
    }
  }



  Future<void> setW3GToken(address) async {
    final W3GBalance = await dio.post('https://wallet-dev-restful-api.web3games.org/GetChainTokenBalance',
        data: {"address": "$address",});

    final index = box.read('address')[box.read('addressIndex')]["tokenList"].indexWhere((v) =>v["name"] =="Web3Games");

    final W3GBalanceData = W3GBalance.data["res"]["chain_token_balance"];

    var W3G_balance = Fmt.balance(W3GBalanceData,18);
    // var W3G_balance = Decimal.parse(formatNum(int.parse(W3GBalanceData)/pow(10,18),4)).toString();
    box.read('address')[box.read('addressIndex')]["tokenList"][index]["amount"] =W3G_balance;

    for(int i = 1; i<(box.read('address')[box.read('addressIndex')]["tokenList"]).length; i++){

      var tokenID =  box.read('address')[box.read('addressIndex')]["tokenList"][i]["tokenID"];

      var tokenDecimals = box.read('address')[box.read('addressIndex')]["tokenList"][i]["decimals"];

      final response = await dio.post('https://wallet-dev-restful-api.web3games.org/GetTokenBalance',
          data: {"address": "$address",
          "fungible_token_Id":"$tokenID"});

      var fungible_token_balance = Fmt.balance((response.data["res"]["fungible_token_balance"]),int.parse(tokenDecimals));
       box.read('address')[box.read('addressIndex')]["tokenList"][i]["amount"] =
      "${fungible_token_balance == null? 0 : "$fungible_token_balance"}";

    }
    box.write("addressBook",box.read('addressBook'));
    setTokenList();
  }


}
