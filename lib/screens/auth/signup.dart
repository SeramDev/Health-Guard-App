import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_dropdown_signup.dart';
import 'package:health_guard/components/user_form.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:provider/provider.dart';
import '../../components/ambulace_form.dart';
import '../../components/custom_button.dart';
import '../../components/custom_socialbutton.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  const CustomText(
                    "Sign Up",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kBalck,
                  ),
                  const CustomText(
                    "We need some of your infomation to\nget started.",
                    fontSize: 15,
                    color: AppColors.kBalck,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomDropdownSignUp(),
                  const SizedBox(
                    height: 12,
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
                    height: 5,
                  ),
                  RadioListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: const Text(
                      "I am agreeing with privacy policy and license agreement.",
                      style: TextStyle(fontSize: 13),
                    ),
                    value: "male",
                    groupValue: const Text(""),
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Consumer<SignUpProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                        text: "Create Account",
                        isLoading: value.isLoading,
                        height: 37,
                        radius: 20,
                        width: 190,
                        onTap: () {
                          value.startSignup(context, value.roleController);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.kBalck,
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SocialButton(
                    text: "Continue with google",
                    iconPath: AssetConstants.googleIcon,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        "Already have an account?",
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          UtilFunctions.navigateTo(context, const Login());
                        },
                        child: const CustomText(
                          "Login",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryRed,
                        ),
                      ),
                    ],
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
