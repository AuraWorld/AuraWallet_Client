import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../home/views/home_view.dart';
import '../../manageTokenList/controllers/manageTokenList_controller.dart';
import '../../token/controllers/token_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/addTokenList_controller.dart';



class AddTokenListInfoView extends StatefulWidget {
  AddTokenListInfoView({Key? key}) : super(key: key);

  @override

  AddTokenListView createState() => AddTokenListView();

}

class AddTokenListView extends State<AddTokenListInfoView> {

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add Tokens"),
        centerTitle: true,
        flexibleSpace: ColorView(),
        elevation: 0,
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: AddTokenListInfoState(),

    );
  }
}


class AddTokenListInfoState extends StatefulWidget {
  AddTokenListInfoState ({Key? key}) : super(key: key);

  @override

  AddTokenListInfo  createState() => AddTokenListInfo();

}

class AddTokenListInfo extends State<AddTokenListInfoState>{
  final manageTokenListController = Get.put(ManageTokenListController());
  var dio = Dio();
  late TextEditingController _address;
  late TextEditingController _name;
  late TextEditingController _decimals;
  late TextEditingController _title;
  late TextEditingController _fungible_token_Id;
  bool _connecting = false;
  @override
  void initState() {
    _address = new TextEditingController(text: '');
    _name = new TextEditingController(text: '');
    _decimals = new TextEditingController(text: '');
    _title = new TextEditingController(text: '');
    _fungible_token_Id = new TextEditingController(text: '');
    super.initState();
  }
  void  onChangeAddress() async {

      setState(() {
        _connecting = true;
      });
      final response = await dio.post('https://wallet-dev-restful-api.web3games.org/GetTokenInfo',
          data: {"fungible_token_Id": "${_address.text}"});

      if((response.data["isSucc"])){
        final data = json.decode(response.data["res"]["token_info"]);
        _name.text ="${data["name"]}";
        _title.text = "${data["symbol"]}";
        _decimals.text ="${data["decimals"]}";

      }else{
          _name.text ="";
          _title.text = "";
          _decimals.text ="";
          _fungible_token_Id.text ="";
        }
      setState(() {
        _connecting = false;
      });

  }
  //默认值
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   addressText.dispose();
  //   super.dispose();
  // }
  //输入值


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
                              controller: _address,
                              keyboardType: TextInputType.text,
                              // onChanged:onChangeAddress,
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
                                hintText: "Casting address",
                                hintStyle: TextStyle(
                                    color: Colors.white70
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30.0),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color:  Colors.white60,
                                      width: 1

                                  ),
                                ),
                              child:    TextField(
                                enabled: false,
                                controller: _name,
                                autocorrect: true,
                                cursorColor: Colors.white54,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Colors.white70
                                  ),
                                ),

                              )
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 30.0),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.white60,
                                      width: 1

                                  ),
                                ),
                                child:    TextField(
                                  enabled: false,
                                  controller: _decimals,
                                  autocorrect: true,
                                  cursorColor: Colors.white54,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    hintText: "Token Symbol",
                                    hintStyle: TextStyle(
                                        color: Colors.white70
                                    ),
                                  ),

                                )
                            ),
                            Opacity(opacity: 0.0,
                            child:     Container(
                                margin: EdgeInsets.only(top: 30.0),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.white60,
                                      width: 1

                                  ),
                                ),
                                child:    TextField(
                                  enabled: false,
                                  controller: _title,
                                  autocorrect: true,
                                  cursorColor: Colors.white54,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    hintText: "Token Symbol",
                                    hintStyle: TextStyle(
                                        color: Colors.white70
                                    ),
                                  ),

                                )
                            ),
                            ),
                            Opacity(opacity: 0.0,
                              child:     Container(
                                  margin: EdgeInsets.only(top: 30.0),
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.white60,
                                        width: 1

                                    ),
                                  ),
                                  child:    TextField(
                                    enabled: false,
                                    controller: _fungible_token_Id,
                                    autocorrect: true,
                                    cursorColor: Colors.white54,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                      ),
                                      hintText: "fungible_token_Id",
                                      hintStyle: TextStyle(
                                          color: Colors.white70
                                      ),
                                    ),

                                  )
                              ),
                            )
                          ],
                        ),
                        Column(

                          children: [
                          _connecting?
                            Container(
                              width: 200,
                              //在此设置
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:  Color.fromRGBO(59, 99, 237, 1),
                              ),
                              child: ElevatedButton(
                                  onPressed: onChangeAddress,
                                  // Get.offAll(HomeView()),
                                  style: ButtonStyle(
                                    //去除阴影
                                    elevation: MaterialStateProperty.all(0),
                                    //将按钮背景设置为透明
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                child:
                                  CupertinoActivityIndicator(color: Colors.white,)
                              ),
                            ):
                            Container(
                            width: 200,
                            //在此设置
                            height: 50,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color:  Color.fromRGBO(59, 99, 237, 1),
                            ),
                            child: ElevatedButton(
                                onPressed: onChangeAddress,
                                  // Get.offAll(HomeView()),
                                style: ButtonStyle(
                                  //去除阴影
                                  elevation: MaterialStateProperty.all(0),
                                  //将按钮背景设置为透明
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                child:
                                Text('Search',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800
                                    //    字体加粗
                                  ),)
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
                                    if(_title.text == ""){
                                    }else{
                                      manageTokenListController.TokenList_add({"name":"${_name.text}","title":"${_title.text}","showState":true,"amount":"0","decimals":"${_decimals.text}","tokenID":"${_address.text}"}),
                                      print(manageTokenListController.tokenList),
                                      Get.back()
                                    }

                                    // Get.offAll(HomeView())
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
                                  Text('Perservation',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800
                                      //    字体加粗
                                    ),)
                              ),
                            ),
                          ],
                        )

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

class WorkSpace extends StatelessWidget {
  const WorkSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      child: SpinKitWave(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white
            ),
          );
        },
        size: 50.0,
      ),
    );
  }
}



