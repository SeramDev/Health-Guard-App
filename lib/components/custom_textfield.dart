import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.hintText,
    this.isObsecure = false,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final bool isObsecure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: AppColors.kAsh.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isObsecure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.kAsh),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: AppColors.kWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: AppColors.primaryRed),
          ),
        ),
      ),
    );
  }
}
