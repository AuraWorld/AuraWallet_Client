import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../ApiData/NftListModels/NftList.dart';
import '../../components/color/color.dart';
import '../../config/controllers/config_controller.dart';
import '../controllers/collection_controller.dart';

class CollectionView extends GetView<CollectionController> {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Collection'),
        centerTitle: true,
        flexibleSpace: ColorView(),
      ),
      body: CollectionViewState(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class CollectionViewState extends StatefulWidget {
  CollectionViewState({Key? key}) : super(key: key);

  @override

  CollectionViewInfo createState() => CollectionViewInfo();

}

class CollectionViewInfo extends State<CollectionViewState> {
  final controller = Get.put(ConfigController());
  final collectionController = Get.put(CollectionController());
  final box = GetStorage();
  late List  _list;

  var dio = Dio();

  void initState() {
    _query();
    print(collectionController.NftList.value);
    super.initState();
  }

  Future<void> _query() async {
    collectionController.GetUserNftList(controller.walletInfo.value[controller.walletIndex.value]["address"]);
    setState(() {
      _list =  collectionController.NftList.value;
    });
  }
  // void initState() {
  //   void GetUserNftList (address) async {
  //
  //     final response = await dio.post('https://wallet-dev-restful-api.web3games.org/GetUserNftList',
  //         data: {"address": "xx"});
  //     final data = jsonDecode(response.data["res"]["nft_list_info"]);
  //     // print(data[0].a)
  //     _list = data as List;
  //     print("-----------------------------$data");
  //   }
  //   GetUserNftList("xxx");
  //   super.initState();
  // }

  @override

  Widget build(BuildContext context){

     _weiGuo(){

      return _list.asMap().keys.map((f) =>
      GetX<CollectionController>(
          builder: (collectionController) {
            return
              Container(
                  child: TextButton(
                      onPressed: () =>
                      {
                        // print("${ json.decode(item["metadata"])["Grade"]}"),
                        Get.toNamed("/NFTInfo", arguments: {
                          "img": "${collectionController.NftList[f]["img"]}",
                          "title": "${collectionController.NftList[f]["title"]}",
                          "describe": "${json.decode(
                              collectionController.NftList[f]["metadata"])["describe"]}",
                          "Grade": "${json.decode(collectionController.NftList[f]["metadata"])["Grade"]}",
                          "color": "${json.decode(collectionController.NftList[f]["metadata"])["color"]}",
                          "style": "${json.decode(collectionController.NftList[f]["metadata"])["style"]}",
                        })
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            //圆角
                            child: Image.network(
                              collectionController.NftList[f]['img'],
                            ),
                          ),
                          Positioned(
                            child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 2.0, sigmaY: 2.0),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5.0, left: 15.0, right: 15.0),
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 2.0, 10.0, 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.white24
                                    ),
                                    //毛玻璃效果
                                    child: Opacity(
                                      opacity: 1,
                                      child: Text(
                                          collectionController.NftList[f]['title'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                )

                            ),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Colors.transparent),
                        //去掉inkwell的点击效果
                      )
                  )
              );
          })
      ).toList();
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: double.infinity,
      // h-full
      // mx-auto
      child:

      GridView(
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         mainAxisSpacing: 5,
         crossAxisSpacing: 5
       ),
        children: _weiGuo()
      )
    );
  }
}

