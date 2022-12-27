import 'dart:async';

import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:polkawallet_sdk/api/apiKeyring.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/api/types/txInfoData.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';

import '../../../../utils/format.dart';
import '../../NFTInfo/controllers/NFTInfo_controller.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../home/views/home_view.dart';
import '../../introduction/views/introduction_view.dart';
import '../controllers/transactionAnimation_controller.dart';

class TransactionAnimationView extends GetView<TransactionAnimationController> {

   TransactionAnimationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: ColorView(),
        elevation: 0,
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor:  Color.fromRGBO(21,21,21,1),
      body: TransactionAnimationInfoView(),
    );
  }
}

class TransactionAnimationInfoView extends StatefulWidget {
  @override
  TransactionAnimationInfoState createState() => TransactionAnimationInfoState();
}

class TransactionAnimationInfoState extends State<TransactionAnimationInfoView> {
  final transactionAnimationController = Get.put(TransactionAnimationController());
  final configController = Get.put(ConfigController());
  final nftInfoController = Get.put(NFTInfoController());
  final ToAddress =Get.arguments["ToAddress"];
  final sendToken =Get.arguments["sendToken"];
  final tokenName =Get.arguments["tokenName"];
  final decimals = Get.arguments["decimals"];
  final tokenID = Get.arguments["tokenID"];

  @override
  void initState() {
    print("xxxxxxx${transactionAnimationController.type.value}");
     if(transactionAnimationController.type.value =="Token"){
       print("${ToAddress},${sendToken},${tokenName},${decimals},${tokenID}");
       print("${Fmt.tokenInt(sendToken,int.parse(decimals))}");
       if(tokenName=="W3G"){
         _sendW3GTx();
       }else{
         _sendTx();
       }
     }
     if(transactionAnimationController.type.value =="PutOnShelves"){
       print("PutOnShelves");
     }
    super.initState();
  }


  Future<void> _sendW3GTx() async {
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
    final key = '${configController.walletInfo.value[configController.walletIndex.value]["mnemonic"]}';
    final name = '${configController.walletInfo.value[configController.walletIndex.value]["name"]}';
    const String testPass = 'a123456';
    final json = await sdk.api.keyring.importAccount(
      keyring,
      keyType: KeyType.mnemonic,
      key:key,
      name: name,
      password: testPass,
    );
    final acc = await sdk.api.keyring.addAccount(
      keyring,
      keyType: KeyType.mnemonic,
      acc: json!,
      password: testPass,
    );

    String testPubKey = '${json["pubKey"]}';
    String Address = "${configController.walletInfo.value[configController.walletIndex.value]["address"]}";

    final sender = TxSenderData(
        Address,
        testPubKey
    );
    final txInfo = TxInfoData('balances', 'transfer', sender);
    try {
      final hash = await sdk.api.tx.signAndSend(
        txInfo,
        [
          '$ToAddress',
          '${Fmt.tokenInt(sendToken,int.parse(decimals))}'
        ],
        testPass,
        onStatusChange: (status) {
          print(status);
        },
      );
      transactionAnimationController.SetState();
    }catch (err) {
      print(err);
    }
  }
  Future<void> _sendTx() async {
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
    final key = '${configController.walletInfo.value[configController.walletIndex.value]["mnemonic"]}';
    final name = '${configController.walletInfo.value[configController.walletIndex.value]["name"]}';
    const String testPass = 'a123456';
    final json = await sdk.api.keyring.importAccount(
      keyring,
      keyType: KeyType.mnemonic,
      key:key,
      name: name,
      password: testPass,
    );
    final acc = await sdk.api.keyring.addAccount(
      keyring,
      keyType: KeyType.mnemonic,
      acc: json!,
      password: testPass,
    );

    String testPubKey = '${json["pubKey"]}';
    String Address = "${configController.walletInfo.value[configController.walletIndex.value]["address"]}";

    final sender = TxSenderData(
        Address,
        testPubKey
    );
    final txInfo = TxInfoData('tokenFungible', 'transfer', sender);
    try {
      final hash = await sdk.api.tx.signAndSend(
        txInfo,
        [
          "$tokenID",
          '$ToAddress',
          '${Fmt.tokenInt(sendToken,int.parse(decimals))}'
        ],
        testPass,
        onStatusChange: (status) {
          print(status);
        },
      );
      transactionAnimationController.SetState();
    }catch (err) {
      print(err);
    }
  }

  Future<void> _importFromMnemonic() async {

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

    final key = '${configController.walletInfo.value[configController.walletIndex.value]["mnemonic"]}';
    final name = '${configController.walletInfo.value[configController.walletIndex.value]["name"]}';
    const String testPass = 'a123456';
    final json = await sdk.api.keyring.importAccount(
      keyring,
      keyType: KeyType.mnemonic,
      key:key,
      name: name,
      password: testPass,
    );
    final acc = await sdk.api.keyring.addAccount(
      keyring,
      keyType: KeyType.mnemonic,
      acc: json!,
      password: testPass,
    );
    // print("xcxzczxczxczxxz${acc['pubKey']}");
    print("xcxzczxczxczxxz${json["pubKey"]}");

  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20.0,bottom: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child:
      GetX<TransactionAnimationController>(
        builder: (transactionAnimationController) {
          return
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(child:transactionAnimationController.state.value?
              Container(
                margin: EdgeInsets.only(top: 150,bottom: 30),
                padding: EdgeInsets.all(30.0),
                decoration:BoxDecoration(
                  color: Color.fromRGBO(58, 99, 237, 1),
                  borderRadius: BorderRadius.circular(100.0),
                ),
          child: Icon(Icons.done_outlined,size: 60,color: Colors.white,),)
                  :
              WorkSpace()),
              // Image.asset("assets/images/logo.png",),
              transactionAnimationController.type.value == "Token"?
                  Column(
                    children: [
                      Container(
                      padding: EdgeInsets.only(top: 5.0,bottom: 2.0),
                      child: Text(transactionAnimationController.state.value?"Has been sent":"Sending",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                      Container(
                        margin: EdgeInsets.only(left:50.0 ,right: 50.0),
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          "${transactionAnimationController.h1.value }",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:50.0 ,right: 50.0),
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${configController.walletInfo.value[configController.walletIndex.value]["name"]} (${configController.walletInfo.value[configController.walletIndex.value]["address"]})",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
            :
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5.0,bottom: 2.0),
                        child: Text("Put On Shelves",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                      ),
                      transactionAnimationController.state.value?
                      Column()
                          :
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:50.0 ,right: 50.0),
                            padding: EdgeInsets.only(top: 2.0),
                            child: Text(
                              "${transactionAnimationController.h1.value}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left:50.0 ,right: 50.0),
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "${nftInfoController.NFTPrice.value} $tokenName",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )

                    ],
                  )
            ],
          ),
          transactionAnimationController.state.value?
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:  Color.fromRGBO(58, 99, 237, 1),
            ),
            child: ElevatedButton(
              onPressed: ()=>{
              // Navigator.of(context).push(_createRoute())
               Get.offAll(HomeView())
              },
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child:  Text(
                'Close',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800
                  //    字体加粗
                ),
              ),
            ),
          )
              :
          Column()

        ],
      );
        })
    );
  }
}


class WorkSpace extends StatelessWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      child: SpinKitWave(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white
            ),
          );
        },
        size: 50.0,
      ),
    );
  }
}