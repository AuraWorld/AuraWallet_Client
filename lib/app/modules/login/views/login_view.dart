import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../components/color/color.dart';
import '../../home/views/home_view.dart';
import '../../introduction/views/introduction_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [  Color.fromRGBO(19 ,28, 62, 1),Color.fromRGBO(21 ,21 ,21, 1),],
                begin: Alignment.bottomCenter, end: Alignment.topCenter),
          )
        ),
        elevation: 0,

      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: LoginInfoView(),
    );
  }
}

class LoginInfoView extends StatefulWidget {
  @override
  LoginInfoState createState() => LoginInfoState();
}

class LoginInfoState extends State<LoginInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 20.0,bottom: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [  Color.fromRGBO(21 ,21 ,21, 1),Color.fromRGBO(19 ,28, 62, 1),],
              begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo.png",),
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
               Get.off(IntroductionView(),transition: Transition.fadeIn,
                   duration: Duration(milliseconds: 1000))
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
