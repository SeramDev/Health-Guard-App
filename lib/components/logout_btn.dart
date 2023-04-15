import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../utils/alert_helper.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AlertHelper.showAlert(
          context,
          DialogType.QUESTION,
          "Logout",
          "Are you sure want to Logout?",
          () {
            AuthController().logOut(context);
          },
        );
      },
      child: SizedBox(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 241, 230),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const CustomText(
                  "Logout",
                  fontSize: 23,
                  color: AppColors.primaryRed,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
