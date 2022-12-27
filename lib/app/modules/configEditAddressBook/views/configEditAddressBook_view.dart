import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../configAddressBook/controllers/configAddressBook_controller.dart';
import '../controllers/configEditAddressBook_controller.dart';

class ConfigEditAddressBookView extends GetView<ConfigEditAddressBookController> {
  ConfigEditAddressBookView({Key? key}) : super(key: key);
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
        title: Text(""),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
        actions: <Widget>[
         TextButton(onPressed: ()=>{
         Get.bottomSheet(
           EditTokenState(),
           isScrollControlled: true,
         )

         }, child: Text(
           "Edit",
           style: TextStyle(
             color: Color.fromRGBO(59, 99, 237, 1),
             fontSize: 18
           ),
         ),
           style: ButtonStyle(
             //去除阴影
             overlayColor: MaterialStateProperty.all(Colors.transparent),
             //去掉inkwell的点击效果
           ),)
        ],

      ),
      body:  ConfigEditAddressBookInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      resizeToAvoidBottomInset:false,
    )
    );
  }
}

class ConfigEditAddressBookInfo extends StatefulWidget {
  ConfigEditAddressBookInfo ({Key? key}) : super(key: key);

  @override

  ConfigEditAddressBookInfoView  createState() => ConfigEditAddressBookInfoView();

}

class ConfigEditAddressBookInfoView extends State<ConfigEditAddressBookInfo>{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  late int index;

  late TextEditingController _address;
  late bool _isCheck;
  void _changed(isCheck) {
    // List addressBook = configAddressBookController.addressBook;
    // List copyList = List.from(addressBook);
    // copyList[index]["openState"] = isCheck;
    //深拷贝
    configAddressBookController.setAddressBookOpenState(index,isCheck);
    print("${ configAddressBookController.addressBook}");

  }
  @override

  void initState() {
     index = configAddressBookController.addressBookIndex.value;
    _address = new TextEditingController(text: '${configAddressBookController.addressBook[index]["address"]}');
    _isCheck = configAddressBookController.addressBook[index]['openState'];

    super.initState();
  }
  //给予输入框值


  Widget build(BuildContext context) {

  return
    GetX<ConfigAddressBookController>(
      builder: (configAddressBookController)
  {
    return
      Container(

          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                      child: Center(
                        child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(29, 29, 29, 1),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Icon(Icons.edit_calendar_outlined,
                                  color: Color.fromRGBO(91, 91, 91, 1),
                                  size: 60,),
                              )
                            ]
                        ),
                      )

                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address", style: TextStyle(
                                color: Color.fromRGBO(118, 118, 118, 1),
                                fontSize: 18, fontWeight: FontWeight.w800),),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 15.0,bottom: 15.0,right: 10.0,left: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                          color: Colors.white54,
                                          width: 0.5,
                                          style: BorderStyle.solid
                                  )
                              ),
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text("${configAddressBookController.addressBook[index]["address"]}",
                                style: TextStyle(color: Colors.white ,fontSize: 18,fontWeight: FontWeight.w600),),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("ProxyPay",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 18),),
                              Container(
                                child: Switch(
                                  //来初始化此 Switch 是否被选中。true 表示选中 ，false 表示不选中
                                  value: configAddressBookController
                                      .addressBook[index]["openState"],
                                  //当 拖动改变状态时的回调。
                                  onChanged: _changed,
                                  //当 value 是 true 时 滑块的颜色。也就是开的状态时的颜色
                                  activeColor: Colors.white,
                                  // 当 value 是 true 时 滑道的颜色
                                  activeTrackColor: Colors.blueAccent,
                                  // 当 value 是 true 时 滑块上的图片。 如果 activeColor 也设置了  ， 以 activeThumbImage 为准
                                  // 如果设置的是网络图片的话。当 滑块 滑到这里 才开始加载。所以 没加载出图片的之前 ，以 activeColor 为准

                                  // 当 value 是 false 时 滑块的颜色。也就是开的状态时的颜色
                                  inactiveThumbColor: Colors.white,
                                  // 当 value 是 false 时 滑道的颜色
                                  inactiveTrackColor: Color.fromRGBO(
                                      58, 58, 58, 1),
                                  // 当 value 是 false 时 滑块上的图片。 如果 inactiveThumbColor 也设置了  ， 以 inactiveThumbImage 为准
                                ),
                              )
                            ],
                          ),
                        ),
                        configAddressBookController
                            .addressBook[index]["openState"] ?
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              configAddressBookController
                                  .addressBook[index]["proxyPayTotal"] >
                                  0 ?
                              Text(
                                "${configAddressBookController
                                    .addressBook[index]["proxyPayUsageCount"]}/${configAddressBookController
                                    .addressBook[index]["proxyPayTotal"]}",
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        63, 88, 172, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ) :
                              Text(
                                "Unlimited", style: TextStyle(
                                  color: Color.fromRGBO(63, 88, 172, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () =>
                                {
                                  Get.bottomSheet(
                                    LimitsTokenState(),
                                    isScrollControlled: true,
                                  )
                                },
                                child: Text(
                                    configAddressBookController
                                        .addressBook[index]["proxyPayTotal"] >
                                        0
                                        ? "Set a limit"
                                        : "Cancel limits",
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            63, 88, 172, 1),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty
                                      .all(
                                      Size(1, 1)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  //去除阴影
                                  overlayColor: MaterialStateProperty
                                      .all(
                                      Colors.transparent),
                                  //去掉inkwell的点击效果
                                ),
                              )
                            ],
                          ),
                        )
                            : Container(),

                      ],
                    ),
                  ),

                ],
              )

          )
      );
  }
    );



  }
}

class LimitsTokenState extends StatefulWidget {
  const LimitsTokenState({super.key});

  @override
  State<LimitsTokenState> createState() => LimitsToken();
}

class LimitsToken extends State<LimitsTokenState>{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  late TextEditingController _controller;
  late int index;


  @override
  void initState() {
    _controller = new TextEditingController(text: '');
    index = configAddressBookController.addressBookIndex.value;
    super.initState();
  }

  void _setLimit() {
    if(_controller.text !=""){
      List addressBook = configAddressBookController.addressBook;
      List copyList = List.from(addressBook);
      //深拷贝
      configAddressBookController.setAddressBookProxyPayUsageCount(index,0);
      configAddressBookController.setAddressBookProxyPayTotal(index,int.parse(_controller.text));

      Navigator.pop(context);
      print("${ configAddressBookController.addressBook}");
    }
  }

  @override
  Widget build(BuildContext context){
    return
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
              child:
                  ClipRect(
                    child: Container(
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
                                    "Set a limit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:20,
                                        fontStyle: FontStyle.normal
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: _setLimit,
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
                                    child:
                                    Text(
                                      'Confirm',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,

                                        //    字体加粗
                                      ),
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
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: TextField(
                                    autocorrect: true,
                                    controller: _controller,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    cursorColor: Colors.white54,
                                    maxLength: 3,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      // RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                                    ],
                                    decoration: InputDecoration(
                                      counterText: "",
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
                                            color: Colors.white60,
                                            width: 1,
                                          )),
                                      hintText: "quantily",
                                      hintStyle: TextStyle(
                                          color: Colors.white70
                                      ),
                                    ),
                                  ),
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
                                    onPressed: _setLimit,
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
                                      'Confirm',
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
            )
        ),
      );

  }
}

class EditTokenState extends StatefulWidget {
  const EditTokenState({super.key});

  @override
  State<EditTokenState> createState() => EditToken();
}

class EditToken extends State<EditTokenState>{
  final configAddressBookController = Get.put(ConfigAddressBookController());
  final addressText = TextEditingController();
  late  int index;
  late TextEditingController _controller;
  late TextEditingController _addressText;


  @override
  void initState() {
    index = configAddressBookController.addressBookIndex.value;
    _controller = new TextEditingController(text: '${configAddressBookController.addressBook[index]["name"]}');
    _addressText =new TextEditingController(text: "${configAddressBookController.addressBook[index]["address"]}");
    super.initState();
  }
  void edit(){
    if(configAddressBookController.addressBook[index]["address"] ==_addressText ||
        configAddressBookController.addressBook[index]["name"]==_addressText){
        Navigator.pop(context);
    }
    else{
      // List addressBook = configAddressBookController.addressBook;
      // List copyList = List.from(addressBook);
      // configAddressBookController.setAddressBookInfo(0,"xxx","david");
      configAddressBookController.setAddressBookName(index,_controller.text);
      configAddressBookController.setAddressBookAddress(index,_addressText.text);
      configAddressBookController.setAddressBookOpenState(index,false);
      configAddressBookController.setAddressBookProxyPayUsageCount(index,0);
      configAddressBookController.setAddressBookProxyPayTotal(index,0);
      print(configAddressBookController.addressBook);
      Navigator.pop(context);
    }


  }
  @override
  Widget build(BuildContext context){
    return
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
                child:
                ClipRect(
                  child: Container(
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
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:20,
                                      fontStyle: FontStyle.normal
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: edit,
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
                                  child:
                                  Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,

                                      //    字体加粗
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
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
                                              padding: EdgeInsets.all(20),
                                              decoration:BoxDecoration(
                                                color: Color.fromRGBO(29, 29, 29, 1),
                                                borderRadius: BorderRadius.circular(50.0),

                                              ),
                                              child:Icon(Icons.edit_calendar_outlined,
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
                                              controller: _addressText,
                                              keyboardType: TextInputType.text,
                                              maxLines:1,
                                              cursorColor: Colors.white54,
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),

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
                                            onPressed: edit,
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


                      ],
                    ),

                  ),
                )
            )
        ),
      );

  }
}

class RegexUtil {
  /// 正则匹配第一个输入字符不能为空格
  static const String regexFirstNotNull = r'/^[1-9]\d*$/';
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



