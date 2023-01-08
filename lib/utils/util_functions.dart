import 'package:flutter/material.dart';

class UtilFunctions {
  //----------------navigator function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  //----------------backward navigator function
  static void navigateToBackward(BuildContext context){
    Navigator.of(context).pop();
  }
}
