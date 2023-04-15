import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_button.dart';
import 'package:health_guard/components/logout_btn.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_text.dart';
import '../../../components/profile_menu_button.dart';
import '../../../providers/auth/user_provider.dart';
import '../../../utils/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
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
                          "Profile",
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      value.isLoading
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () => value.selectImageAndUpload(context),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 100,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    value.userModel.img,
                                  ),
                                  radius: 96,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        value.userModel.name,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      CustomText(
                        value.userModel.email,
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
        },
      ),
    );
  }
}
