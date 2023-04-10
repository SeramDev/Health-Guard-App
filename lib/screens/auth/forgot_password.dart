import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/alert_helper.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //---------email controller
  final emailController = TextEditingController();

  //---------store loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SlideInLeft(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 52,
                  ),
                  const CustomText(
                    "Forgot Password",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    AssetConstants.logo,
                    width: 202,
                    height: 138,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const CustomText(
                    "Please, enter your email address. You will receive a link to create a new password via email.",
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextfield(
                    lableText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 53,
                  ),
                  CustomButton(
                    text: "Send Reset Email",
                    height: 40,
                    width: 220,
                    isLoading: isLoading,
                    onTap: () async {
                      if (validateFields()) {
                        setState(() {
                          isLoading = true;
                        });

                        await AuthController()
                            .sendPassResetEmail(context, emailController.text);

                        //------clear textfields
                        emailController.clear();

                        //------stop the loader
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //-------------validate textfields function
  bool validateFields() {
    //-------first checking all the textfields are empty or not
    if (emailController.text.isEmpty) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please fill all the fields");
      return false;
    } else if (!emailController.text.contains("@")) {
      AlertHelper.showAlert(
          context, DialogType.ERROR, "ERROR", "Please enter a valid email");
      return false;
    } else {
      return true;
    }
  }
}
