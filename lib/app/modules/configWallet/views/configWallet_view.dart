import 'dart:ui';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../avatar/controllers/avatar_controller.dart';
import '../../config/controllers/config_controller.dart';
import '../../config/views/config_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/config_controller.dart';

class ConfigWalletView extends GetView<ConfigWalletController> {
  const ConfigWalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Wallet"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
      ),
      body:ConfigWalletInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      resizeToAvoidBottomInset:false,
    );
  }
}

class ConfigWalletInfo extends StatefulWidget {
  ConfigWalletInfo ({Key? key}) : super(key: key);

  @override

  ConfigWalletInfoView  createState() => ConfigWalletInfoView();

}

class ConfigWalletInfoView extends State<ConfigWalletInfo>{
  final index = int.parse(Get.arguments["addressIndex"]);
  final controller = Get.put(ConfigWalletController());
  final configController = Get.put(ConfigController());



  @override
  Widget build(BuildContext context) {

  return
    Container(
      padding: const EdgeInsets.all(10.0),

      child:Column(
        children: [
          Container(
            padding: EdgeInsets.only(top:30.0,bottom: 20.0),
             child: Center(
               child: Column(
                   children: [
                     Container(
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(10.0),
                         child: Image.network(
                           "${configController.walletInfo.value[index]["nft"]}",
                           width: 50,
                         ),
                       ),
                   ),
                   Container(
                     padding: EdgeInsets.only(top: 8),
                       child:
                       GetX<ConfigWalletController>(
                           builder: (ConfigWalletController) {
                             return
                               Text("${configController.walletInfo.value[index]["name"]}",
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 16
                                 ),);
                           })
                   )
                  ]
               ),
             )

          ),
          Container(
            padding: EdgeInsets.only(left: 14.0,right: 14.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(29, 29, 29, 1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child:
                    TextButton(onPressed:
                        ()=>{
                      Get.bottomSheet(
                        StateWalletNameView(addressIndex: index,),
                        isScrollControlled: true,
                      )
                    },
                      style: ButtonStyle(
                        //去除阴影
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        //去掉inkwell的点击效果
                      ),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Wallet Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),
                          ),
                          Row(
                            children: [
                              GetX<ConfigWalletController>(
                                  builder: (ConfigWalletController){
                                    return
                                      Text("${configController.walletInfo.value[index]["name"]}",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16
                                        ),);
                                  }),
                              Icon(Icons.chevron_right,size: 35,color: Colors.white,)
                            ],
                          )
                        ],
                      ),)

                ),
                Divider(color: Color.fromRGBO(53, 53, 53, 1)),
                Container(
                  child: Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child:
                          Text("Wallet Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),),
                        ),
                        TextButton(
                            onPressed: ()=>{
                              Clipboard.setData(ClipboardData(text: "${configController.walletInfo.value[index]["address"]}")),
                              controller.setCopyState(),
                              HapticFeedback.heavyImpact(),
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
                            child:  Stack(
                              children: [
                                Positioned(child:  Container(
                                  child: TextButton(
                                    onPressed: ()=>{
                                      Clipboard.setData(ClipboardData(text: "${configController.walletInfo.value[index]["address"]}")),
                                      controller.setCopyState(),
                                      HapticFeedback.heavyImpact(),
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
                                    Text("${configController.interceptAddress(configController.walletInfo.value[index]["address"])}",
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 16
                                      ),),

                                  ),
                                ),
                                ),
                                GetX<ConfigWalletController>(
                                    builder: (ConfigWalletController){
                                      return
                                        Positioned(
                                          child: AnimatedOpacity(
                                              opacity: controller.copyState.value? 1.0: 0.0,
                                              duration: Duration(milliseconds: 500),
                                              child:  Container(
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
                  ),
                ),
                Divider(color: Color.fromRGBO(53, 53, 53, 1)),
                Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child:
                    TextButton(onPressed:
                        ()=>{
                      Get.bottomSheet(
                        StateMnemonicsInfoView(addressIndex: index,),
                        isScrollControlled: true,
                      )
                    },
                      style: ButtonStyle(
                        //去除阴影
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        //去掉inkwell的点击效果
                      ),
                      child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Show Menmonics",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18
                              ),
                            ),
                            Icon(Icons.chevron_right,size: 35,color: Colors.white,),]
                      ),
                    )
                ),
                Divider(color: Color.fromRGBO(53, 53, 53, 1)),
                Container(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child:
                    TextButton(onPressed:
                        ()=>{
                      Get.bottomSheet(
                        StateRemoveWalletView(addressIndex: index,),
                        isScrollControlled: true,
                      )
                    },
                      style: ButtonStyle(
                        //去除阴影
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        //去掉inkwell的点击效果
                      ),
                      child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Remove Wallet",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18
                              ),
                            ),]
                      ),
                    )
                ),

              ],
            ),
          )
        ],
      )

    );
  }
}

class RegexUtil {
  /// 正则匹配第一个输入字符不能为空格
  static const String regexFirstNotNull = r'^(\S){1}';
}

class RegexFormatter extends TextInputFormatter {
  RegexFormatter({required this.regex});

  /// 需要匹配的正则表达
  final String regex;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    if (!RegExp(regex).hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}


class StateWalletNameView extends StatefulWidget {
  final addressIndex;

  StateWalletNameView ({Key? key,this.addressIndex}) : super(key: key);

  @override

  StateWalletName  createState() => StateWalletName();

}
class StateWalletName extends State<StateWalletNameView>{
  late TextEditingController _controller;
  final configController = Get.put(ConfigController());
  late int index ;

  @override

  void initState() {
    index = widget.addressIndex;
    _controller = new TextEditingController(text: "${configController.walletInfo.value[index]["name"]}");
    super.initState();
  }

  Widget build(BuildContext context){
    return
    GestureDetector(
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
        child:   Container(
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
                                  IconButton(
                                    icon:Icon(Icons.chevron_left,
                                      size: 30,),
                                    color: Colors.white,

                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  Text(
                                    "Wallet Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:20,
                                        fontStyle: FontStyle.normal
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: TextButton(
                                        onPressed: ()=>{
                                          configController.setWalletName(_controller.text,index),
                                          Navigator.pop(context)
                                        },
                                        child:Text( "Save",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:20,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700
                                          ),)

                                    ),
                                  )

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
                                        autocorrect: true,
                                        controller: _controller,
                                        keyboardType: TextInputType.text,
                                        maxLength:10,
                                        maxLines:1,
                                        cursorColor: Colors.white54,
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                        inputFormatters: [
                                          RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                                        ],
                                        decoration: InputDecoration(
                                          counterText:"",
                                          suffixIcon:IconButton(
                                            onPressed: (){
                                              _controller.clear();
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.white54,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none
                                          ),
                                          hintText: "name",
                                          hintStyle: TextStyle(
                                              color: Colors.white70
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
                                        configController.setWalletName(_controller.text,index),
                                        Navigator.pop(context)
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
                                      Text('SAVE',
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
                          ),

                        ],
                      ),
                    ),
                  )
              ),
            )
        ),
    );

  }
}


class StateMnemonicsInfoView extends StatefulWidget {
  final addressIndex;
  StateMnemonicsInfoView({super.key,this.addressIndex});


  @override

  MnemonicsInfo  createState() => MnemonicsInfo();

}

class MnemonicsInfo extends  State<StateMnemonicsInfoView> {
  final box = GetStorage();
  final configController = Get.put(ConfigController());
  final controller = Get.put(ConfigWalletController());

  late int index ;
  late List data;
  void initState() {
    index = widget.addressIndex;
   data = configController.walletInfo[index]['mnemonic'].split(" ");
    super.initState();
  }

  @override
  List<Widget> _phrase(){
    return data.asMap().entries.map((entry) =>
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,

                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color.fromRGBO(49, 49, 49, 1)
                      ),
                      child:Center(child:Text("${entry.key }" ,style: TextStyle(color: Colors.white,fontSize: 20),),)
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.38,
                      margin: EdgeInsets.only(left: 10.0),
                      padding: EdgeInsets.only(left: 24.0,right: 24.0,bottom: 5.0,top: 5.0),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color.fromRGBO(49, 49, 49, 1)
                      ),
                      child:  Text("${entry.value}" ,style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),

                  ],
                )

        ),
    ).toList();
  }

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
                            "Your key phrase",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                            },
                            child:Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800
                              ),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              //去掉inkwell的点击效果
                            )
                        ),
                      ],
                    )
                ),
                Container(
                    padding:  EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 10.0),
                    child:Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                                height: MediaQuery.of(context).size.height * 0.68,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:
                               Column(
                                 children:_phrase()
                               )
                                )
                            )
                          ],
                        ),
                    Container(
                        width: 200,

                      decoration:BoxDecoration(
                        color: Color.fromRGBO(59,99,237,1),
                        borderRadius: BorderRadius.circular(50),

                      ),
              
                        child: TextButton(
                          onPressed: ()=>{
                            Clipboard.setData(ClipboardData(text: "${configController.walletInfo[index]['mnemonic']}")),
                            controller.setCopyState(),
                            HapticFeedback.heavyImpact(),
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
                          child:  Stack(
                            children: [
                              Positioned(child:  Container(
                                padding: EdgeInsets.only(top: 5,bottom: 5,left: 68),
                                child:
                                Text("Copy",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),),
                              ),
                              ),
                              GetX<ConfigWalletController>(
                                  builder: (ConfigWalletController){
                                    return
                                      Positioned(
                                        child: AnimatedOpacity(
                                            opacity: controller.copyState.value? 1.0: 0.0,
                                            duration: Duration(milliseconds: 500),
                                            child:  Container(
                                                padding: EdgeInsets.only(left: 18,right: 18,top: 10.0,bottom: 10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color:  Color.fromRGBO(59, 99, 237, 1),
                                                ),
                                                child:
                                                    Center(
                                                      child:   Text(
                                                        'Copied!',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800, //    字体加粗
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      )
                                                    ),

                                            )
                                        ),

                                      );
                                  })

                            ],
                          )
                      ))


                      ],
                    )

                )
              ],
            ),
          )
      );
  }



}


class StateRemoveWalletView extends StatefulWidget {
  final addressIndex;
  StateRemoveWalletView({super.key,this.addressIndex});
  @override

  RemoveWallet  createState() => RemoveWallet();

}
class RemoveWallet extends  State<StateRemoveWalletView> {
  final configController = Get.put(ConfigController());
  late int index ;
  void initState() {
    index = widget.addressIndex;
    super.initState();
  }
  final box = GetStorage();
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
                            "Remove Wallet",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                            },
                            child:Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800
                              ),),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              //去掉inkwell的点击效果
                            )
                        ),
                      ],
                    )
                ),
                Container(
                    padding:  EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 10.0),
                    child:Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.68,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child:
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20),
                                          child: Column(
                                            children: [
                                              Icon(Icons.playlist_remove_rounded,color: Colors.red,size: 60,),
                                              Container(
                                                  child: Text("Remove Wallet (${configController.interceptAddress(configController.walletInfo[index]['address'])})",style: TextStyle(color: Colors.white,fontSize: 20),)
                                              )
                                            ],
                                          )
                                        )
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Color.fromRGBO(59, 99, 237, 1),
                              ),
                              child: ElevatedButton(
                                onPressed: ()=>{
                                  Navigator.pop(context)
                                },
                                style: ButtonStyle(
                                  //去除阴影
                                  elevation: MaterialStateProperty.all(0),
                                  //将按钮背景设置为透明
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),

                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800
                                    //    字体加粗
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Colors.red,
                              ),
                              child: ElevatedButton(
                                onPressed: ()=>{
                                if( box.read("address").length ==1){
                                BrnToast.show("Failed to delete", context)
                                }else
                                  {
                                    configController.removeAddress(index),
                                    Get.offAll(HomeView(),)
                                  },
                                // box.read('address').removeAt(index),
                                //   print("${box.read('address')[index]}"),
                                //
                                //   configController.removeAddress(index),
                                },
                                style: ButtonStyle(
                                  //去除阴影
                                  elevation: MaterialStateProperty.all(0),
                                  //将按钮背景设置为透明
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),

                                ),
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800
                                    //    字体加粗
                                  ),
                                ),
                              ),
                            )],)


                      ],
                    )

                )
              ],
            ),
          )
      );
  }



}
