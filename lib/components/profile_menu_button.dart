import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 241, 230),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  name,
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            const SizedBox(
              width: 17,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 238, 238),
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.kAsh,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
