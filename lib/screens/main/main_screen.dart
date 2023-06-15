import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_guard/screens/main/home/home.dart';
import 'package:health_guard/screens/main/profile/profile.dart';
import 'package:health_guard/utils/app_colors.dart';
import '../../new_fetcher/bloc/new_fetch.dart';
import '../../utils/alert_helper.dart';
import '../../utils/assets_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

class MainScreen extends riverpod.ConsumerStatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  riverpod.ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends riverpod.ConsumerState<MainScreen> {
  Timer? _timer;
  @override
  void initState() {
    _screens.addAll({
      const Home(),
      const Profile(),
    });

    super.initState();

    ref.read(alertStateProvider.notifier).fetchUserData(context);

    _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      ref.read(alertStateProvider.notifier).fetchUserData(context);
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
    return WillPopScope(
      onWillPop: () async {
        AlertHelper.showAlert(
          context,
          DialogType.QUESTION,
          "Exit",
          "Are you sure want to close the application?",
          () {
            SystemNavigator.pop();
          },
        );
        return false;
      },
      child: Scaffold(
        body: _screens[activeIndex],
        bottomNavigationBar: SizedBox(
          height: 83,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: SvgPicture.asset(
                  AssetConstants.homeIcon,
                  color: activeIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.kAsh,
                ),
                onTap: () {
                  onItemTapped(0);
                },
              ),
              InkWell(
                child: SvgPicture.asset(
                  AssetConstants.profileIcon,
                  color: activeIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.kAsh,
                ),
                onTap: () {
                  onItemTapped(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
