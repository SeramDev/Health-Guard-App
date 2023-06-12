import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.iconPath,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final String iconPath;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 34,
        ),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: AppColors.kAsh.withOpacity(0.2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
