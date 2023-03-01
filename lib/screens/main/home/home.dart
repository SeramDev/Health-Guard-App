import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_guard/components/custom_button.dart';
import 'package:health_guard/screens/alert/alert.dart';
import 'package:health_guard/utils/util_functions.dart';
import '../../../components/custom_text.dart';
import '../../../components/sensor_data_card.dart';
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
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      AuthController().logOut();
                    },
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
                height: 30,
              ),
              SizedBox(
                height: 400,
                child: Expanded(
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.25,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return const SensorDataCard();
                    },
                  ),
                ),
              ),
              const CustomText(
                "Status",
                fontSize: 25,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                      color: AppColors.kAsh.withOpacity(.4),
                    )
                  ],
                ),
                child: const CustomText(
                  "Normal",
                  fontSize: 30,
                  color: AppColors.kWhite,
                ),
              ),
              const SizedBox(
                height: 20,
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
