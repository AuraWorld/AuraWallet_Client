import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';


import '../../config/controllers/config_controller.dart';
import '../../configAddressBook/controllers/configAddressBook_controller.dart';
import '../controllers/configAddressBookList_controller.dart';


class ConfigAddressBookListView extends GetView<ConfigAddressBookListController> {
  const ConfigAddressBookListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Book"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
           color: Color.fromRGBO(21,21,21,1),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
               Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
              tooltip: '',
              onPressed: () {
                Get.toNamed("configAddressBook");
              }
          ),
        ],
      ),
      body:ConfigWalletListInfo(),

      backgroundColor: const Color.fromRGBO(21,21,21,1),
    );
  }
}

class ConfigWalletListInfo extends StatefulWidget {
  ConfigWalletListInfo ({Key? key}) : super(key: key);

  @override

  ConfigWalletListInfoView  createState() => ConfigWalletListInfoView();

}

class ConfigWalletListInfoView extends State<ConfigWalletListInfo>{
  final configController = Get.put(ConfigController());
  final configAddressBookController = Get.put(ConfigAddressBookController());
  late List _addressBookList;


  void initState() {
    _addressBookList = configAddressBookController.addressBook.value;
    super.initState();
  }

  List<Widget> _WalletList(){
    return _addressBookList.asMap().keys.map((f) =>

        Container(
            child:  Slidable(

              key: Key(UniqueKey().toString()),
              closeOnScroll: false,
              groupTag: "todo", // this must be unique
              // The start action pane is the one at the left or the top side.
              endActionPane: ActionPane(
                extentRatio: 0.20,
                key: Key(UniqueKey().toString()),
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {configAddressBookController.removeAddressBook(f);}),

                children:  [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (BuildContext context) { configAddressBookController.removeAddressBook(f);},
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Builder(builder: (context) {
                return TextButton(
                  onPressed: () =>
                  {
                    print(configAddressBookController.addressBook.value),
                    configAddressBookController.setAddressBookIndex(f),
                    Get.toNamed("/configEditAddressBook")
                    // Get.off(ConfigWalletView())
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 0.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(29, 29, 29, 1),
                      // Color.fromRGBO(59, 99, 237, 1),
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                    child:
                    Row(
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.only(top: 6),
                            margin: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),

                            ),
                            child: Text("$f",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,)
                        ),
                        Container(
                          height: 45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              GetBuilder<ConfigAddressBookController>(
                                  id:"addressBook",
                                  init: ConfigAddressBookController(),
                                  builder: (ConfigAddressBookController) {
                                    return
                                      Text("${configAddressBookController.addressBook
                                          .value[f]["name"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                        ),);
                                  }),
                              GetX<ConfigAddressBookController>(
                                  builder: (ConfigAddressBookController) {
                                    return
                                      Text("${configController.interceptAddress(configAddressBookController.addressBook
                                          .value[f]["address"])}",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16
                                        ),);
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),

                  ),
                  style: ButtonStyle(
                    //去除阴影
                    minimumSize: MaterialStateProperty.all(Size(1, 1)),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    elevation: MaterialStateProperty.all(0),
                    //将按钮背景设置为透明
                    backgroundColor: MaterialStateProperty.all(
                        Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),

                  ),

                );
              }),
            )
        )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
  return
  SingleChildScrollView(
    child:  GetX<ConfigAddressBookController>(
          builder: (ConfigAddressBookController) {
            return
              GestureDetector(
                onTap: () {
              // 触摸收起键盘
                  closeOnCancel:false;
            },
                child:     Container(
                    padding: const EdgeInsets.only(right: 10.0,top: 20.0,bottom: 40.0,left: 10.0),
                    child: configAddressBookController.addressBook.value.length>0? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                            runSpacing: 10.0,
                            children: _WalletList()
                        ),
                      ],
                    ):Container(
                        height:  MediaQuery.of(context).size.height*0.7,
                        child:  Center(child: Text("Add your first label",style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16,fontWeight: FontWeight.w800),),)
                    )
                ),
              );

          }),
  );
  }
}


