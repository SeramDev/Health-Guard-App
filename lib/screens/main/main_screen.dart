import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_guard/screens/main/home/home.dart';
import 'package:health_guard/screens/main/profile/profile.dart';
import 'package:health_guard/utils/app_colors.dart';
import '../../utils/assets_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    _screens.addAll({
      const Home(),
      const Profile(),
    });
    super.initState();
  }

  //----------------list to store bottom navigation screens
  final List<Widget> _screens = [];

  //------------store the active index
  var activeIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[activeIndex],
      bottomNavigationBar: SizedBox(
        height: 83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: SvgPicture.asset(
                AssetConstants.homeIcon,
                color:
                    activeIndex == 0 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () {
                onItemTapped(0);
              },
            ),
            InkWell(
              child: SvgPicture.asset(
                AssetConstants.profileIcon,
                color:
                    activeIndex == 1 ? AppColors.primaryColor : AppColors.kAsh,
              ),
              onTap: () {
                onItemTapped(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
