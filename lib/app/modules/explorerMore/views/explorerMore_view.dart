import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/explorerMore_controller.dart';

class ExplorerMoreView extends GetView<ExplorerMoreController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("See More"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        elevation: 0,

      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: TokenViewInfo(),
    );
  }
}


class TokenViewInfo extends StatelessWidget {

  @override
  final List<Map<String, dynamic>> _list = [
    {
      "img":"icon-1024x1024",
      "title":"Favorite Items",
     },
    {
      "img":"icon-1024x1024",
      "title":"Browse History",
    },



  ];

  List<Widget> _Tokenlist(context){
    return _list.map((item) =>
        TextButton(onPressed: ()=>{
          // controller.tokenName(item["title"]),
          Get.toNamed("/explorer_Info",arguments: {"title":"${item["title"]}"})
        },
            child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color.fromRGBO(49, 49, 49, 1)
                ),
                child: // token logo + token name + token number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Color.fromRGBO(109, 109, 109, 1),width: 0.5)
                          ),
                          child:  ClipRRect(
                              borderRadius:BorderRadius.circular(10),
                              child: Image.asset('assets/images/${item["img"]}.png',height: 60,)
                          ),
                        ),
                        Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.72,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child:  Text(
                                            "${item["title"]}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                      ],
                    ),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //去掉inkwell的点击效果
            ))

    ).toList();
  }

  Widget build(BuildContext context){
    return
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child:
      Container(
        padding: const EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0),
        child:
        Wrap(
            children: _Tokenlist(context)
        ),

      )
      );
  }

}




