import 'package:get/get.dart';

class NFTInfoController extends GetxController {
  final NFTName = "".obs;
  final NFTImg = "".obs;
  final NFTPrice = '0.00'.obs;

  final receivingAddress = "".obs;
  void setReceivingAddress(data) => receivingAddress.value = data;


  void setNFTPrice(data) =>NFTPrice.value = data;
  void setNFTName(data) => NFTName.value = data;
  void setNFTImg(data) => NFTImg.value = data;
}
