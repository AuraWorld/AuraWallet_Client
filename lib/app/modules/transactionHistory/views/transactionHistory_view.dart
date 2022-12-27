import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../collection/controllers/collection_controller.dart';
import '../../components/color/color.dart';
import '../controllers/test_controller.dart';


class TransactionHistoryView extends GetView<CollectionController> {
   TransactionHistoryView({Key? key}) : super(key: key);
  final state = Get.arguments["state"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${state}'),
        centerTitle: true,
        flexibleSpace:ColorView(),
      ),
      body: TransactionHistoryViewInfoState(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class TransactionHistoryViewInfoState extends StatefulWidget {
   TransactionHistoryViewInfoState({super.key});

  @override
  State<TransactionHistoryViewInfoState> createState() => TransactionHistoryViewInfo();
}

class TransactionHistoryViewInfo extends State<TransactionHistoryViewInfoState> {
  final tokenName = Get.arguments["tokenName"];
  final img = Get.arguments["img"];
  final amount = Get.arguments["amount"];
  final time = Get.arguments["time"];
  final address = Get.arguments["address"];
  final rise = Get.arguments["rise"];
  final hash = Get.arguments["hash"];
  final transactionHistoryController = Get.put(TransactionHistoryController());
  @override

  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }


  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      setState(() {
        print('Unable to launch url $url');
      });
    }
  }
  Widget build(BuildContext context){

    return Container(
        padding:  EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 60.0),
        child:Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                    child:Container(
                      decoration:BoxDecoration(
                          // border: Border.all(
                          //     color: Color.fromRGBO(97, 121, 245, 1)
                          // ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:Image.asset(
                        'assets/images/${img}.png',
                        width: 65,),
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0,bottom: 30.0),
                  child:
                  Center(
                    child:
                  rise == "true"?
                    Text(
                      "+${amount} ${tokenName}",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.green[400],
                          fontWeight: FontWeight.w700
                      ),
                    ) :
                  Text(
                    "-${amount} ${tokenName}",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0,right: 15.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(29, 29, 29, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:15.0,bottom: 15.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(53, 53, 53, 1),
                            ),
                          )
                        ),
                        child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600,
                              ),),
                            Text("${time}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:15.0,bottom: 15.0),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(53, 53, 53, 1),
                              ),
                            )
                        ),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("State",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600,
                              ),),
                            Text("已完成",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.green[500],
                                fontWeight: FontWeight.w600,
                              ),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:15.0,bottom: 15.0),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(53, 53, 53, 1),
                              ),
                            )
                        ),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reach",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600,
                              ),),
                            Text("${address}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top:15.0,bottom: 15.0),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Network Cost",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600,
                              ),),
                            Text("0.005 W3G",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // gradient:  LinearGradient(colors: [
                //   Color.fromRGBO(97, 121, 245, 1),
                //   Color.fromRGBO(153, 92, 231, 1),
                // ]),渐变
                color:  Color.fromRGBO(59, 99, 237, 1),
              ),
              child: ElevatedButton(
                onPressed: (){
                  var url = "${hash}";
                  _launchUrl(url);
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
                    'View on W3G',
                    style: TextStyle(
                        fontSize: 17,
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
