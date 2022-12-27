// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../avatar/controllers/avatar_controller.dart';
import '../../config/controllers/config_controller.dart';



class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, this.cookieManager}) : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final configController = Get.put(ConfigController());
  final url = Get.arguments["url"];
  final title = Get.arguments["title"];
  bool isLoading = true;
  int isNumber = 10;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            color: Color.fromRGBO(15, 15, 15, 1)
          ),
        ),
        title:  Text('${title}'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: ()=>{
                  Get.toNamed("/configWalletList",arguments: {"title":"${configController.walletInfo.value[configController.walletIndex.value]["name"]}"})
                },
                style: ButtonStyle(
                  //去除阴影
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  //去掉inkwell的点击效果
                ),
                child:
                GetX<ConfigController>(
                    builder: (ConfigController) {
                      return
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "${configController.walletInfo.value[configController.walletIndex.value]["nft"]}",
                            width: 40,
                          ),
                        );
                    }
                ),
              ),



            ],
          ),
        ],
      ),
      body:Stack(
        children: [
          WebView(
            initialUrl: '${url}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print("progress ${progress/100}");
              setState(() {
                isNumber = progress;
              });
            },

            navigationDelegate: (NavigationRequest request) {
              var url = request.url;
              print("visit $url");
              setState(() {
                isLoading = true; // 开始访问页面，更新状态
              });
              return NavigationDecision.navigate;
            },

            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false; // 页面加载完成，更新状态
              });
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
          isLoading
              ? Container(
            child: Container(
              child: LinearProgressIndicator( backgroundColor: Color.fromRGBO(15, 15, 15, 1),
                valueColor: AlwaysStoppedAnimation(Color.fromRGBO(59,99,237,1,)),
                value: (isNumber/100)),
            ),
          )
              : Container(),
        ],
      ) ,
      bottomNavigationBar:  NavigationControls(_controller.future)
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : assert(_webViewControllerFuture != null),
        super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Container(
          padding: EdgeInsets.only(top: 8,right: 15,left: 15,bottom: 20),
          child:
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                  onPressed: !webViewReady
                      ? null
                      : () async {
                    if (await controller!.canGoBack()) {
                      await controller.goBack();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20),
                  onPressed: !webViewReady
                      ? null
                      : () async {
                    if (await controller!.canGoForward()) {
                      await controller.goForward();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.replay,color: Colors.white,size: 24),
                  onPressed: !webViewReady
                      ? null
                      : () {
                    controller!.reload();
                  },
                ),
              ],
            )
        );

      },
    );
  }
}