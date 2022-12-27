import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:w3_wallet/app/modules/collection/views/collection_view.dart';
import 'package:w3_wallet/app/modules/config/views/config_view.dart';
import 'package:w3_wallet/app/modules/explorer/views/explorer_view.dart';
import 'package:w3_wallet/app/modules/token/views/token_view.dart';
import 'package:w3_wallet/app/modules/transaction/views/transaction_view.dart';


class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);

  @override

  HoveViewInfo createState() => HoveViewInfo();

}

class HoveViewInfo extends State<HomeView>{
  final List<Widget> _children = [
    TokenViewState(),
    CollectionView(),
    ExplorerView(),
    TransactionView(),
    ConfigView(),
  ];


  @override
  int _currentIndex = 0 ;
  void onTapAction(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      resizeToAvoidBottomInset: false,

      bottomNavigationBar: BottomNavigationBar(
        // 选中颜色
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(101, 101, 101, 1),
        backgroundColor: const Color.fromRGBO(12,12,12,1),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels:false,
        showUnselectedLabels:false,
        currentIndex: _currentIndex,
        onTap: onTapAction,
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.money_dollar_circle,
                size: 30.0,
              ),
              label: "tokens",
              tooltip: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.square_grid_2x2,
                size: 30.0,
              ),
              label: "nfts",
              tooltip: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.compass,
                size: 30.0,
              ),
              label: "explorer",
              tooltip: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.bolt_circle,
                size: 30.0,
              ),
              label: "history",
              tooltip: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.gear_big,
                size: 30.0,
              ),
              label: "config",
              tooltip: ''
          ),
        ],
      ) ,
    );
  }

}




