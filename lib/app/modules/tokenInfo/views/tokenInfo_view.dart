import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../token/controllers/token_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/tokenInfo_controller.dart';



class TokenInfoView extends StatefulWidget {
  TokenInfoView({Key? key}) : super(key: key);

  @override

  Token_InfoView createState() => Token_InfoView();

}

class Token_InfoView extends State<TokenInfoView> {
  final controller = Get.put(TokenController());
  final title = Get.arguments["title"];
  final name = Get.arguments["name"];
  final amount = Get.arguments["amount"];
  final decimals = Get.arguments["decimals"];
  final tokenID = Get.arguments["tokenID"];
  @override
//   Get.off(arguments: {
//   "ToAddress":"${controller.sendAddress.value}",
//   "sendToken":"${controller.sendAddressToken.value}",
//   "tokenName":"${controller.tokenName.value}",
//   "decimals":"${controller.TokenDecimals.value}",
//   "tokenID":"${controller.TokenID.value}"})
// },
  void initState() {
    controller.setAddressBalance(amount);
    controller.setTokenDecimals(decimals);
    controller.setTokenID(tokenID);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("$name"),
        centerTitle: true,
        flexibleSpace: ColorView(),
        elevation: 0,
          actions: <Widget>[
            TokenDetailButton(),
          ],
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: tokenInfoViewInfo(),

    );
  }
}

class tokenInfoViewInfo extends StatelessWidget {
  final controller = Get.put(TokenController());
  final img = Get.arguments["img"];
  final title = Get.arguments["title"];
  final amount = Get.arguments["amount"];
  final List<Map<String, dynamic>> _list = [
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已发送",
      "tokenName":"W3G",
      "rise" : false,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已发送",
      "tokenName":"W3G",
      "rise" : false,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已发送",
      "tokenName":"W3G",
      "rise" : false,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已发送",
      "tokenName":"W3G",
      "rise" : false,
    },
    {
      "time":"Sep 8,2022",
      "amount":"123.3",
      "address":"Hsec...t24n",
      "state":"已接收",
      "tokenName":"W3G",
      "rise" : true,
    },
  ];
  void setSendAddressToken (){

  }

  List<Widget> _Token(){
    return _list.map((item) =>
    TextButton(
      onPressed: ()=>{
        Get.toNamed("/transactionHistory",arguments: {"tokenName":"${title}","img":"${img}","rise":"${item["rise"]}","state":"${item["state"]}","amount":"${item["amount"]}","time":"${item["time"]}","address":"${item["address"]}"})
      },
        child:Container(

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
                        margin: EdgeInsets.only(right: 10),

                        decoration: const BoxDecoration(
                          // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Image.asset('assets/images/${img}.png',)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom:5),
                          child:  Text(
                            item["state"],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                          child:  Text(
                            'To: ${item["address"]}',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white38,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                item['rise']?
                Center(
                  child:Text(
                    "+${item["amount"]} ${title}",
                    style: TextStyle(
                        color: Colors.green[400],
                        fontWeight: FontWeight.w800,
                        fontSize: 14
                    ),
                  ) ,
                ):
                Center(
                  child:Text(
                    "-${item["amount"]} ${title}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14
                    ),
                  ) ,
                )


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
    return   SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        // top content
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: EdgeInsets.only(top: 10),
          // decoration:BoxDecoration(
          //   border: Border.all(
          //     color: Colors.red,
          //   ),
          // ),
          child: Column(
            children: [
                  Center(
                    child: Text(
                      '$amount ${controller.tokenName.value}',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white
                      ),
                    ),
                  ),
              Center(
                child:
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0,15.0,0.0,20.0), //容器外补白
                    child: const Text(
                      '--\$',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white54

                      ),
                    ),
                  ),
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DepositButton(),
                  SendButtonState(amount:amount)
                ],
              )
            ],
          ),
        ),
        // content
        TextButton(onPressed: ()=>{
          BrnToast.show("coming soon", context),
        },
          child:
        Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white12
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.black26
                  ),
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow[300],
                    size: 32,),
                ),
                Container(
                  margin: EdgeInsets.only(left:10.0),
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Start pledge to earn W3G token income",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700
                        ),),
                      Text(
                          "Pledge tokens and earn rewards",
                          style: TextStyle(
                              color: Colors.white38,
                              fontSize: 13,
                              fontWeight: FontWeight.w700
                          )
                      )
                    ],
                  ),
                )
              ],
            )

        ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0),
          child:
          Text(
            "Recent Transactions",
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
            child:
              Wrap(
                spacing:2.0,
                children: _Token()
              ),
            )
      ],
    )
    );
  }
}
class DepositButton extends StatelessWidget {
  final DepositButtonFu = Get.put(TokenInfoController());
  final configController = Get.put(ConfigController());
  final controller = Get.put(TokenController());
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
                Container(
                    height: MediaQuery.of(context).size.height * 0.93,
                    width: double.infinity,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                color: Color.fromRGBO(21, 21, 21, 1)
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
                                                          DepositButtonFu.setCopyState(),
                                                          Clipboard.setData(ClipboardData(text: '${configController.walletInfo.value[configController.walletIndex.value]["address"]}')),
                                                          HapticFeedback.heavyImpact(),
                                                          print(DepositButtonFu.copyState)
                                                        },
                                                        style: ButtonStyle(
                                                          //去除阴影
                                                            elevation: MaterialStateProperty.all(0),
                                                            //将按钮背景设置为透明
                                                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                            splashFactory: NoSplash.splashFactory
                                                        ),
                                                        child:
                                                        GetX<TokenInfoController>(
                                                          builder: (DepositButtonFu){
                                                            return
                                                              Text(
                                                                '${DepositButtonFu.copyState}',
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
                                              BrnToast.show("coming soon", context),
                                            },
                                            style: ButtonStyle(
                                              //去除阴影
                                                elevation: MaterialStateProperty.all(0),
                                                //将按钮背景设置为透明
                                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                splashFactory: NoSplash.splashFactory
                                            ),
                                            child: const Text(
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
                    )
                ),
                isScrollControlled: true
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
          child:  const Text(
            'Deposit',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      );

  }

}



class SendButtonState extends StatefulWidget {
  const SendButtonState({super.key, required amount});

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

                ),
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
              'Send Out',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          )

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


class TokenDetailButton extends StatelessWidget{
  @override

  final Uri _url = Uri.parse('https://web3games-expolorer.vercel.app/');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Widget build(BuildContext context){
    return
      Container(
        child:  IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: '',
          onPressed: ()=>{
            Get.bottomSheet(
                Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    child:
                    ClipRect(
                      child:  BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white10
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
                                      child:
                                      Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                          "——",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800
                                          ),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10.0,left: 10.0),
                                    child: Column(
                                      children: [
                                        TextButton(onPressed: _launchUrl,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(right: 10.0),
                                                  child:  Icon(
                                                    Icons.open_in_new_sharp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "在 Web3Games Expolorer上查看",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w800
                                                  ),
                                                )
                                              ],
                                            ),
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                                              //去掉inkwell的点击效果
                                            )),

                                        Row(
                                          children: [

                                          ],
                                        ), 
                                      ],
                                    ),
                                  )
                                  

                                ],
                              ),
                            ),
                          )
                      ),
                    )
                ),
                isScrollControlled: true
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
        ),

      );

  }
}


