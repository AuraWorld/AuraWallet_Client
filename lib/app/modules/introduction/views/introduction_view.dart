import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../components/color/color.dart';
import '../../home/views/home_view.dart';
import '../../loginMethod/views/loginMethod_view.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                 Color.fromRGBO(19 ,28, 62, 1), Color.fromRGBO(21 ,21 ,21, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: PageViewDemo(),
    );
  }
}

class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("Aura Wallet",style: TextStyle(color: Color.fromRGBO(56, 77, 149, 1),fontSize: 24,fontWeight: FontWeight.w800),),
            Container(
                margin: EdgeInsets.only(top:13,left: 50,right: 50),
                child:   Text("Welcome to Aura Wallet",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
                margin: EdgeInsets.only(top:13,left:20,right: 20),
                child:   Text("Aura Wallet is a secure wallet that allows everyone to enter the Web3 world.",
                  style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child:  Image.asset('assets/images/page1.png',
                width: 300, height: 300,),
            )
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 100),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ],
            )
        )


      ],
    );
  }

}
class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("Aura Wallet",style: TextStyle(color:Color.fromRGBO(56, 77, 149,1),fontSize: 24,fontWeight: FontWeight.w800),),
            Container(
                margin: EdgeInsets.only(top:13,left: 80,right: 80),
                child:   Text("Manage your Digital Assets",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
                margin: EdgeInsets.only(top:13,left:20,right: 20),
                child:   Text("Store, spend and send digital assets such as tokens, Ether, and unique collections.",
                  style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child:  Image.asset('assets/images/page2.png',
                width: 300, height: 300,),
            )
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 100),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ],
            )
        )


      ],
    );

  }

}
class Page3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("Aura Wallet",style: TextStyle(color: Color.fromRGBO(56, 77, 149,1),fontSize: 24,fontWeight: FontWeight.w800),),
            Container(
                margin: EdgeInsets.only(top:13,left: 80,right: 80),
                child:   Text("Your portal to Web3",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
                margin: EdgeInsets.only(top:13,left:20,right: 20),
                child:   Text("Use Aura Wallet to log in and trade, so as to invest, make money, play games, sell, etc.",
                  style: TextStyle(color: Color.fromRGBO(118, 118, 118, 1),fontSize: 16,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,)
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child:  Image.asset('assets/images/page3.png',
                width: 300, height: 300,),
            )
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 100),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(124, 124, 124, 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ],
            )
        )


      ],
    );

  }

}


class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _pageIndex,
      viewportFraction: 1.0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 20.0,bottom: 80.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),),
        child:  PageView(
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            _pageIndex = index;
          },
          controller: _pageController,
          allowImplicitScrolling: false,
          padEnds: false,
          reverse: false,
          children:  [
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
      ),

      floatingActionButton:
      Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(bottom: 45.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:  Color.fromRGBO(59, 99, 237, 1),
                ),
                child:
                ElevatedButton(
                  onPressed: ()=>{
                    // Navigator.of(context).push(_createRoute())
                    Get.to(LoginMethodView(),transition: Transition.fadeIn, duration: Duration(milliseconds: 1000))
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
                    'Getting Started',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w800
                      //    字体加粗
                    ),
                  ),
                )

            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}