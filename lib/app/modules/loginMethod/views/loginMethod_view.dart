import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../components/color/color.dart';
import '../../createAccountStep1/views/createAccountStep1_view.dart';
import '../../home/views/home_view.dart';
import '../../introduction/views/introduction_view.dart';
import '../controllers/loginMethod_controller.dart';

class LoginMethodView extends GetView<LoginMethodController> {
  const LoginMethodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aura Wallet",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w800),),
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
      body: LoginMethodInfoView(),
    );
  }
}

class LoginMethodInfoView extends StatefulWidget {
  @override
  LoginMethodInfoState createState() => LoginMethodInfoState();
}

class LoginMethodInfoState extends State<LoginMethodInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20.0,bottom: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [  Color.fromRGBO(19 ,28, 62, 1),Color.fromRGBO(21 ,21 ,21, 1),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
            child:   Column(
              children: [
                Text("Wallet Settings",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w600),),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child:
                  Text("Please register your wallet",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),),
                )
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
              onPressed: ()=>{
              // Navigator.of(context).push(_createRoute())
               Get.toNamed("/createAccountStep1")
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
                'Register Wallet',
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

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>  HomeView(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 3.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
