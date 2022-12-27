import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../avatar/controllers/avatar_controller.dart';
import '../../configAddressBook/controllers/configAddressBook_controller.dart';
import '../controllers/config_controller.dart';

class ConfigView extends GetView<ConfigController> {
  const ConfigView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Config"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
      ),
      body:ConfigInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class ConfigInfo extends StatefulWidget {
  ConfigInfo ({Key? key}) : super(key: key);

  @override

  ConfigInfoView  createState() => ConfigInfoView();

}

class ConfigInfoView extends State<ConfigInfo>{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  final configController = Get.put(ConfigController());
  @override

  void initState() {
    configController.setNetWorkInfo();
    configController.setExplorerInfo();
    if(GetStorage().read('addressBook')==null){
     print("没值");
    }else{
      configAddressBookController.setAddressBookInfo();
    }

    super.initState();
  }
  Widget build(BuildContext context) {
  return
    Container(
      padding: const EdgeInsets.all(10.0),

      child: Wrap(
        runSpacing: 15.0,
          children: [
           Wallet(),
            AddressBook(),
            NetWork(),
            Explorer(),
            About()
          ],
      ),
    );
  }
}

class Wallet extends StatelessWidget{
  @override
  final controller = Get.put(ConfigController());
  Widget build(BuildContext context) {
    return
      Container(
        padding:  EdgeInsets.all(4.0),
          decoration:BoxDecoration(
            color: Color.fromRGBO(29,29,29,1),
            borderRadius: BorderRadius.circular(10.0),

          ),
        child: TextButton(
          onPressed:()=>{
            Get.toNamed("/configWalletList",)
            // Get.off(ConfigWalletView())
          },
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GetX<ConfigController>(
              builder: (ConfigController) {
                return
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          "${controller.walletInfo.value[controller.walletIndex
                              .value]["nft"]}",
                          width: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${controller.walletInfo.value[controller
                                .walletIndex.value]["name"]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                              ),),
                            Text("${controller.interceptAddress(
                                controller.walletInfo.value[controller
                                    .walletIndex.value]["address"])}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white54
                              ),),


                          ],
                        ),
                      )
                    ],);
              }),
                Icon(Icons.chevron_right,size: 30,color: Colors.white,)
              ],
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            )),


      );
  }
}

class AddressBook extends StatelessWidget{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding:  EdgeInsets.all(4.0),
        decoration:BoxDecoration(
          color: Color.fromRGBO(29,29,29,1),
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: TextButton(onPressed:
            ()=>{
              Get.toNamed("/configAddressBookList",)
              // BrnToast.show("coming soon", context)
            },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(

                    child:  Column(
                      children: [
                        Text("Address Book",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),)
                      ],
                    ) ,
                  )
                ],),
              Row(
                children: [ GetX<ConfigAddressBookController>(
                    builder: (ConfigAddressBookController) {
                      return
                        Text("${configAddressBookController.addressBook.length}",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14
                          ),);
                    }),
                  Icon(Icons.chevron_right,size: 30,color: Colors.white,)],
              )



            ],
          ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            ),),

      );
  }
}

class NetWork extends StatelessWidget{
  final controller = Get.put(ConfigController());
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding:  EdgeInsets.all(4.0),
        decoration:BoxDecoration(
          color: Color.fromRGBO(29,29,29,1),
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: TextButton(
            onPressed:
                ()=>{
              Get.bottomSheet(
                StateNetWork(),
                isScrollControlled: true,
              )
            },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(

                    child:  Column(
                      children: [
                        Text("Change Network",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),)
                      ],
                    ) ,
                  )
                ],),
              Row(
                children: [
                  GetX<ConfigController>(
                      builder: (ConfigController) {
                        return
                          Text("${controller.netWork.value["title"]}",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14
                            ),);
                      }),
                  Icon(Icons.chevron_right,size: 30,color: Colors.white,)
                ],
              ),
            ],
          ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            )),

      );
  }
}

class StateNetWork extends StatelessWidget{
  final controller = Get.put(ConfigController());
  final List<Map<String, dynamic>> _list = [
    {

      "title":"Main Network Beta",
      "subtitle" :"Web3Games RPC Network"
    },
    {

      "title":"Test Network",
      "subtitle" :"https://api.testnet.web3games.co"
    },
    {

      "title":"Developer Network",
      "subtitle" :"https://api.testnet.web3games.com"
    },
  ];


  @override
  List<Widget> _netWork(BuildContext context){
    return _list.map<Widget>((item) =>
        Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(34, 34, 34, 1),
                borderRadius: BorderRadius.circular(10)
            ),
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              controller.netWork.value["title"] == item["title"]?
              TextButton(
                onPressed: ()=>{
                  controller.setNetWorksState({
                    "title":"${item["title"]}",
                    "subtitle" :"${item["subtitle"]}"
                    ,}),
                  Navigator.pop(context)
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                        Text("${item["title"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16),),
                        Text("${item["subtitle"]}",style: TextStyle(color: Colors.white54,fontSize: 16),),
                ]
                    ),
                    Icon(Icons.check_circle_outline_outlined,color: Color.fromRGBO(59, 99, 237, 1),size: 30,),
                  ],
                ),
                style: ButtonStyle(
                  //去除阴影
                  elevation: MaterialStateProperty.all(0),
                  //将按钮背景设置为透明
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //去掉inkwell的点击效果
                ),)
                  :
              TextButton(
                onPressed: ()=>{
                  controller.setNetWorksState({
                    "title":"${item["title"]}",
                    "subtitle" :"${item["subtitle"]}"
                    ,}),
                  Navigator.pop(context)
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("${item["title"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 16),),
                          Text("${item["subtitle"]}",style: TextStyle(color: Colors.white54,fontSize: 16),),
                        ]
                    ),
                  ],
                ),
                style: ButtonStyle(
                  //去除阴影
                  elevation: MaterialStateProperty.all(0),
                  //将按钮背景设置为透明
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //去掉inkwell的点击效果
                ),)
              ,
            ],
          ),
        )

    ).toList();
  }
  Widget build(BuildContext context){
    return
      Container(
          height: MediaQuery.of(context).size.height * 0.93,
          width: double.infinity,
          child:
          ClipRect(
            child: Container(
                  padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(21,21,21,1)
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
                                Text(
                                  "Change NetWork",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                      child:Text( "      ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:20,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700
                                        ),)
                                  ),
                              ],
                            )
                        ),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child:Container(
                          child:
                          GetX<ConfigController>(
                              builder: (ConfigController){
                                return
                                  Wrap(
                                    children: _netWork(context),
                                  );}
                          )
                      )
                  )
                      ],
                    ),
                  ),
                )
          );
  }
}

class Explorer extends StatelessWidget{
  final controller = Get.put(ConfigController());
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding:  EdgeInsets.all(4.0),
        decoration:BoxDecoration(
          color: Color.fromRGBO(29,29,29,1),
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: TextButton( onPressed:
            ()=>{
          Get.bottomSheet(
            StateExplorer(),
            isScrollControlled: true,
          )
        },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(

                    child:  Column(
                      children: [
                        Text("Preferred Explorer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),)
                      ],
                    ) ,
                  )
                ],),

              Row(
                children:
                [
                  GetX<ConfigController>(
                      builder: (ConfigController) {
                        return
                          Text("${controller.explorer.value}",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14
                            ),
                          );
                      }),
                  Icon(Icons.chevron_right,size: 30,color: Colors.white,)
                ],
              ),



            ],
          ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            )),

      );
  }
}

class StateExplorer extends StatelessWidget{
  final controller = Get.put(ConfigController());
  final List<Map<String, dynamic>> _list = [
    {
      "title":"W3G Beach"
    },
    {
      "title":"W3G"
    },
    {
      "title":"W3G Explorer"
    },
    {
      "title":"W3G FM"
    }
  ];
  @override
  List<Widget> _netWork(BuildContext context){
    return _list.map<Widget>((item) =>
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(34, 34, 34, 1),
              borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              controller.explorer.value == item["title"]?
              TextButton(
                onPressed: ()=>{
                  controller.setExplorer(item["title"]),
                  Navigator.pop(context)
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
                child:Container(
                  height: 45.0,
                  padding: EdgeInsets.all(8.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item["title"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                      Icon(Icons.check_circle_outline_outlined,color: Color.fromRGBO(59, 99, 237, 1),size: 32,),
                    ],
                  ),
                ),)
                  :
              TextButton(
                onPressed: ()=>{
                  controller.setExplorer(item["title"]),
                  Navigator.pop(context)
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
                child:Container(
                  height: 45.0,
                  padding: EdgeInsets.all(8.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item["title"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                    ],
                  ),
                ),)
              ,
            ],
          ),
        )

    ).toList();
  }
  Widget build(BuildContext context){
    return
      Container(
          height: MediaQuery.of(context).size.height * 0.93,
          width: double.infinity,
          child:
          ClipRect(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color.fromRGBO(21,21,21,1)
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
                          Text(
                            "Change NetWork",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(right: 5.0),
                              child:Text( "      ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700
                                ),)
                          ),
                        ],
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child:Container(
                          child:
                          GetX<ConfigController>(
                              builder: (ConfigController){
                                return
                                  Wrap(
                                    children: _netWork(context),
                                  );}
                          )
                      )
                  )
                ],
              ),
            ),
          )
      );
  }
}

class About extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding:  EdgeInsets.all(4.0),
        decoration:BoxDecoration(
          color: Color.fromRGBO(29,29,29,1),
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: TextButton( onPressed:()=>{
          Get.toNamed("/configAbout",)
          // Get.off(ConfigWalletView())
        },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(

                    child:  Column(
                      children: [
                        Text("About Aura Wallet",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                          ),)
                      ],
                    ) ,
                  )
                ],),

              Icon(Icons.chevron_right,size: 30,color: Colors.white,)


            ],
          ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            )),

      );
  }
}


