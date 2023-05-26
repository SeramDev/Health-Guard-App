import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_dropdown_signup.dart';
import 'package:health_guard/components/user_form.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:provider/provider.dart';
import '../../components/ambulace_form.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/police_form.dart';
import '../../providers/auth/signup_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';
import '../../utils/util_functions.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    "SignUp",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    AssetConstants.logo,
                    width: 202,
                    height: 138,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropdownSignUp(),
                  const SizedBox(
                    height: 14,
                  ),
                  Consumer<SignUpProvider>(builder: (context, value, child) {
                    if (value.roleController == "User") {
                      return const UserForm();
                    } else if (value.roleController == "Police Station") {
                      return const PoliceForm();
                    } else {
                      return const AmbulanceForm();
                    }
                  }),
                  const SizedBox(
                    height: 14,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        UtilFunctions.navigateTo(context, const Login());
                      },
                      child: const CustomText(
                        "Already have an account?",
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Consumer<SignUpProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                        text: "SignUp",
                        isLoading: value.isLoading,
                        height: 40,
                        width: 170,
                        onTap: () {
                          value.startSignup(context, value.roleController);
                        },
                      );
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
}
