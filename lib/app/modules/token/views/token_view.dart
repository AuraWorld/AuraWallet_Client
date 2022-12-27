import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_sdk/api/apiKeyring.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';
import '../../avatar/controllers/avatar_controller.dart';
import '../../collection/controllers/collection_controller.dart';
import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../../manageTokenList/controllers/manageTokenList_controller.dart';
import '../../tokenInfo/controllers/tokenInfo_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/token_controller.dart';


class TokenViewState extends StatefulWidget {
  TokenViewState({Key? key}) : super(key: key);

  @override

  TokenView createState() => TokenView();

}

class TokenView extends State<TokenViewState>  {

  @override
  final configController = Get.put(ConfigController());
  final configWalletcontroller = Get.put(ConfigWalletController());
  final manageTokenListController = Get.put(ManageTokenListController());
  final collectionController = Get.put(CollectionController());
  void initState() {

    configController.setWalletsInfo();
    configController.setNetWorkInfo();
    configController.setExplorerInfo();
    manageTokenListController.setW3GToken(configController.walletInfo.value[configController.walletIndex.value]["address"]);
    manageTokenListController.setTokenList();
    collectionController.GetUserNftList(configController.walletInfo.value[configController.walletIndex.value]["address"]);
    super.initState();
  }




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: ()=>{
                Get.toNamed("/avatar",arguments: {"title":"${configController.walletInfo.value[configController.walletIndex.value]["name"]}"})
              },
              style: ButtonStyle(
                //去除阴影
                minimumSize: MaterialStateProperty.all(Size(1, 1)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                //去掉inkwell的点击效果
              ),
              child:
              GetX<ConfigController>(
                  builder: (ConfigController) {
                    return
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          "${configController.walletInfo.value[configController.walletIndex.value]["nft"]}",
                          width: 40,
                        ),
                      );
                  }
              ),
            ),
            TextButton(
                onPressed: ()=>{
                  Clipboard.setData(ClipboardData(text: '${configController.walletInfo.value[configController.walletIndex.value]["address"]}')),
                  configWalletcontroller.setCopyState(),
                  HapticFeedback.heavyImpact(),
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1, 1)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  //去除阴影
                  elevation: MaterialStateProperty.all(0),
                  //将按钮背景设置为透明
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //去掉inkwell的点击效果
                ),
                child:  Stack(
                  children: [
                    Positioned(child:
                    Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: 140
                              ),
                              child: Text("${configController.walletInfo.value[configController.walletIndex.value]["name"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.only(right: 10.0,left: 10.0,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Color.fromRGBO(51, 51, 51, 1),
                              ),
                              child:  Text("${configController.interceptAddress(configController.walletInfo.value[configController.walletIndex.value]["address"])}",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12
                                ),),
                            )

                          ],
                        )
                    ),
                    ),
                    GetX<ConfigWalletController>(
                        builder: (ConfigWalletController){
                          return
                            Positioned(
                              child: AnimatedOpacity(
                                  opacity: configWalletcontroller.copyState.value? 1.0: 0.0,
                                  duration: Duration(milliseconds: 400),
                                  child:  Container(
                                      margin: EdgeInsets.only(top: 1),
                                      padding: EdgeInsets.only(left: 18,right: 18,top: 10.0,bottom: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color:  Color.fromRGBO(59, 99, 237, 1),
                                      ),
                                      child:
                                      Text(
                                        'Copied!',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800, //    字体加粗
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  )
                              ),

                            );
                        })

                  ],
                )
            ),

          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  color: Colors.white54,
                  size: 30.0,
                ),
                tooltip: '',
                onPressed: () {
                  // _importFromMnemonic();
                  GetStorage().erase();
                  BrnToast.show("coming soon", context);
                }
            ),
          ],
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: TokenViewInfo(),
    );
  }
}

class TokenViewInfo extends StatelessWidget {
  final controller = Get.put(TokenController());
  final manageTokenListController = Get.put(ManageTokenListController());

  List<Widget> _Token(){
    return manageTokenListController.tokenList.asMap().keys.map((f) =>
        GetX<ManageTokenListController>(
            builder: (ManageTokenListController) {
              return
              Visibility(
                visible: manageTokenListController.tokenList.value[f]["showState"] as bool,
                child:  TextButton(onPressed: () =>
                {
                  controller.tokenName(manageTokenListController.tokenList.value[f]["title"] as String),
                  Get.toNamed("/tokenInfo", arguments: {
                    "title": manageTokenListController.tokenList.value[f]["title"],
                    "img": manageTokenListController.tokenList.value[f]["title"],
                    "name":manageTokenListController.tokenList.value[f]["name"],
                    "amount":manageTokenListController.tokenList.value[f]["amount"],
                    "decimals":manageTokenListController.tokenList.value[f]["decimals"],
                    "tokenID":manageTokenListController.tokenList.value[f]["tokenID"],
                  })
                },
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 60,
                        decoration: const BoxDecoration(
                          // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white12
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // token logo + token name + token number
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.only(right: 10),

                                  decoration: const BoxDecoration(
                                    // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50)),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                          'assets/images/${manageTokenListController.tokenList.value[f]["title"]}.png')
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        '${manageTokenListController.tokenList.value[f]["name"]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white

                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        '${manageTokenListController.tokenList.value[f]["amount"]} ${manageTokenListController.tokenList.value[f]["title"]}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white38,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                            Flex(
                              direction: Axis.vertical,
                              children: [
                                Container(
                                  height: 40,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          '\$ --',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white
                                          ),
                                        ),
                                      ), // token name
                                      Container(
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white54
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.transparent),
                      //去掉inkwell的点击效果
                    )),
              );

            }
        )

    ).toList();
  }
  @override

  Widget build(BuildContext context){
    return
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:  Column(
          children:<Widget>[
            // top content
            Container(
              padding: const EdgeInsets.all(10.0),
              // decoration:BoxDecoration(
              //   border: Border.all(
              //     color: Colors.red,
              //   ),
              // ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '\$0',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white
                      ),
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20.0,5.0,0.0,20.0), //容器外补白
                        child: const Text(
                          '',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white54

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5.0,5.0,20.0,20.0), //容器外补白
                        // decoration: BoxDecoration(
                        //   border: Border.all(1.0)
                        // ),
                        child: const Text(
                          '0.00%',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white38
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DepositButton(),

                      SendButton()
                    ],
                  )
                ],
              ),

            ),
            // content
            GetX<ManageTokenListController>(
                builder: (ManageTokenListController) {
                  return
                    Container(
                      padding: const EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0),
                      child:
                      Wrap(
                          children: _Token()
                      ),

                    );
                }
            ),
            
            Container(

              child: TextButton(
                onPressed: ()=>{
                  Get.toNamed("/manageTokenList")
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      child:
                      Icon(Icons.list,size: 26,color: Color.fromRGBO(74, 74, 74, 1)),
                    ),

                    Text("Manage token list",style: TextStyle(color: Color.fromRGBO(74, 74, 74, 1),fontSize: 16),)
                  ],
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(1, 1)),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  //去除阴影
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //去掉inkwell的点击效果
                ),
              ),
            )

          ],
        ),
      );
  }
}

class DepositButton extends StatelessWidget {


  final controller = Get.put(TokenController());
  final List<Map<String, dynamic>> _list = [

    {
      "title":"Web3Games",
      "name":"W3G",
      "img":"web3games",
    },
    {
      "title":"Aptos",
      "name":"APT",
      "img":"APT",
    },
    {
      "title":"AAVE",
      "name":"AAVE",
      "img":"aave",
    },
    {
      "title":"Bitcoin",
      "name":"BTC",
      "img":"bitcoin",
    },
    {
      "title":"Binance",
      "name":"BNB",
      "img":"bnb",
    },
    {
      "title":"Ethereum",
      "name":"ETH",
      "img":"ETH",
    },
    {
      "title":"USDT",
      "name":"USDT",
      "img":"USDT",
    },
    {
      "title":"Green Satoshi Token",
      "name":"GST",
      "img":"GST",
    },
    {
      "title":"Web3Games",
      "name":"W3G",
      "img":"web3games",
    },
    {
      "title":"Web3Games",
      "name":"W3G",
      "img":"web3games",
    },

  ];

  List<Widget> _Token(){
    return _list.map((item) =>
        TextButton(
          onPressed: () =>{
            controller.tokenName(item["name"]),
            Get.bottomSheet(
              DepositToken(),
              isScrollControlled: true,
            )
          },
          child:  Container(
              padding: const EdgeInsets.all(10.0),
              height: 60,
              decoration: const BoxDecoration(
                // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color.fromRGBO(34, 34, 34, 1)
              ),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // token logo + token name + token number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 40,
                          margin: EdgeInsets.only(right: 10),

                          decoration:  BoxDecoration(
                            // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Image.asset('assets/images/${item["img"]}.png')
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom:5),
                            child:  Text(
                              item['title'],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white

                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child:  Text(
                              "${item["name"]}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ],
              )
          ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            ))
    ).toList();
  }

  @override

  Widget build(BuildContext context){

    return
      Container(
        width: 140,
        //在此设置
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
         color:  Color.fromRGBO(59, 99, 237, 1),
        ),
        child: ElevatedButton(
          onPressed: ()=>{
            Get.bottomSheet(
          isScrollControlled: true,
          GestureDetector(
          onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
          },
              child: Container(
                  margin: EdgeInsets.only(top: 60.0),
                  height:  MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(21, 21, 21, 1),
                    ),
                    //毛玻璃效果
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 10.0),

                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide( // 设置单侧边框的样式
                                        color: Colors.white24,
                                        width: 0.5,
                                        style: BorderStyle.solid
                                    )
                                )
                            ),
                            child:
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CloseButton(
                                  color: Colors.white,
                                  onPressed: () => Navigator.pop(context),

                                ),
                                Text(
                                  "Deposit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                                Text(
                                  "      ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                          child: Column(
                            children: [
                              Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.white54,
                                      width: 1

                                  ),
                                ),
                                child: (
                                    TextField(
                                      autocorrect: true,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.white54,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        hintText: "Search...",
                                        hintStyle: TextStyle(
                                            color: Colors.white70
                                        ),
                                        prefixIcon: Icon(Icons.search,
                                          color: Colors.white54,
                                          size: 32,),
                                      ),

                                    ))
                                ,),
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                height: MediaQuery.of(context).size.height * 0.64,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Wrap(
                                      runAlignment:WrapAlignment.start,
                                      children: _Token()
                                  ),
                                ),

                              )

                            ],
                          ) ,
                        )

                      ],
                    ),
                  )
              ),
          ),
            )
          },
          style: ButtonStyle(
            //去除阴影
              elevation: MaterialStateProperty.all(0),
              //将按钮背景设置为透明
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                //去掉inkwell的点击效果

          ),
          child: const Text(
            'Deposit',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      );
  }

}

class DepositToken extends StatelessWidget{
  final controller = Get.put(TokenController());
  final DepositButtonFu = Get.put(TokenInfoController());
  final configController = Get.put(ConfigController());
  @override
  Widget build(BuildContext context){
    return
      Container(
          height: MediaQuery.of(context).size.height * 0.93,
          width: double.infinity,
          child:
          Container(
              height: MediaQuery.of(context).size.height * 0.93,
              width: double.infinity,
              child:
              ClipRect(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color.fromRGBO(21, 21, 21, 1)
                      ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide( // 设置单侧边框的样式
                                            color: Colors.white24,
                                            width: 0.5,
                                            style: BorderStyle.solid
                                        )
                                    )
                                ),
                                child:
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CloseButton(
                                      color: Colors.white,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    Text(
                                      "Deposit ${controller.tokenName.value}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:20,
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                    Text(
                                      "      ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:20,
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                              height: MediaQuery.of(context).size.height * 0.73,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    //占位
                                    children: [],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          //圆角
                                          child: Image.network(
                                            "https://cdn.discordapp.com/attachments/876498266550853642/1032931559076012152/unknown.png",
                                            width: 240,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15.0),
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: Colors.white30,
                                              width: 1

                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GetX<ConfigController>(
                                                    builder: (ConfigController) {
                                                      return
                                                        Text("${configController.walletInfo.value[configController.walletIndex.value]["name"]}",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16
                                                          ),);
                                                    }),
                                                GetX<ConfigController>(
                                                    builder: (ConfigController) {
                                                      return
                                                        Text("(${configController.interceptAddress(configController.walletInfo.value[configController.walletIndex.value]["address"])})",
                                                          style: TextStyle(
                                                              color: Colors.white54,
                                                              fontSize: 16
                                                          ),);
                                                    })
                                              ],
                                            ),
                                            Container(
                                              height: 30.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color:  Color.fromRGBO(59, 99, 237, 1),
                                              ),
                                              child: ElevatedButton(
                                                  onPressed: ()=>{
                                                    controller.setCopyState(),
                                                    Clipboard.setData(ClipboardData(text: '${configController.walletInfo.value[configController.walletIndex.value]["address"]}')),
                                                    HapticFeedback.heavyImpact(),
                                                    print(controller.copyState)
                                                  },
                                                  style: ButtonStyle(
                                                    //去除阴影
                                                      elevation: MaterialStateProperty.all(0),
                                                      //将按钮背景设置为透明
                                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                      splashFactory: NoSplash.splashFactory,
                                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                                        //去掉inkwell的点击效果
                                                  ),
                                                  child:
                                                  GetX<TokenController>(
                                                    builder: (controller){
                                                      return
                                                        Text(
                                                          '${controller.copyState}',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w800
                                                            //    字体加粗
                                                          ),
                                                        );
                                                    },
                                                  )
                                              ),
                                            )

                                          ],
                                        ),

                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 15.0,right: 20.0,left: 20.0),
                                        child:  Center(
                                          child: Text(
                                            "This address can only receive W3G and W3G tokens of Web3Games blockchain.",
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(right: 10.0,left: 10.0),
                                    //在此设置
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:  Color.fromRGBO(59, 99, 237, 1),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: ()=>{
                                        BrnToast.show("coming soon", context)
                                      },
                                      style: ButtonStyle(
                                        //去除阴影
                                          elevation: MaterialStateProperty.all(0),
                                          //将按钮背景设置为透明
                                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                          splashFactory: NoSplash.splashFactory,
                                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                                      ),
                                      child:
                                      Text(
                                        'Sharing Address',
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
                              ) ,
                            ),


                          ],
                        ),

                ),
              )
          ),



      );
  }
}

class SendButton extends StatelessWidget {
  final controller = Get.put(TokenController());
  final manageTokenListController = Get.put(ManageTokenListController());


  List<Widget> _Token(){
    return manageTokenListController.tokenList.asMap().keys.map((f) =>
        GetX<ManageTokenListController>(
            builder: (ManageTokenListController) {
              return
                Visibility(
                    visible: manageTokenListController.tokenList.value[f]["showState"] as bool,
                    child: TextButton(
                    onPressed: () =>
                    {
                    controller.setAddressBalance(manageTokenListController.tokenList.value[f]["amount"]),
                    controller.setTokenDecimals(manageTokenListController.tokenList.value[f]["decimals"]),
                    controller.setTokenID(manageTokenListController.tokenList.value[f]["tokenID"]),
                    controller.tokenName(manageTokenListController.tokenList.value[f]["title"] as String),
                      Get.bottomSheet(
                        SendButtonState(),
                        isScrollControlled: true,
                      )
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Color.fromRGBO(34, 34, 34, 1)
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // token logo + token name + token number
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 40,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)),
                                    ),
                                    child: Image.asset(
                                        'assets/images/${manageTokenListController.tokenList.value[f]["title"]}.png')
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "${manageTokenListController.tokenList.value[f]["name"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white

                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${manageTokenListController.tokenList.value[f]["amount"]} ${manageTokenListController.tokenList.value[f]["title"]}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ],
                        )
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.transparent),
                      //去掉inkwell的点击效果
                    )),
              );
            }
        )
    ).toList();
  }

  @override

  Widget build(BuildContext context){
    return
      Container(
        width: 140,
        //在此设置
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:  Color.fromRGBO(59, 99, 237, 1),
        ),
        child: ElevatedButton(
          onPressed: ()=>{
            Get.bottomSheet(
          isScrollControlled: true,
                GestureDetector(
                  onTap: () {
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                    child: Container(
                      margin: EdgeInsets.only(top: 60.0),
                      height:  MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child:
                      ClipRect(
                        child:  BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  color: Color.fromRGBO(21, 21, 21, 1)
                              ),
                              //毛玻璃效果
                              child:
                              Opacity(
                                opacity: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide( // 设置单侧边框的样式
                                                    color: Colors.white24,
                                                    width: 0.5,
                                                    style: BorderStyle.solid
                                                )
                                            )
                                        ),
                                        child:
                                        Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CloseButton(
                                              color: Colors.white,
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                            Text(
                                              "Select Token",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:20,
                                                  fontStyle: FontStyle.normal
                                              ),
                                            ),
                                            Text(
                                              "      ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:20,
                                                  fontStyle: FontStyle.normal
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  color: Colors.white54,
                                                  width: 1

                                              ),
                                            ),
                                            child: (
                                                TextField(
                                                  autocorrect: true,
                                                  keyboardType: TextInputType.text,
                                                  cursorColor: Colors.white54,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none
                                                    ),
                                                    hintText: "Search...",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white70
                                                    ),
                                                    prefixIcon: Icon(Icons.search,
                                                      color: Colors.white54,
                                                      size: 32,),
                                                  ),

                                                ))
                                            ,),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            height: MediaQuery.of(context).size.height * 0.64,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Wrap(
                                                  runAlignment:WrapAlignment.start,
                                                  children: _Token()
                                              ),
                                            ),

                                          )

                                        ],
                                      ) ,
                                    )

                                  ],
                                ),
                              ),
                            )
                        ),
                      )
                  ),

                )
            )
          },
          style: ButtonStyle(
            //去除阴影
              elevation: MaterialStateProperty.all(0),
              //将按钮背景设置为透明
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                //去掉inkwell的点击效
          ),
          child: const Text(
            'Send',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      );
  }

}

class SendButtonState extends StatefulWidget {
  const SendButtonState({super.key});

  @override
  State<SendButtonState> createState() => SendToken();
}

class SendToken extends State<SendButtonState>{
  final controller = Get.put(TokenController());
  final myController = TextEditingController();
  @override

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
  return
    GestureDetector(
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:  Container(
          margin: EdgeInsets.only(top: 60.0),
          height:  MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
            decoration:BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color.fromRGBO(21, 21, 21, 1)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide( // 设置单侧边框的样式
                                color: Colors.white24,
                                width: 0.5,
                                style: BorderStyle.solid
                            )
                        )
                    ),
                    child:
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:Icon(Icons.chevron_left,
                            size: 30,),
                          color: Colors.white,

                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child:  Text(
                            "Send ${controller.tokenName.value}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                              controller.setSendAddress(myController.text),
                              controller.sendAddressToken("0.00"),
                              Get.bottomSheet(
                                SendTokenAmountState(),
                                isScrollControlled: true,
                              )
                            },
                            child:Text(
                              'Next Step',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800
                              ),)
                        ),

                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.white54,
                              width: 1

                          ),
                        ),
                        child: (
                            TextField(
                              controller: myController,
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white54,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: "To:Name or address",
                                hintStyle: TextStyle(
                                    color: Colors.white70
                                ),
                                suffixIcon: Icon(
                                  CupertinoIcons.qrcode_viewfinder,
                                  color: Colors.white54,
                                  size: 30.0,
                                ),
                              ),

                            ))
                        ,),
                      Container(
                        width: 200,
                        //在此设置
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:  Color.fromRGBO(59, 99, 237, 1),
                        ),
                        child: ElevatedButton(
                            onPressed: ()=>{
                              controller.setSendAddress(myController.text),
                              controller.sendAddressToken("0.00"),
                              Get.bottomSheet(
                                SendTokenAmountState(),
                                isScrollControlled: true,
                              )
                            },
                            style: ButtonStyle(
                              //去除阴影
                              elevation: MaterialStateProperty.all(0),
                              //将按钮背景设置为透明
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              'Next Step',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800
                                //    字体加粗
                              ),)
                        ),
                      ),
                    ],
                  ) ,
                )

              ],
            ),
          )
      ),

    );
  }
}

class SendTokenAmountState extends StatefulWidget {
  const SendTokenAmountState({super.key});

  @override
  State<SendTokenAmountState> createState() => SendTokenAmount();
}

class CustomTextFieldFormatter extends TextInputFormatter {

  static const defaultDouble = 0.001;

  ///允许的小数位数，-1代表不限制位数，默认为-1
  int digit;
  //重写构造方法，可以对位数进行直接限制
  CustomTextFieldFormatter({this.digit = -1});


  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    // 如果输入框内容为.直接将输入框赋值为0.
    if (value == ".") {
      value = "0.";
      selectionIndex++;
      // 如果输入框内容为-号，也是被允许的，但是需要正则表达式的时候进行处理一下，允许-号被使用
    } else if (value == "-") {
      value = "-";
      selectionIndex++;
      // 输入内容不能为空，并且输入内容不能为0.001等条件的判断
    } else if (value != "" && value != defaultDouble.toString() && strToFloat(value, defaultDouble) == defaultDouble || getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    // 通过最上面的判断，这里返回的都是有限金额形式
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class SendTokenAmount extends State<SendTokenAmountState>{
  final controller = Get.put(TokenController());
  final myController = TextEditingController();
  final configController = Get.put(ConfigController());
  @override

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context){
    return
      GestureDetector(
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:
        Container(
            margin: EdgeInsets.only(top: 60.0),
            height:  MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromRGBO(21, 21, 21, 1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide( // 设置单侧边框的样式
                                  color: Colors.white24,
                                  width: 0.5,
                                  style: BorderStyle.solid
                              )
                          )
                      ),
                      child:
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon:Icon(Icons.chevron_left,
                              size: 30,),
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child:  Text(
                              "Send ${controller.tokenName.value}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:20,
                                  fontStyle: FontStyle.normal
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: ()=>{
                                Get.bottomSheet(
                                  SendTokenButton(),
                                  isScrollControlled: true,
                                )
                              },
                              child:Text(
                                'Next Step',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:12,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800
                                ),)
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Colors.white24,
                                    width: 1

                                ),
                              ),
                              child: (
                                  TextField(
                                    enabled: false,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.white54,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      ),
                                      hintText: "To: ${configController.interceptAddress(controller.sendAddress.value)}",
                                      hintStyle: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),

                                  ))
                              ,),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 30.0),
                                    decoration:BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        border:Border.all(color:Color.fromRGBO(81, 81, 81, 1),width: 1.5),
                                        color: Color.fromRGBO(49, 49, 49, 1)
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20.0),
                                          child:   Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children:[
                                                GetX<TokenController>(
                                                    builder: (TokenController) {
                                                      return
                                                        AutoSizeText(
                                                          '${controller.sendAddressToken.value} ',
                                                          maxLines: 1,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 30,color: Colors.white),
                                                        );
                                                    }),
                                                Container(
                                                  padding: EdgeInsets.only(left: 20.0,top: 10.0,right: 20.0,bottom: 10.0),
                                                  decoration:BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                      color: Color.fromRGBO(255, 255, 255, 1)
                                                  ),
                                                  child:
                                                  Text("${controller.tokenName.value}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 18
                                                    ),),
                                                )
                                              ]

                                          ),
                                        ),
                                        Opacity(opacity: 0,
                                          child: Container(
                                            child: (
                                                TextField(
                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                  onChanged:(text){ text==""?controller.sendAddressToken("0.00"):controller.sendAddressToken(text);},
                                                  autocorrect: true,
                                                  maxLength: 10,
                                                  cursorColor: Colors.white54,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  ],
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide.none
                                                    ),
                                                    hintText: "0.00",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                  ),

                                                ))
                                            ,) ,)

                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child:
                                  Container(
                                    child:Row(
                                        children:[
                                          Text("Balance: ",style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 18
                                          ),),
                                          Container(
                                            child:
                                            Text("${controller.AddressBalance.value} ${controller.tokenName.value}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 18
                                              ),),
                                          )
                                        ]
                                    ),
                                  ),
                                ),],
                            )

                          ],
                        ),

                        Container(
                          width: 200,
                          //在此设置
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:  Color.fromRGBO(59, 99, 237, 1),
                          ),
                          child: ElevatedButton(
                            onPressed: ()=>{
                              Get.bottomSheet(
                                SendTokenButton(),
                                isScrollControlled: true,
                              )
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
                              'Next Step',
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
                    ) ,
                  )

                ],
              ),
            )
        ),

      );


  }
}

class SendTokenButton extends StatelessWidget {
  final controller = Get.put(TokenController());
  final configController = Get.put(ConfigController());
  final myController = TextEditingController();
  final transactionAnimationController = Get.put(TransactionAnimationController());

  @override

  Widget build(BuildContext context){
    return

      Container(
          margin: EdgeInsets.only(top: 60.0),
          height:  MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
            decoration:BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color.fromRGBO(21, 21, 21, 1)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide( // 设置单侧边框的样式
                                color: Colors.white24,
                                width: 0.5,
                                style: BorderStyle.solid
                            )
                        )
                    ),
                    child:
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:Icon(Icons.chevron_left,
                            size: 30,),
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child:  Text(
                            "Send ${controller.tokenName.value}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                              transactionAnimationController.setH1("Your token has been successfully sent to the "),
                              Get.offAll(TransactionAnimationView())
                            },
                            child:Text(
                              'Send',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800
                              ),)
                        ),
                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child:   Column(
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color:  Color.fromRGBO(67, 52, 126, 1),
                                ),
                                child:  Icon(Icons.arrow_upward_sharp,color: Colors.white,size: 40,),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child:  Text("${controller.sendAddressToken.value} ${controller.tokenName.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child:  Text("\$${controller.sendAddressToken.value}",
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              padding: EdgeInsets.only(left: 14.0,right: 14.0),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(29, 29, 29, 1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color.fromRGBO(53, 53, 53, 1),
                                          ),
                                        )
                                    ),
                                    child:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("From",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("${configController.walletInfo.value[configController.walletIndex.value]["name"]} ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            Text("${configController.interceptAddress(configController.walletInfo.value[configController.walletIndex.value]["address"])}",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color.fromRGBO(53, 53, 53, 1),
                                          ),
                                        )
                                    ),
                                    child:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("To",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("${configController.interceptAddress(controller.sendAddress.value)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                                    child:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("NetWork Cost",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("0.00014 W3G",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
                        //在此设置
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:  Color.fromRGBO(59, 99, 237, 1),
                        ),
                        child: ElevatedButton(
                          onPressed: ()=>{
                            transactionAnimationController.setH1("Your token has been successfully sent to the"),
                            transactionAnimationController.setType("Token"),
                            Navigator.pop(context),
                            Navigator.pop(context),
                            Get.off(TransactionAnimationView(),arguments: {"ToAddress":"${controller.sendAddress.value}","sendToken":"${controller.sendAddressToken.value}",
                              "tokenName":"${controller.tokenName.value}","decimals":"${controller.TokenDecimals.value}","tokenID":"${controller.TokenID.value}"})
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
                            'Send',
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
                  ) ,
                )

              ],
            ),
          )
      );
  }

}










