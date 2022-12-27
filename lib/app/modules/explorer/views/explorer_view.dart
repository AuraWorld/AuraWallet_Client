import 'dart:ui';
import 'package:bruno/bruno.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  final configController = Get.put(ConfigController());
  final configWalletcontroller = Get.put(ConfigWalletController());
  @override
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
                Icons.more_horiz,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Get.toNamed("/explorerMore");
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

  @override

  Widget build(BuildContext context){
    return
    SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child:    GestureDetector(
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child:  Container(
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
                    margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: Color.fromRGBO(49, 49, 49,1),
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
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white54,
                                    size: 30.0,
                                  ),
                                ),
                              ))
                          ,),

                      ],
                    ) ,
                  ),
                  PopularList(),
                  GamingList(),

                ],
              ),
            )
        ),

      )
    );

  }
}

class PopularList extends StatelessWidget {
  final List<Map<String, dynamic>> _list = [
    {
      "id":"1",
      "list":[
        {
          "url":"https://portal.web3games.com",
          "img":"icon-1024x1024",
          "title":"Portal",
          "h1":"Web3Games Portal is the one-stop curator for blockchain gaming, aiming to be the Steam for blockchain gaming. We provide a comprehensive listing for blockchain games. More than that......",
        },
        {
          "url":"https://web3games-onchain-dapp.vercel.app/faucet",
          "img":"icon-1024x1024",
          "title":"Faucet",
          "h1":"This faucet transfers TestToken on Matic testnets and parent chain. Confirm details before submitting.This faucet transfers TestToken on Matic testnets and parent chain......",
        },
        {
          "url":"https://web3games-onchain-dapp.vercel.app/launchpad",
          "img":"icon-1024x1024",
          "title":"Launchpad",
          "h1":"Create a token, create a project and set project information, exchange unlocked tokens, and get unlocked tokens......",
        },
      ]
    },
    {
      "id":"2",
      "list":[
        {
          "url":"https://explorer-devnet.web3games.org/",
          "img":"icon-1024x1024",
          "title":"Explorer",
          "h1":"The Web3Games Chain Explorer is a powerful, multi execution environment and a visual product for viewing Web3Games Chain in the full history state......",
        },
        {
          "url":"https://web3games-onchain-dapp.vercel.app/home",
          "img":"icon-1024x1024",
          "title":"DEX",
          "h1":"View token balance, Add custom token, Create a custom transaction pair, Add/Remove Liquidity, Token exchange......",
        },
        {
          "url":"https://web3games-onchain-dapp.vercel.app/multipay",
          "img":"icon-1024x1024",
          "title":"Multipay",
          "h1":"Create NFT, Create Order, Cancel Order, Execute Order, Set Bid, Cancel Bid, Accept Bid, Set Royalty.",
        },
      ]
    },
    {
      "id":"3",
      "list":[
        {
          "url":"https://web3games-onchain-dapp.vercel.app/marketplaces",
          "img":"icon-1024x1024",
          "title":"Marketplaces",
          "h1":"The Web3Games Chain Explorer is a powerful, multi execution environment and a visual product for viewing Web3Games Chain in the full history state......",
        },

      ]
    },

  ];

  @override

  Widget build(BuildContext context){

    return
      Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Poplar Items",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(top: 3,bottom: 3,right: 10,left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:  Color.fromRGBO(59, 99, 237, 1),
                    ),
                    child: ElevatedButton(
                      onPressed: ()=>{
                        Get.toNamed("/explorer_Info",arguments: {"title":"Poplar Items"})
                      },
                      style: ButtonStyle(
                        //去除阴影
                        minimumSize: MaterialStateProperty.all(Size(1, 1)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child:  Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w800 //    字体加粗
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.279,
              child:Swiper(
                outer:false,
                scrollDirection:Axis.horizontal,
                // pagination: SwiperPagination(
                //     builder: DotSwiperPaginationBuilder(
                //
                //         size: 8,// 设置未选中的小点大小
                //         activeSize: 8,// 设置选中的小点大小
                //         color: Colors.white, // 设置为选中的小点颜色
                //         activeColor: Colors.black, // 设置选中的小点颜色
                //
                //     )
                // ),
                itemBuilder: (BuildContext context,int index){
                  return
                  Container(
                      transform: Matrix4.translationValues(-MediaQuery.of(context).size.height * 0.02, 0.0, 0.0),
                    child:
                             Column(
                                children: [
                                  Wrap(
                                    children:_list[index]["list"].map<Widget>((lists)=>
                                        TextButton(
                                            onPressed: (){
                                              Get.toNamed("/webExplorer",arguments: {"title":"${lists["title"]}","url":"${lists["url"]}"});
                                            },
                                            child: Container(
                                              padding:  EdgeInsets.all(5.0),
                                              decoration:  BoxDecoration(
                                                // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  color: Color.fromRGBO(49, 49, 49, 1)
                                              ),
                                              child:  Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10),
                                                    decoration:  BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        border: Border.all(color: Color.fromRGBO(109, 109, 109, 1),width: 0.5)
                                                    ),
                                                    child:  ClipRRect(
                                                        borderRadius:BorderRadius.circular(10),
                                                        child: Image.asset('assets/images/${lists["img"]}.png',height: MediaQuery.of(context).size.height * 0.064,)
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.62,
                                                          child:  Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                child:  Text(
                                                                  "${lists["title"]}",
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight: FontWeight.w800,
                                                                      color: Colors.white
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 6.0,right: 6.0,bottom: 3.0,top: 3.0),
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                    color: Colors.white
                                                                ),
                                                                child:  Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Container(
                                                                      child:  Text(
                                                                        'W3b3Games Chain',
                                                                        style: TextStyle(
                                                                            fontSize: 10,
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
                                                                    ), // token name
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 5.0),
                                                          width: MediaQuery.of(context).size.width * 0.64,
                                                          child:  Text(
                                                            '${lists["h1"]}',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.white38,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                                              //去掉inkwell的点击效果
                                            )
                                        )
                                    ).toList(),
                                  ),
                                ],
                              )
                  );
                },
                itemCount: _list.length,
                loop:false,
                viewportFraction: 0.93,

              ),

            )



          ],
        ),
      );
  }
}

class GamingList extends StatelessWidget {
  final List<Map<String, dynamic>> _list = [
    {
      "id":"1",
      "list":[
        {
          "url":"https://w3poker.com",
          "img":"w3poker",
          "title":"W3poker",
          "h1":"Web3Games Portal is the one-stop curator for blockchain gaming, aiming to be the Steam for blockchain gaming. We provide a comprehensive listing for blockchain games. More than that......",
        },
        {
          "url":"https://debeats.com/",
          "img":"debeats",
          "title":"Debeats",
          "h1":"This faucet transfers TestToken on Matic testnets and parent chain. Confirm details before submitting.This faucet transfers TestToken on Matic testnets and parent chain......",
        },
        {
          "url":"https://cryptoempire.games/",
          "img":"cryptoempire",
          "title":"Cryptoempire",
          "h1":"Create a token, create a project and set project information, exchange unlocked tokens, and get unlocked tokens......",
        },
      ]
    },
  ];
  @override

  Widget build(BuildContext context){
    return
      Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gaming",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                  Container(
                    height: 30,
                    padding: EdgeInsets.only(top: 3,bottom: 3,right: 10,left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:  Color.fromRGBO(59, 99, 237, 1),
                    ),
                    child: ElevatedButton(
                      onPressed: ()=>{
                        Get.toNamed("/explorer_Info",arguments: {"title":"Gaming"})
                      },
                      style: ButtonStyle(
                        //去除阴影
                        minimumSize: MaterialStateProperty.all(Size(1, 1)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child:  Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w800 //    字体加粗
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.279,
              child:Swiper(
                outer:false,
                scrollDirection:Axis.horizontal,
                // pagination: SwiperPagination(
                //     builder: DotSwiperPaginationBuilder(
                //
                //         size: 8,// 设置未选中的小点大小
                //         activeSize: 8,// 设置选中的小点大小
                //         color: Colors.white, // 设置为选中的小点颜色
                //         activeColor: Colors.black, // 设置选中的小点颜色
                //
                //     )
                // ),
                itemBuilder: (BuildContext context,int index){
                  return
                    Container(
                        transform: Matrix4.translationValues(-MediaQuery.of(context).size.height * 0.02, 0.0, 0.0),
                        child:
                        Column(
                          children: [
                            Wrap(
                              children:_list[index]["list"].map<Widget>((lists)=>
                                  TextButton(
                                      onPressed: (){
                                        Get.toNamed("/webExplorer",arguments: {"title":"${lists["title"]}","url":"${lists["url"]}"});
                                      },
                                      child: Container(
                                        padding:  EdgeInsets.all(5.0),
                                        decoration:  BoxDecoration(
                                          // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            color: Color.fromRGBO(49, 49, 49, 1)
                                        ),
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 10),
                                              decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  border: Border.all(color: Color.fromRGBO(109, 109, 109, 1),width: 0.5)
                                              ),
                                              child:  ClipRRect(
                                                  borderRadius:BorderRadius.circular(10),
                                                  child: Image.asset('assets/images/${lists["img"]}.png',height: MediaQuery.of(context).size.height * 0.064,)
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.62,
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          child:  Text(
                                                            "${lists["title"]}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w800,
                                                                color: Colors.white
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(left: 6.0,right: 6.0,bottom: 3.0,top: 3.0),
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              color: Colors.white
                                                          ),
                                                          child:  Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                child:  Text(
                                                                  'W3b3Games Chain',
                                                                  style: TextStyle(
                                                                      fontSize: 10,
                                                                      color: Colors.black
                                                                  ),
                                                                ),
                                                              ), // token name
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.0),
                                                    width: MediaQuery.of(context).size.width * 0.64,
                                                    child:  Text(
                                                      '${lists["h1"]}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white38,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                                        //去掉inkwell的点击效果
                                      )
                                  )
                              ).toList(),
                            ),
                          ],
                        )
                    );
                },
                itemCount: _list.length,
                loop:false,
                viewportFraction: 0.93,

              ),

            )



          ],
        ),
      );
  }
}


