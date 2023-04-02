import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_text.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Center(
                      child: CustomText(
                        "Profile",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 122,
                    ),
                    value.isLoading
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () => value.selectImageAndUpload(context),
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 124,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  value.userModel.img,
                                ),
                                radius: 120,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      value.userModel.name,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      value.userModel.email,
                      fontSize: 13,
                      color: AppColors.kBalck,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
