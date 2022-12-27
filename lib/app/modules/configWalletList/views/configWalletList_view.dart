import 'dart:math';
import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_sdk/api/types/addressIconData.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';


import '../../avatar/controllers/avatar_controller.dart';
import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../controllers/config_controller.dart';

class ConfigWalleListView extends GetView<ConfigWalletListController> {
  const ConfigWalleListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Account"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
      ),
      body:ConfigWalletListInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class ConfigWalletListInfo extends StatefulWidget {
  ConfigWalletListInfo ({Key? key}) : super(key: key);

  @override

  ConfigWalletListInfoView  createState() => ConfigWalletListInfoView();

}

class ConfigWalletListInfoView extends State<ConfigWalletListInfo>{
  final box = GetStorage();
  final configController = Get.put(ConfigController());
  final controller = Get.put(ConfigController());
  final configWalletcontroller = Get.put(ConfigWalletController());
  late  List _list ;
  bool _connecting = false;

  void initState() {
    _list =controller.walletInfo.value;
    super.initState();
  }

  Future<void> CreateAddress() async {
    setState(() {
      _connecting = true;
    });
    final sdk = WalletSDK();
    final Keyring keyring = Keyring();
    await keyring.init([0, 2]);
    final KeyringEVM keyringEVM = KeyringEVM();
    final api = await sdk.init(keyring, keyringEVM: keyringEVM);

    final node = NetworkParams();
    node.name = 'Web3Games';
    node.endpoint = 'wss://devnet.web3games.org/';
    node.ss58 = 42;

    final res = await sdk.api.connectNode(keyring, [node]);
    int ss58 = 42;
    final AddressIconDataWithMnemonic seed = await sdk.api.keyring.generateMnemonic(ss58);
    final data = await sdk.api.keyring.importAccount;
    // print(".................${data}");
    configController.createAddress({
      "name":"Wallet${box.read('address')==null?"1":"${box.read('address').length+1}"}",
      "address":"${seed.address}",
      "mnemonic":"${seed.mnemonic}",
      "nft":"https://img.seadn.io/files/22e01765d5c0f9b082200af01ec55c14.png?fit=max&w=1000",
    "tokenList":[{"tokenID":"0","name":"Web3Games","title":"W3G","showState":true,"amount":"0","decimals":"18"}]
    });
    configController.addressIndex(box.read("addressIndex")+1);
    Get.back();
  }

  List<Widget> _WalletList(){
    return _list.asMap().keys.map((f) =>
    Container(
      child:
      box.read('addressIndex') == f ?
          TextButton(onPressed: ()=>{configController.addressIndex(f),Get.back()}, child:  Container(
            padding: EdgeInsets.only(left: 10.0,right: 0.0,top: 10.0,bottom: 10.0),
            decoration:BoxDecoration(
              color:  Color.fromRGBO(56, 56, 56, 1),
              // Color.fromRGBO(59, 99, 237, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [

                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          "${controller.walletInfo.value[f]["nft"]}",
                          width: 50,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      child:   Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetX<ConfigController>(
                              builder: (ConfigController) {
                                return
                                  Text("${controller.walletInfo.value[f]["name"]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    ),);
                              }),
                          Text("${controller.interceptAddress(controller.walletInfo.value[f]["address"])}",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16
                            ),)

                        ],
                      ),
                    )

                  ],
                ),
                TextButton(
                  onPressed:()=>{
                    Get.toNamed("/configWallet",arguments: {"addressIndex":"${f}"})
                    // Get.off(ConfigWalletView())
                  },
                  style: ButtonStyle(
                    //去除阴影
                    elevation: MaterialStateProperty.all(0),
                    //将按钮背景设置为透明
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),

                  ),
                  child:  Icon(Icons.more_horiz,size: 30,color: Colors.white,),
                )
              ],
            ),
          ), style: ButtonStyle(
            //去除阴影
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.all(Colors.transparent,
            ),
            //去掉inkwell的点击效果
          ))
     :

      TextButton(onPressed: ()=>{configController.addressIndex(f),Get.back()},
          child:  Container(
        padding: EdgeInsets.only(left: 10.0,right: 0.0,top: 10.0,bottom: 10.0),
        decoration:BoxDecoration(
          color:  Color.fromRGBO(29, 29, 29, 1),
          // Color.fromRGBO(59, 99, 237, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      "${controller.walletInfo.value[f]["nft"]}",
                      width: 50,
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  child:   Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetX<ConfigController>(
                          builder: (ConfigController) {
                            return
                              Text("${controller.walletInfo.value[f]["name"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),);
                          }),
                      Text("${controller.interceptAddress(controller.walletInfo.value[f]["address"])}",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16
                        ),)

                    ],
                  ),
                )

              ],
            ),
            TextButton(
              onPressed:()=>{
                Get.toNamed("/configWallet",arguments: {"addressIndex":"${f}"})
                // Get.off(ConfigWalletView())
              },
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),

              ),
              child:  Icon(Icons.more_horiz,size: 30,color: Colors.white,),
            )
          ],
        ),
      ), style: ButtonStyle(
        //去除阴影
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        overlayColor: MaterialStateProperty.all(Colors.transparent,
        ),
        //去掉inkwell的点击效果
      ))

    )

    ).toList();
  }

  @override
  Widget build(BuildContext context) {
  return
    Container(
      padding: const EdgeInsets.only(right: 10.0,top: 20.0,bottom: 40.0,left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.68,
          child:SingleChildScrollView(
           scrollDirection: Axis.vertical,
            child:  Wrap(
                runSpacing: 10.0,
                children: _WalletList()
            ),
           )
          ),

          Container(
            width: double.infinity,
            //在此设置
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:  Color.fromRGBO(59, 99, 237, 1),
            ),
            child: ElevatedButton(
              onPressed:CreateAddress,
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),

              ),

              child:  _connecting?
              CupertinoActivityIndicator(color: Colors.white,):
              Text(
                'Add/Link Wallet',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800
                  //    字体加粗
                ),
              ),
            ),
          )
        ],
      )

    );
  }
}


