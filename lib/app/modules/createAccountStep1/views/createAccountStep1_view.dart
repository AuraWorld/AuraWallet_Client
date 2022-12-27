import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../components/color/color.dart';
import '../../home/views/home_view.dart';

import '../../login/controllers/login_controller.dart';
import '../controllers/createAccountStep1_controller.dart';


class CreateAccountStep1View extends GetView<CreateAccountStep1Controller> {
  const CreateAccountStep1View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Container(
              width: 160,
              child:  Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 2,bottom:2,right: 7,left: 7),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(59, 99, 237, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800
                        ),)
                  ),
                  Text("-----------",style: TextStyle(
                      color: Colors.white54
                  ),),
                  Container(
                      padding: EdgeInsets.only(top: 2,bottom:2,right: 7,left: 7),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(135, 135, 135, 1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: Text("2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800
                        ),)
                  ),
                ],),
            ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(19 ,28, 62, 1),  Color.fromRGBO(21 ,21 ,21, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: CreateAccountStep1InfoView(),
    );
  }
}

class StringUtil {

  // 邮箱判断
  static bool isEmail(String input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    if (input == null || input.isEmpty){
      return false;
    }else{
      return new RegExp(regexEmail).hasMatch(input);
    }



  }

  // 纯数字
  static final String DIGIT_REGEX = "[0-9]+";

  // 含有数字
  static final String CONTAIN_DIGIT_REGEX = ".*[0-9].*";

  // 纯字母
  static final String LETTER_REGEX = "[a-zA-Z]+";

  // 包含字母
  static final String SMALL_CONTAIN_LETTER_REGEX = ".*[a-z].*";

  // 包含字母
  static final String BIG_CONTAIN_LETTER_REGEX = ".*[A-Z].*";

  // 包含字母
  static final String CONTAIN_LETTER_REGEX = ".*[a-zA-Z].*";

  // 纯中文
  static final String CHINESE_REGEX = "[\u4e00-\u9fa5]";

  // 仅仅包含字母和数字
  static final String LETTER_DIGIT_REGEX = "^[a-z0-9A-Z]+\$";
  static final String CHINESE_LETTER_REGEX = "([\u4e00-\u9fa5]+|[a-zA-Z]+)";
  static final String CHINESE_LETTER_DIGIT_REGEX =
      "^[a-z0-9A-Z\u4e00-\u9fa5]+\$";

  // 纯数字
  static bool isOnly(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(DIGIT_REGEX).hasMatch(input);
  }

  // 含有数字
  static bool hasDigit(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(CONTAIN_DIGIT_REGEX).hasMatch(input);
  }

  // 是否包含中文
  static bool isChinese(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(CHINESE_REGEX).hasMatch(input);
  }
}

class CreateAccountStep1InfoView extends StatefulWidget {
  @override
  CreateAccountStep1InfoState createState() => CreateAccountStep1InfoState();
}

class CreateAccountStep1InfoState extends State<CreateAccountStep1InfoView> {
  final configLoginController = Get.put(LoginController());
  TextEditingController _controller= new TextEditingController();
  bool checkInput = false;
  bool _connecting = false;

  void _checkInput(input){
    checkInput = StringUtil.isEmail(_controller.text);
  }
  Future<void> obtain <String> () async {
    if(checkInput){
      setState(() {
        _connecting = true;
      });
     var dio = Dio();
     final response  =  await  dio.post('https://wallet-dev-restful-api.web3games.org/SendEmail', data: {"email":"${_controller.text}"});
     if(response.data['isSucc']){
       setState(() {
         _connecting = false;
       });
       Get.toNamed("/createAccountStep2",arguments: {"email":"${_controller.text}"});
     }else{
       setState(() {
         _connecting = false;
       });
       BrnToast.show("Network Error", context);
     }
    }else{
      BrnToast.show("This is not an email", context);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                 Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80.0),
            child:   Column(
              children: [
                Text("Enter Email",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w600),),
                Container(
                  padding: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                  child:
                  Text("Enter the email to obtain the verification code to register your Aura Wallet on this device",style: TextStyle(fontSize: 19,color: Colors.white54),textAlign: TextAlign.center,),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40,right: 40.0,left: 40.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child:Text("Email",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),), ),

                      TextField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        onChanged: _checkInput,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(15), //边角为30
                            ),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15), //边角为30
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.5, //边线宽2
                              )),
                        ),
                      )
  
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:  Color.fromRGBO(59, 99, 237, 1),
            ),
            child: ElevatedButton(
              onPressed: obtain,
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child:  _connecting?
              CupertinoActivityIndicator(color: Colors.white,):
              const Text(
                'Obtain',
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
    );
  }
}


