import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AlertHelper {
  //-------------a function to show alert dialog box
  /*
  Dont make this 'showAlert' function as a async function
  bcz, sometimes this will show asynchronous suspension error..
   */
  static void showAlert(
      BuildContext context, DialogType dialogType, String title, String desc,
      [Function()? pressOK]) {
    AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.BOTTOMSLIDE,
        title: title,
        desc: desc,
        btnCancelOnPress: () {},
        btnOkOnPress: pressOK,
        /*() {
          if (p != null) {
            p();
          }
        }*/
    ).show();
  }
}
