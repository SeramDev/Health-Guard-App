import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_guard/components/custom_button.dart';
import 'package:health_guard/screens/alert/alert.dart';
import 'package:health_guard/utils/util_functions.dart';
import '../../../components/custom_text.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeInRight(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AssetConstants.menuIcon,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          AuthController().logOut();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const CustomText(
                "Dashboard",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 300,
              ),
              CustomButton(
                text: "Show Alert",
                onTap: () {
                  UtilFunctions.navigateTo(context, const AlertScreen());
                },
                fontsize: 20,
                height: 42,
                width: 200,
                radius: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
