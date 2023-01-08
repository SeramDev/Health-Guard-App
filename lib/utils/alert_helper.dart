import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AlertHelper {
  //-------------a function to show alert dialog box
  static Future<dynamic> showAlert(
    BuildContext context,
    DialogType dialogType,
    String title,
    String desc,
  ) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
