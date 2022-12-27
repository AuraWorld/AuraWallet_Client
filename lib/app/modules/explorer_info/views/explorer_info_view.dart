import 'dart:ui';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../avatar/controllers/avatar_controller.dart';
import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../controllers/explorer_Info_controller.dart';

class Explorer_InfoView extends GetView<Explorer_InfoController> {
 final title = Get.arguments["title"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("${title}"),
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

      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: TokenViewInfo(),
    );
  }
}


class TokenViewInfo extends StatelessWidget {

  @override
  final List<Map<String, dynamic>> _list = [
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
      "title":"Marketplaces",
      "h1":"Create NFT, Create Order, Cancel Order, Execute Order, Set Bid, Cancel Bid, Accept Bid, Set Royalty.",
    },


  ];

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Unable to launch url $url');

    }
  }
  List<Widget> _Tokenlist(context){
    return _list.map((item) =>
        TextButton(
            onPressed: (){
              var url = "${item["url"]}";
              _launchUrl(url);
            },
            child: Container(
                padding: const EdgeInsets.all(5.0),

                decoration: const BoxDecoration(
                  // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color.fromRGBO(49, 49, 49, 1)
                ),
                child: // token logo + token name + token number
                    Row(
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
                              child: Image.asset('assets/images/${item["img"]}.png',height: 60,)
                          ),
                        ),
                        Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.72,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child:  Text(
                                            "${item["title"]}",
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
                                    width: MediaQuery.of(context).size.width * 0.72,
                                    child:  Text(
                                      '${item["h1"]}',
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
            ))

    ).toList();
  }

  Widget build(BuildContext context){
    return
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child:
      Container(
        padding: const EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0),
        child:
        Wrap(
            children: _Tokenlist(context)
        ),

      )
      );
  }

}




