import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/configAddressBook_controller.dart';

class ConfigAddressBookView extends GetView<ConfigAddressBookController> {
  ConfigAddressBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
        onTap: () {
      // 触摸收起键盘
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child:
    Scaffold(
      appBar: AppBar(
        title: Text("Add a label"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),

      ),
      body:ConfigAddressBookInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      resizeToAvoidBottomInset:false,
    )
    );
  }
}

class ConfigAddressBookInfo extends StatefulWidget {
  ConfigAddressBookInfo ({Key? key}) : super(key: key);

  @override

  ConfigAddressBookInfoView  createState() => ConfigAddressBookInfoView();

}

class ConfigAddressBookInfoView extends State<ConfigAddressBookInfo>{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  final addressText = TextEditingController();
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = new TextEditingController(text: '');
    super.initState();
  }


  Widget build(BuildContext context) {

  return
    Container(

        width: double.infinity,
        child:  Container(
            padding: const EdgeInsets.all(10.0),
            child:Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top:30.0,bottom: 20.0),
                    child: Center(
                      child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(20),
                                decoration:BoxDecoration(
                                  color: Color.fromRGBO(29, 29, 29, 1),
                                  borderRadius: BorderRadius.circular(50.0),

                                ),
                                child:Icon(Icons.add,
                                color: Color.fromRGBO(91, 91, 91, 1),size: 60,),
                            )
                          ]
                      ),
                    )

                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.only(top: 15.0,bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
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
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10), //边角为30
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white60, //边线颜色为黄色
                                  width: 1, //边线宽度为2
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10), //边角为30
                                  ),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(110, 176, 234, 1), //边框颜色为绿色
                                    width: 1, //宽度为5
                                  )),
                              hintText: "Name this label",
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30.0),
                            child:  TextField(
                              autocorrect: true,
                              controller: addressText,
                              keyboardType: TextInputType.text,
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

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10), //边角为30
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.white60, //边线颜色为黄色
                                    width: 1, //边线宽度为2
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10), //边角为30
                                    ),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(110, 176, 234, 1), //边框颜色为绿色
                                      width: 1, //宽度为5
                                    )),
                                hintText: "Address",
                                hintStyle: TextStyle(
                                    color: Colors.white70
                                ),
                              ),
                            ),
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
                              configAddressBookController.addressBook_add({"name":"${_controller.text}","address":"${addressText.text}","openState":false,"proxyPayUsageCount":0,"proxyPayTotal":0}),
                              // configAddressBookController.addressBook.removeAt(0), 删除指定index
                              configAddressBookController.setAddressBookIndex(configAddressBookController.addressBook.length-1),
                              Get.offNamed("/configEditAddressBook")
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
            )

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



