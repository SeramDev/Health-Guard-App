import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/utils/assets_constants.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text.dart';
import '../../../components/logout_btn.dart';
import '../../../components/profile_menu_button.dart';
import '../../../models/objects.dart';
import '../../../providers/auth/user_provider.dart';
import '../../../utils/app_colors.dart';

class PoliceProfile extends StatefulWidget {
  const PoliceProfile({super.key});

  @override
  State<PoliceProfile> createState() => _PoliceProfileState();
}

class _PoliceProfileState extends State<PoliceProfile> {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          if (value.consumer is! PoliceStationModel) {
            return const Center();
          } else {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Center(
                          child: CustomText(
                            "Police Station Profile",
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          radius: 100,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(AssetConstants.policeProfile),
                            radius: 96,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          (value.consumer as PoliceStationModel)
                              .policeStationName,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        CustomText(
                          (value.consumer as PoliceStationModel)
                              .PoliceStationEmail,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          text: "Edit Profile",
                          onTap: () {},
                          fontsize: 20,
                          height: 50,
                          width: 190,
                          radius: 50,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          color: AppColors.primaryColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const ProfileMenuButton(
                          name: "Settings",
                          icon: Icons.settings,
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const ProfileMenuButton(
                          name: "App Info",
                          icon: Icons.perm_device_information,
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const LogoutBtn(),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
