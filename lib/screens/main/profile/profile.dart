import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/custom_text.dart';
import '../../../providers/auth/user_provider.dart';

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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: value.isLoading
                    ? const CircularProgressIndicator()
                    : CustomText(
                        value.userModel.name,
                        fontSize: 20,
                      ),
              ),
              Center(
                child: value.isLoading
                    ? const CircularProgressIndicator()
                    : CustomText(
                        value.userModel.email,
                        fontSize: 20,
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
