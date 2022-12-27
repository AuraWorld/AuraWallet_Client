import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polkawallet_sdk/api/types/addressIconData.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/keyringEVM.dart';
import '../../config/controllers/config_controller.dart';
import '../../configWallet/controllers/config_controller.dart';
import '../../createdSuccess/views/createdSuccess_view.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/createAccountStep2_controller.dart';


class CreateAccountStep2View extends GetView<CreateAccountStep2Controller> {

   CreateAccountStep2View({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Container(
              width: 160,
              child:  Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 2,bottom:2,right: 7,left: 7),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(59, 99, 237, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800
                        ),)
                  ),
                  Text("-----------",style: TextStyle(
                      color: Colors.white54
                  ),),
                  Container(
                      padding: EdgeInsets.only(top: 2.5,bottom:2.5,right: 6.8,left: 6.8),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(59, 99, 237, 1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: Text("2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800
                        ),)
                  ),
                ],),
            ),
        centerTitle: true,
        flexibleSpace:Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(19 ,28, 62, 1),  Color.fromRGBO(21 ,21 ,21, 1),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color.fromRGBO(21,21,21,1),
      body: CreateAccountStep2InfoView(),
    );
  }
}



class CreateAccountStep2InfoView extends StatefulWidget {

  @override
  CreateAccountStep2InfoState createState() => CreateAccountStep2InfoState();
}

class CreateAccountStep2InfoState extends State<CreateAccountStep2InfoView> {
  TextEditingController _controller= new TextEditingController();
  bool _connecting = false;
  bool _checkboxSelected = false;
  final configController = Get.put(ConfigController());
  final configWalletcontroller = Get.put(ConfigWalletController());
  final configLoginController = Get.put(LoginController());

  final email = Get.arguments["email"];
  final box = GetStorage();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromRGBO(59, 99, 237, 1);
    }
    return Color.fromRGBO(59, 99, 237, 1);
  }


  Future<void> _connectNode() async {
    if(_checkboxSelected){
    GetStorage().erase();
    setState(() {
      _connecting = true;
    });
    var dio = Dio();
    final response  =  await  dio.post('https://wallet-dev-restful-api.web3games.org/CheckEmail', data: {"email":email,"code": _controller.text,});
    print(response.data['res']['state']);
      if(response.data['res']['state']){

        // 登陆
        final sdk = WalletSDK();
        final Keyring keyring = Keyring();
        await keyring.init([0, 2]);
        final KeyringEVM keyringEVM = KeyringEVM();
        final api = await sdk.init(keyring, keyringEVM: keyringEVM);

        final node = NetworkParams();
        node.name = 'Web3Games';
        node.endpoint = 'wss://devnet.web3games.org/';
        node.ss58 = 42;

        final res = await sdk.api.connectNode(keyring, [node]);
        int ss58 = 42;
        final AddressIconDataWithMnemonic seed = await sdk.api.keyring.generateMnemonic(ss58);

        print(seed.mnemonic);

        configController.createAddress({
          "name":"Wallet${box.read('address')==null?"1":"${box.read('address').length+1}"}",
          "address":"${seed.address}",
          "mnemonic":"${seed.mnemonic}",
          "nft":"https://img.seadn.io/files/22e01765d5c0f9b082200af01ec55c14.png?fit=max&w=1000",
          "tokenList":[{"tokenID":"0","name":"Web3Games","title":"W3G","showState":true,"amount":"0","decimals":"18"}]
        });
        box.write("NetWork",  {
          "title":"Main Network Beta",
          "subtitle" :"Web3Games RPC Network"
        },);
        box.write("Explorer", "W3G Explorer");
          //初始化
        configController.addressIndex(0);
          setState(() {
            _connecting = false;
          });
        Get.offAll(CreatedSuccessView());

      }else{
        setState(() {
          _connecting = false;
        });
        BrnToast.show("Verification code error, please try again", context);
      }
    }else{
      BrnToast.show("Please agree to the terms and conditions", context);
    }


  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 80.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80.0),
            child:   Column(
              children: [
                Text("Enter Verification Code",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w600),),
                Container(
                  padding: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                  child:
                  Text("Enter the verification code obtained from your email to activate your Aura Wallet.",style: TextStyle(fontSize: 19,color: Colors.white54),textAlign: TextAlign.center,),
                ),

                Container(
                  padding: EdgeInsets.only(top: 40,right: 40.0,left: 40.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child:Text("Verification Code",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),), ),

                      TextField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(15), //边角为30
                            ),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15), //边角为30
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.5, //边线宽2
                              )),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _checkboxSelected,
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              onChanged:(value){
                                setState(() {
                                  _checkboxSelected=value!;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap ,
                            ),
                            Container(
                                transform: Matrix4.translationValues(-10.0, 4.0, 0.0),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child:Text("I understand the rules of Aura Wallet.",
                                      style: TextStyle(fontSize: 13,color: Colors.white),),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(0.0, -14.0, 0.0),
                                    child: TextButton(
                                        onPressed: ()=>{
                                        },
                                        child:
                                        Text("Learn more",
                                          style: TextStyle( color: Color.fromRGBO(59, 99, 237, 1),fontSize: 14,
                                            decoration: TextDecoration.underline,),
                                        )),
                                  )

                                ],
                              )
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:  Color.fromRGBO(59, 99, 237, 1),
            ),
            child: ElevatedButton(
              onPressed: _connectNode,
              // Get.offAll(CreatedSuccessView())
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child:
              _connecting?
              CupertinoActivityIndicator(color: Colors.white,):
              Text(
                'Obtain',
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
      ),
    );
  }
}


