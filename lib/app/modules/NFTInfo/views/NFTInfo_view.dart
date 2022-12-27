import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../../home/views/home_view.dart';
import '../../token/controllers/token_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/NFTInfo_controller.dart';


class NFTInfoView extends GetView<NFTInfoController> {
  NFTInfoView({Key? key}) : super(key: key);
  final title = Get.arguments["title"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
        centerTitle: true,
        flexibleSpace:  ColorView(),
      ),
      body: NFTInfoViewInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class NFTInfoViewInfo extends StatelessWidget {

  final title = Get.arguments["title"];
  final img = Get.arguments["img"];
  final describe = Get.arguments["describe"];
  final Grade = Get.arguments["Grade"];
  final color = Get.arguments["color"];
  final style = Get.arguments["style"];


  final nftInfoController = Get.put(NFTInfoController());
  @override

  Widget build(BuildContext context){
    Container _content(){
      return
        Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child:SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:     Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child:
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 350,
                              child:  ClipRRect(
                                borderRadius:BorderRadius.circular(10),
                                child: Image.network(
                                  img,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Describe",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(118, 118, 118, 1),
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                        Container(
                          margin: EdgeInsets.only(top:10.0,bottom: 10.0),
                          child:AutoSizeText(
                            '${describe}',
                            maxLines: 8,
                            style: TextStyle(fontSize: 16,color: Colors.white),
                          ) ,
                        ),
                        Text(
                            "Attribute",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(118, 118, 118, 1),
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:  Color.fromRGBO(49, 49, 49, 1),
                          ),
                          margin: EdgeInsets.only(top:10.0),
                          padding: EdgeInsets.all(10.0),
                          child:
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5.0,right: 5.0,bottom: 10.0),
                                decoration: BoxDecoration(
                                  border:  Border(
                                      bottom: BorderSide( // 设置单侧边框的样式
                                          color: Color.fromRGBO(92, 92, 92, 1),
                                          width: 0.5,
                                          style: BorderStyle.solid
                                      )),
                                  color:  Color.fromRGBO(49, 49, 49, 1),
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child:   Text("Grade",style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16),textAlign: TextAlign.center,),
                                    ),

                                    Container(
                                      width: 80,
                                      child:   Text("Color",style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                      width: 80,
                                      child:   Text("Style",style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16),textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 10.0),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child:  Text("${Grade}",style: TextStyle(color: Colors.white,fontSize: 16,),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                      width: 80,
                                      child:  Text("${color}",style: TextStyle(color: Colors.white,fontSize: 16,),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                      width: 80,
                                      child:  Text("${style}",style: TextStyle(color: Colors.white,fontSize: 16,),textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )],
              ),
            )
        );
    }
    return Container(
        padding: const EdgeInsets.only(bottom: 60.0,top: 30.0),
        margin: EdgeInsets.only(left:40.0,right:40.0),
        child:Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: _content()
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 2.0,bottom: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:  Color.fromRGBO(59, 99, 237, 1),
                  ),
                  child: ElevatedButton(
                    onPressed: ()=>{
                      nftInfoController.setNFTName(title),
                      nftInfoController.setNFTImg(img),
                      Get.bottomSheet(
                        SendOutNFTViewInfoState(),
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
                    child: const Text(
                      'Send Out',
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
                  padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 2.0,bottom: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:  Color.fromRGBO(59, 99, 237, 1),
                  ),
                  child: ElevatedButton(
                    onPressed: ()=>{
                      nftInfoController.setNFTPrice("0.00"),
                      nftInfoController.setNFTName(title),
                      nftInfoController.setNFTImg(img),
                      Get.bottomSheet(
                        ShelvesButtonState(),

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
                    child: const Text(
                      'Put On Shelves',
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

    );
  }
}



class SendOutNFTViewInfoState extends StatefulWidget {
  const SendOutNFTViewInfoState({super.key});

  @override
  State<SendOutNFTViewInfoState> createState() => SendOutNFTViewInfo();
}

class SendOutNFTViewInfo extends State<SendOutNFTViewInfoState> {
  final nftInfoController = Get.put(NFTInfoController());
  final myController = TextEditingController();
  final box = GetStorage();
  final configController = Get.put(ConfigController());
  final controller = Get.put(ConfigController());
  final configWalletcontroller = Get.put(ConfigWalletController());
  late  List _list ;


  void initState() {
    _list =controller.walletInfo.value;
    super.initState();
  }

  @override

  void dispose() {
    myController.dispose();
    super.dispose();
  }
  List<Widget> _WalletList(){
    return _list.asMap().keys.map((f) =>
        Container(
            child:
            box.read('addressIndex') == f ?
          Container()
                :
            TextButton(onPressed: ()=>{
              nftInfoController.setReceivingAddress("${controller.walletInfo.value[f]["address"]}"),
              Get.bottomSheet(
                SendNFTButton(),
                isScrollControlled: true,
              )
            },
                child:  Container(
                  padding: EdgeInsets.only(left: 10.0,right: 0.0,top: 10.0,bottom: 10.0),
                  margin: EdgeInsets.only(bottom: 10.0),
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
                            "Receiving Address",
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
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.white24,
                              width: 1

                          ),
                        ),
                        child:
                        Column(
                          children: [
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
                            )
                          ],
                        )

                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.68,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child:    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
                                  child: Text(
                                    "Recently Used Address",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Column(
                                  children: _WalletList(),
                                ),
                              ]
                          ),
                        )
                    )
                  ],
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:  Color.fromRGBO(59, 99, 237, 1),
                  ),
                  child: ElevatedButton(
                    onPressed: ()=>{
                      if(myController.text.length >10){
                        nftInfoController.setReceivingAddress(myController.text),
                        Get.bottomSheet(
                          SendNFTButton(),
                          isScrollControlled: true,
                        )
                      }
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
            )

        )
              ],
            ),
          )
      );
  }

}

class SendNFTButton extends StatelessWidget {
  final nftInfoController = Get.put(NFTInfoController());
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
                            "Send NFT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                              transactionAnimationController.setH1("Your NFT has been successfully sent to the"),
                              transactionAnimationController.setType("TokenOrNFT"),
                              Navigator.pop(context),
                              Navigator.pop(context),
                              // Get.toNamed("/transactionAnimation")
                              // Get.offAll(TransactionAnimationView())
                              Get.off(TransactionAnimationView())
                              // transactionAnimationController.setH1("Your NFT has been successfully sent to the"),
                              // transactionAnimationController.setType("TokenOrNFT"),
                              // Get.offAll(TransactionAnimationView())
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

                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //圆角
                                    child: Image.network("${nftInfoController.NFTImg.value}",width: 180,height: 180,)
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child:  Text("${nftInfoController.NFTName.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                                            Text("${configController.interceptAddress(nftInfoController.receivingAddress.value)}",
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
                            transactionAnimationController.setH1("Your NFT has been successfully sent to the"),
                            transactionAnimationController.setType("TokenOrNFT"),
                            Navigator.pop(context),
                            Navigator.pop(context),
                            // Get.toNamed("/transactionAnimation")
                            // Get.offAll(TransactionAnimationView())
                            Get.off(TransactionAnimationView())
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




class ShelvesButtonState extends StatefulWidget {
  const ShelvesButtonState({super.key});

  @override
  State<ShelvesButtonState> createState() => ShelvesButton();
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

class ShelvesButton extends State<ShelvesButtonState>{
  final nftInfoController = Get.put(NFTInfoController());
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
                              "On the MarketPlaces",
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
                                  SellTokenButton(),
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13,bottom: 15.0),
                    height: MediaQuery.of(context).size.height * 0.63,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
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
                                                          '${nftInfoController.NFTPrice.value} ',
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
                                                  Text("W3G",
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
                                                  onChanged:(text){ text==""?nftInfoController.setNFTPrice("0.00"):nftInfoController.setNFTPrice(text);},
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
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children:[
                                          Text("Listing price",style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 18
                                          ),),
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
                                SellTokenButton(),
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
                    ),
                  )

                ],
              ),
            )
        ),

      );


  }
}

class SellTokenButton extends StatelessWidget {
  final controller = Get.put(TokenController());
  final myController = TextEditingController();
  final transactionAnimationController = Get.put(TransactionAnimationController());
  final nftInfoController = Get.put(NFTInfoController());
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
                            "On the MarketPlaces",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:20,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: ()=>{
                              // transactionAnimationController.setH1("Your token has been successfully sent to the "),
                              // Get.offAll(TransactionAnimationView())
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

                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //圆角
                                    child: Image.network("${nftInfoController.NFTImg.value}",width: 180,height: 180,)
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child:  Text("${nftInfoController.NFTName.value}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                                        Text("Listing price",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("${nftInfoController.NFTPrice.value} W3G ",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(59, 99, 237, 1),
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
                                        Text("MarketPlace Fees",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("--",
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
                                        Text("Artist royalties",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text("--",
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
                        margin: EdgeInsets.only(left: 10.0,right: 10.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 30.0,right: 30.0,top: 2.0,bottom: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Color.fromRGBO(59, 99, 237, 1),
                              ),
                              child: ElevatedButton(
                                onPressed: ()=>{
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
                              padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 2.0,bottom: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Color.fromRGBO(59, 99, 237, 1),
                              ),
                              child: ElevatedButton(
                                onPressed: ()=>{
                                  transactionAnimationController.setH1("${nftInfoController.NFTName} on MarketPlaces at"),
                                  transactionAnimationController.setType("PutOnShelves"),
                                  Navigator.pop(context),
                                  Navigator.pop(context),
                                  Get.off(TransactionAnimationView())
                                  // transactionAnimationController.setH1("${nftInfoController.NFTName} on MarketPlaces at"),
                                  // transactionAnimationController.setType("PutOnShelves"),
                                  // Get.offAll(TransactionAnimationView())
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
                                  'Put On Shelves',
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
                  ) ,
                )
              ],
            ),
          )
      );
  }

}
