import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_guard/components/custom_text.dart';
import '../../providers/auth/user_provider.dart';
import '../../utils/assets_constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), (() {
      Provider.of<UserProvider>(context, listen: false).initializeUser(context);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(child: Image.asset(AssetConstants.mainImg)),
            FadeInUp(
              child: const CustomText("Health Guard",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 145, 55, 167)),
            ),
          ],
        ),
      ),
    );
  }
}
