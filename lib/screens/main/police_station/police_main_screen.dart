import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_guard/screens/main/police_station/police_profile.dart';
import '../../../map/user_map_screen.dart';
import '../../../map/widgets/map_section.dart';
import '../../../utils/alert_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_constants.dart';

class PoliceMain extends StatefulWidget {
  const PoliceMain({super.key});

  @override
  State<PoliceMain> createState() => _PoliceMainState();
}

class _PoliceMainState extends State<PoliceMain> {
    @override
  void initState() {
    _screens.addAll({
      const NewUserMapScreen(userType: UserType.police,),
      const PoliceProfile(),
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
          DialogType.question,
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
}
