import 'package:dio/dio.dart';
import 'package:get/get.dart';



class LoginController extends GetxController {

  final isSucc  = false.obs;
  void SendEmail (email) async {
    var dio = Dio();
    final response =  await dio.post('https://wallet-dev-restful-api.web3games.org/SendEmail', data: {"email":"${email}"});
    // return response.data['isSucc'];
    // print(response.data);
    // print("My name is $Email");
  }
}
