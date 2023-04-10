import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_dropdown_signup.dart';
import 'package:health_guard/screens/auth/login.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
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
                    height: 40,
                  ),
                  Image.asset(
                    AssetConstants.logo,
                    width: 202,
                    height: 138,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    lableText: "Name",
                    //don't add (context, listen: false) when calling provider methods for property values.
                    //add (listen: false) only when calling provider methods within a function.
                    controller:
                        Provider.of<SignUpProvider>(context).nameController,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextfield(
                    lableText: "Email",
                    controller:
                        Provider.of<SignUpProvider>(context).emailController,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextfield(
                    lableText: "Password",
                    isObsecure: true,
                    controller:
                        Provider.of<SignUpProvider>(context).passwordController,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomDropdownSignUp(),
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
                          value.startSignup(context);
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
