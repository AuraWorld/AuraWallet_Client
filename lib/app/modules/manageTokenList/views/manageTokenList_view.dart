import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../token/controllers/token_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/manageTokenList_controller.dart';



class ManageTokenListInfoView extends StatefulWidget {
  ManageTokenListInfoView({Key? key}) : super(key: key);

  @override

  Token_InfoView createState() => Token_InfoView();

}

class Token_InfoView extends State<ManageTokenListInfoView> {

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Manage token list"),
        centerTitle: true,
        flexibleSpace: ColorView(),
        elevation: 0,
          actions: [
          IconButton(onPressed: ()=>{
            Get.toNamed("addTokenList")
          },
              icon: Icon(Icons.add, color: Colors.white, size: 30.0,),)
          ],
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: ManageTokenListInfoState(),

    );
  }
}
class ManageTokenListInfoState extends StatefulWidget {
  ManageTokenListInfoState ({Key? key}) : super(key: key);

  @override

  ManageTokenListInfo  createState() => ManageTokenListInfo();

}

class ManageTokenListInfo extends State<ManageTokenListInfoState> {
  final manageTokenListController = Get.put(ManageTokenListController());

  @override
  void initState() {
    super.initState();
    print(manageTokenListController.tokenList.value);
    // _isCheck = false;
  }

  List<Widget> _Token(){
    return manageTokenListController.tokenList.asMap().keys.map((f) =>
        GetX<ManageTokenListController>(
            builder: (ManageTokenListController) {
              return
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color.fromRGBO(34, 34, 34, 1)
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // token logo + token name + token number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 40,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  // border: Border.all(color: const Color(0xFFFF0000), width: 0.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)),
                                ),
                                child: Image.asset(
                                    'assets/images/${manageTokenListController
                                        .tokenList.value[f]["title"]}.png')
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                   '${manageTokenListController.tokenList.value[f]['title']}' ,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white

                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${manageTokenListController.tokenList.value[f]["amount"]} ${manageTokenListController.tokenList
                                        .value[f]["title"]}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                        Switch(
                          //??????????????? Switch ??????????????????true ???????????? ???false ???????????????
                          value: manageTokenListController.tokenList.value[f]["showState"] as bool,
                          //??? ?????????????????????????????????
                          onChanged: (isCheck){
                            setState(() {
                              manageTokenListController.setTokenListShowState(f,isCheck);
                              print(manageTokenListController.tokenList);
                            });
                          },
                          //??? value ??? true ??? ???????????????????????????????????????????????????
                          activeColor: Colors.white,
                          // ??? value ??? true ??? ???????????????
                          activeTrackColor: Colors.blueAccent,
                          // ??? value ??? true ??? ????????????????????? ?????? activeColor ????????????  ??? ??? activeThumbImage ??????
                          // ?????????????????????????????????????????? ?????? ???????????? ???????????????????????? ??????????????????????????? ?????? activeColor ??????

                          // ??? value ??? false ??? ???????????????????????????????????????????????????
                          inactiveThumbColor: Colors.white,
                          // ??? value ??? false ??? ???????????????
                          inactiveTrackColor: Color.fromRGBO(
                              58, 58, 58, 1),
                          // ??? value ??? false ??? ????????????????????? ?????? inactiveThumbColor ????????????  ??? ??? inactiveThumbImage ??????
                        ),
                      ],
                    )
                );
            })
    ).toList();
  }


  Widget build(BuildContext context){
    return   SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        // top content
        Container(
          padding: const EdgeInsets.all(10.0),
          // decoration:BoxDecoration(
          //   border: Border.all(
          //     color: Colors.red,
          //   ),
          // ),

        ),
        GetX<ManageTokenListController>(
            builder: (ManageTokenListController) {
              return
                manageTokenListController.tokenList.length == 0 ?
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: TextButton(
                        onPressed: ()=>{},
                        child: Text("Add Token",style: TextStyle(
                          color: Colors.white54,fontSize: 20,
                        ),),
                        style: ButtonStyle(
                          //????????????

                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                        ),),

                    )
                )
                    :
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0,right: 10.0),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.white54,
                            width: 1

                        ),
                      ),
                      child: (
                          TextField(
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.white54,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              ),
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              ),
                              prefixIcon: Icon(Icons.search,
                                color: Colors.white54,
                                size: 32,),
                            ),

                          )),),
                    Container(
                      margin: EdgeInsets.only(left: 10.0,top:10.0,right: 10.0),
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                            runSpacing: 10.0,
                            runAlignment:WrapAlignment.start,
                            children: _Token()
                        ),
                      ),

                    )],
                );
            }
        )


      ],
    )
    );
  }
}



