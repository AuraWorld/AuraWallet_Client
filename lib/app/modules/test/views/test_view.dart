import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import '../../collection/controllers/collection_controller.dart';
import '../../components/color/color.dart';

class Test extends GetView<CollectionController> {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5Eeh...ruhb'),
        centerTitle: true,
        flexibleSpace: ColorView(),
      ),
      body: CollectionViewInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class CollectionViewInfo extends StatelessWidget {

  final title = Get.arguments["title"];
  final img = Get.arguments["img"];


  final List<Map<String, dynamic>> _list = [
    {
      "title" :"${Get.arguments["title"]}",
      "img" : "${Get.arguments["img"]}"
     }
  ];

  @override

  Widget build(BuildContext context){
    Container _content(){
      return
        Container(
                child: Center(
                  child:
                    Container(
                      width: 310,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child:  ClipRRect(
                              borderRadius:BorderRadius.circular(10),
                              child: Image.network(
                                img,
                              ),
                            ),
                          ),
                          //圆角
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                            width: double.infinity,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.white10
                            ),
                            child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                            ),
                          )
                        ],

                      ),
                    )
                ),

          );
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      // h-full
      // mx-auto
        child:Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: _content()
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
                },
                style: ButtonStyle(
                  //去除阴影
                    elevation: MaterialStateProperty.all(0),
                    //将按钮背景设置为透明
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    splashFactory: NoSplash.splashFactory
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
            )
          ],
        )

    );
  }
}
