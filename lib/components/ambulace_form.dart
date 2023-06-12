import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/auth/signup_provider.dart';
import 'custom_textfield.dart';

class AmbulanceForm extends StatelessWidget {
  const AmbulanceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(
          lableText: "Ambulance name",
          //don't add (context, listen: false) when calling provider methods for property values.
          //add (listen: false) only when calling provider methods within a function.
          controller: Provider.of<SignUpProvider>(context).nameController,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextfield(
          lableText: "Hospital name",
          controller:
              Provider.of<SignUpProvider>(context).hospitalNameController,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextfield(
          lableText: "Email address",
          controller: Provider.of<SignUpProvider>(context).emailController,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextfield(
          lableText: "Password",
          isObsecure: true,
          controller: Provider.of<SignUpProvider>(context).passwordController,
        ),
      ],
    );
  }
}
