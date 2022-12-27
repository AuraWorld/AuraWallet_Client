import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CollectionController extends GetxController {
  final NftList = [].obs;
  final box = GetStorage();
  List get NFTLIST => NftList;
  var dio = Dio();
   void GetUserNftList (address) async {
     // box.erase();
    final response = await dio.post('https://wallet-dev-restful-api.web3games.org/GetUserNftList',
        data: {"address": "xx"});
    final data =  json.decode(response.data["res"]["nft_list_info"]);
    // print("-----------------------------$data");
    box.write('collection',data);
    NftList.value = box.read("collection");

    print("222312312312312312312312312${NftList.value}");
    // NftList.value = data;
    // NftList.value = data;
    NftList.refresh();

  }
}
