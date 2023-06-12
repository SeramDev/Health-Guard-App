import 'package:flutter/material.dart';
import 'package:health_guard/providers/auth/signup_provider.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class CustomDropdownSignUp extends StatelessWidget {
  CustomDropdownSignUp({
    Key? key,
  }) : super(key: key);

  final List<String> userRoleList = ["User", "Police Station", "Ambulance"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: AppColors.kAsh.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Consumer<SignUpProvider>(
        builder: (context, value, child) {
          return DropdownButtonFormField(
            value: value.roleController,
            items: userRoleList
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (val) {
              value.setSelectedSignUpRole(val as String);
            },
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
              color: AppColors.kAsh,
            ),
            decoration: InputDecoration(
              labelText: "Role",
              labelStyle: const TextStyle(color: AppColors.kAsh),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: AppColors.kWhite),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
