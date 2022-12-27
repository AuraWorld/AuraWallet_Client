import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';


import '../../components/color/color.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Transaction'),
        centerTitle: true,
        flexibleSpace: ColorView(),
      ),

      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: TransactionViewInfo(),
    );
  }
}

class TransactionViewInfo extends StatelessWidget {
  final List<Map<String, dynamic>> _list = [
    {
      "time" : "Sep 10,2022",
      "list" : [
        {
          "tokenName" : "ETH",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "2.4",
          "img":"ETH",
          "rise": false,
          "hash":"https://polkadot.subscan.io/extrinsic/0x2f3c70eca9645814f5b6a067bca829a1dbcf8918f2af2df634f91048bc32edef"
        },
        {
          "tokenName" : "GST",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "2000",
          "img":"GST",
          "rise": true,
          "hash":"https://web3games-expolorer.vercel.app/extrinsics/0xddfa57b55074b84001429d2672e032838ae45e4ccf44affe4a5fd119f2f49f4b"
        },
      ],
    },
    {
      "time" : "Sep 9,2022",
      "list" : [
        {
          "tokenName" : "APT",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "1279",
          "img":"APT",
          "rise": false,
          "hash":"https://web3games-expolorer.vercel.app/extrinsics/0xddfa57b55074b84001429d2672e032838ae45e4ccf44affe4a5fd119f2f49f4b"
        },
        {
          "tokenName" : "APT",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "200",
          "img":"APT",
          "rise": true,
          "hash":"https://web3games-expolorer.vercel.app/extrinsics/0xddfa57b55074b84001429d2672e032838ae45e4ccf44affe4a5fd119f2f49f4b"
        },
      ],
    },
    {
      "time" : "Sep 8,2022",
      "list" : [
        {
          "tokenName" : "W3G",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "1279",
          "img":"W3G",
          "rise": false,
          "hash":"https://polkadot.subscan.io/extrinsic/0x2f3c70eca9645814f5b6a067bca829a1dbcf8918f2af2df634f91048bc32edef"
        },
        {
          "tokenName" : "W3G",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "200",
          "img":"W3G",
          "rise": true,
          "hash":"https://polkadot.subscan.io/extrinsic/0x2f3c70eca9645814f5b6a067bca829a1dbcf8918f2af2df634f91048bc32edef"
        },
      ],
     },
    {
      "time" : "Sep 7,2022",
      "list" : [
        {
          "tokenName" : "W3G",
          "state" : "已发送" ,
          "address" : "2K93...6CJC",
          "amount" : "2.2",
          "img":"W3G",
          "rise": false,
          "hash":"https://polkadot.subscan.io/extrinsic/0x2f3c70eca9645814f5b6a067bca829a1dbcf8918f2af2df634f91048bc32edef"
        },
      ],
    },
  ];
  List<Widget> _Transaction(){
    return _list.map((item) =>
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  item["time"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                      fontSize: 20
                  ),
                ),
              ),
         Wrap(
            spacing:10.0,
            runSpacing: 10.0,
            children:
            item["list"].map<Widget>((lists)=>
              TextButton(
                onPressed: ()=>{
                  Get.toNamed("/transactionHistory",
                      arguments: {"tokenName":"${lists["tokenName"]}",
                        "img":"${lists["img"]}","rise":"${lists["rise"]}",
                        "state":"${lists["state"]}","amount":"${lists["amount"]}",
                        "time":"${item["time"]}","address":"${lists["address"]}",
                        "hash":"${lists["hash"]}"})
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration:BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(97, 121, 245, 1)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(29, 29, 29, 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                child: ClipOval(child: Image.asset('assets/images/${lists["tokenName"]}.png'))
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child:  Text(
                                      "${lists["state"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child:  Text(
                                      "至: ${lists["address"]}",
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      lists["rise"]?
                      Container(
                          child: Row(
                              children:[
                                Text("+${lists["amount"]}", style: TextStyle(color: Colors.green, fontWeight:FontWeight.w500,fontSize: 16,),),
                                Text(
                                  " ${lists["tokenName"]}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight:FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ]
                          )
                      )
                     :
                      Container(
                          child: Row(
                              children:[
                                Text("-${lists["amount"]}", style: TextStyle(color: Colors.white, fontWeight:FontWeight.w500,fontSize: 16,)),
                                Text(
                                  " ${lists["tokenName"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ]
                          )
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
            )
  ],
          ),
        ),
    ).toList();
  }

  @override

  Widget build(BuildContext context){
    return
     Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(10.0),
      child:SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Wrap(
          spacing:10.0,
          runSpacing: 10.0,
          //gap-x
          alignment: WrapAlignment.center,
          children:_Transaction()
      ),
    )
    );
  }
}
