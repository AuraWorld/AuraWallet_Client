import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/configAbout_controller.dart';

class ConfigAboutView extends GetView<ConfigAboutController> {
  const ConfigAboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Wallet"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
      ),
      body:ConfigAboutInfo(),
      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class ConfigAboutInfo extends StatefulWidget {
  ConfigAboutInfo ({Key? key}) : super(key: key);

  @override

  ConfigAboutInfoView  createState() => ConfigAboutInfoView();

}

class ConfigAboutInfoView extends State<ConfigAboutInfo>{
  @override
  final Uri _toHelp = Uri.parse('https://aura-wallet-v2.vercel.app/');
  final Uri _toService = Uri.parse('https://aura-wallet-v2.vercel.app/');
  final Uri _toPolicy = Uri.parse('https://aura-wallet-v2.vercel.app/');
  final Uri _toWebsite = Uri.parse('https://aura-wallet-v2.vercel.app/');

  Future<void> _toHelpUrl() async {
    if (!await launchUrl(_toHelp)) {
      throw 'Could not launch $_toHelp';
    }
  }
  Future<void> _toServiceUrl() async {
    if (!await launchUrl(_toService)) {
      throw 'Could not launch $_toService';
    }
  }
  Future<void> _toPolicyUrl() async {
    if (!await launchUrl(_toPolicy)) {
      throw 'Could not launch $_toPolicy';
    }
  }
  Future<void> _toWebsiteUrl() async {
    if (!await launchUrl(_toWebsite)) {
      throw 'Could not launch $_toWebsite';
    }
  }


  Widget build(BuildContext context) {
  return
    Container(
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 30.0),

      child:Column(
        children: [
          Center(
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: 60,
                  child:  ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child:  Image.asset("assets/images/walletLogo.png",
                    ),
                  ),
                ),
                Text("Aura",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),),
                Text("Version 1.0.0 (2)",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.w800
                  ),)

              ],
            ),
          ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child:  Wrap(
                  runSpacing: 10.0,
                  children: [
                    Container(
                      padding:  EdgeInsets.all(4.0),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(29,29,29,1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: TextButton(onPressed:_toHelpUrl,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(

                                    child:  Column(
                                      children: [
                                        Text("Help & Support",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          ),)
                                      ],
                                    ) ,
                                  )
                                ],),

                              Icon(Icons.chevron_right,size: 28,color: Colors.white,)
                            ],
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            //去掉inkwell的点击效果
                          )),
                    ),
                    Container(
                      padding:  EdgeInsets.all(4.0),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(29,29,29,1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: TextButton(onPressed:_toServiceUrl,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(

                                    child:  Column(
                                      children: [
                                        Text("Terms of Service",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          ),)
                                      ],
                                    ) ,
                                  )
                                ],),

                              Icon(Icons.chevron_right,size: 28,color: Colors.white,)


                            ],
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            //去掉inkwell的点击效果
                          )),
                    ),
                    Container(
                      padding:  EdgeInsets.all(4.0),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(29,29,29,1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: TextButton(onPressed:_toPolicyUrl,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(

                                    child:  Column(
                                      children: [
                                        Text("Privacy Policy",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          ),)
                                      ],
                                    ) ,
                                  )
                                ],),

                              Icon(Icons.chevron_right,size: 28,color: Colors.white,)


                            ],
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            //去掉inkwell的点击效果
                          )),
                    ),
                    Container(
                      padding:  EdgeInsets.all(4.0),
                      decoration:BoxDecoration(
                        color: Color.fromRGBO(29,29,29,1),
                        borderRadius: BorderRadius.circular(10.0),

                      ),
                      child: TextButton(onPressed:_toWebsiteUrl,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(

                                    child:  Column(
                                      children: [
                                        Text("Visit Website",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          ),)
                                      ],
                                    ) ,
                                  )
                                ],),

                              Icon(Icons.chevron_right,size: 28,color: Colors.white,)


                            ],
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            //去掉inkwell的点击效果
                          )),
                    )
                  ],
                ),
              ),



        ],
      )

    );
  }
}



