


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorView extends StatefulWidget {
  ColorView({Key? key}) : super(key: key);

  @override

  ColorViewInfo createState() => ColorViewInfo();

}

class ColorViewInfo extends State<ColorView>{


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color.fromRGBO(21 ,21 ,21, 1), Color.fromRGBO(19 ,28, 62, 1),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ),
    );
  }

}