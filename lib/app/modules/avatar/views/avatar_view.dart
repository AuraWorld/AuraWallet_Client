import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../../home/views/home_view.dart';
import '../../token/controllers/token_controller.dart';
import '../../transactionAnimation/controllers/transactionAnimation_controller.dart';
import '../../transactionAnimation/views/transactionAnimation_view.dart';
import '../controllers/avatar_controller.dart';


class AvatarInfoView extends GetView<AvatarInfoController> {
  AvatarInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Change your NFT avatar"),
        centerTitle: true,
        flexibleSpace:  ColorView(),
      ),
      body: AvatarViewInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class AvatarViewInfo extends StatelessWidget {

  final title = Get.arguments["title"];

  final configController = Get.put(ConfigController());
  final List<Map<String, dynamic>> _list = [

    {
      "title":"1",
      "img":"https://img.seadn.io/files/22e01765d5c0f9b082200af01ec55c14.png?fit=max&w=1000",
    },
    {
      "title":"2",
      "img":"https://img.seadn.io/files/e66a9b83b5f11b70daa30309dd2e0c2c.png?fit=max&w=1000",
    },
    {
      "title":"3",
      "img":"https://img.seadn.io/files/d733b2552fff86ff8c26aa7b96e908db.png?fit=max&w=1000",
    },
    {
      "title":"4",
      "img":"https://img.seadn.io/files/4b756b1d46957956802b28846ea00111.png?fit=max&w=1000",
    },
    {
      "title":"5",
      "img":"https://img.seadn.io/files/e2e5d215f70e7798a010ef9cef15e066.png?fit=max&w=1000",
    },
    {
      "title":"6",
      "img":"https://img.seadn.io/files/de14683fc8c0b94d589938fc13c198e9.png?fit=max&w=1000",
    },
  ];
  @override

  Widget build(BuildContext context){
    List<Widget> _NFT(){
      return _list.map((item) =>
          GetX<ConfigController>(
              builder: (ConfigController) {
                return
          Container(
              child:
              TextButton(
                  onPressed: ()=>{
                    Get.bottomSheet(
                      StateAvatarInfo(img: item['img']),
                      isScrollControlled: true,
                    )
                  },
                  child:
                  configController.walletInfo.value[configController.walletIndex.value]["nft"] == item['img']?
                  ClipRRect(
                    //圆角
                      child:
                      Container(
                        decoration: BoxDecoration(
                            border:  Border.all(color: Color(0xFFFFFF00), width: 2),
                            borderRadius: new BorderRadius.circular((5.0))
                        ),
                        child: Image.network(
                          item['img'],
                        ),
                      )
                  )
                  :
                  ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
              //圆角
              child:
              Container(
                child: Image.network(
                  item['img'],
                ),
              )
          ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    //去掉inkwell的点击效果
                  )
              )

          );
              }
          )
      ).toList();
    }

    return Container(
        padding:  EdgeInsets.only(bottom: 60.0,top: 30.0),
        margin: EdgeInsets.only(left:10.0,right:10.0),
        child:Column(
          children: [
            Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                            child: Column(
                              children: [
                                GetX<ConfigController>(
                                    builder: (ConfigController) {
                                      return
                                        Container(
                                          child:  ClipRRect(
                                            borderRadius:BorderRadius.circular(10),
                                            child: Image.network(
                                              "${configController.walletInfo.value[configController.walletIndex.value]["nft"]}",
                                              height: 200,
                                            ),

                                          ),
                                        );
                                    }
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                    child:  Text("${title}",
                                      style: TextStyle(
                                          color: Color.fromRGBO(118, 118, 118, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      ),)
                                )
                              ],
                            ),
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your NFTs",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(118, 118, 118, 1),
                              ),
                              textAlign: TextAlign.start,
                            ),

                          ],
                        ),
                      )],
                  ),
                ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.only(top:10.0,bottom: 10.0),
              child:GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2
                  ),
                  children: _NFT()
              ),
            ),

          ],
        )

    );
  }
}

class StateAvatarInfo extends StatelessWidget {
  final  img;

  StateAvatarInfo({Key? key, this.img}) : super(key: key);

  final configController = Get.put(ConfigController());


  @override


  Widget build(BuildContext context){


    return Container(
        margin: EdgeInsets.only(top: 60.0),
        height:  MediaQuery.of(context).size.height,
        width: double.infinity,
        child:
        ClipRect(
          child:  BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,20.0),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Color.fromRGBO(21, 21, 21, 1)
                ),
                //毛玻璃效果
                child:
                Opacity(
                  opacity: 1,
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
                              IconButton(
                                icon:Icon(Icons.chevron_left,
                                  size: 30,),
                                color: Colors.white,

                                onPressed: () => Navigator.pop(context),
                              ),
                              Text(
                                "Change your NFT avatar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:20,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: TextButton(
                                    onPressed: ()=>{

                                      configController.setNFTImg(img),
                                      // Navigator.pop(context),
                                      Get.offAll(HomeView()),
                                    },
                                    child:Text( "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700
                                      ),)

                                ),
                              )

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
                                      margin: EdgeInsets.only(top: 50),
                                      child:  ClipRRect(
                                        borderRadius:BorderRadius.circular(10),
                                        child: Image.network(
                                          img,
                                          height: 200,
                                        ),

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
                                    configController.setNFTImg(img),
                                    // Navigator.pop(context),
                                    Get.offAll(HomeView())
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
                                  Text('Save',
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
                  ),
                ),
              )
          ),
        )
    );
  }
}


