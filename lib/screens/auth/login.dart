import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/screens/auth/forgot_password.dart';
import 'package:health_guard/screens/auth/signup.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dropdown_login.dart';
import '../../components/custom_socialbutton.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../providers/auth/login_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_constants.dart';
import '../../utils/util_functions.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    height: 270,
                  ),
                  const CustomText(
                    "Login",
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
                  CustomDropdownLogin(),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextfield(
                    lableText: "example@gmail.com",
                    controller:
                        Provider.of<LoginProvider>(context).emailController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextfield(
                    lableText: "Password",
                    isObsecure: true,
                    controller:
                        Provider.of<LoginProvider>(context).passwordController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        UtilFunctions.navigateTo(
                            context, const ForgotPassword());
                      },
                      child: const CustomText(
                        "Forgot Password?",
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, value, child) {
                      return CustomButton(
                        text: "Login",
                        isLoading: value.isLoading,
                        height: 37,
                        width: 170,
                        radius: 20,
                        onTap: () {
                          value.startLogin(context);
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
                        "Don't you have an account?",
                        fontSize: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          UtilFunctions.navigateTo(context, const SignUp());
                        },
                        child: const CustomText(
                          "Sign up",
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
