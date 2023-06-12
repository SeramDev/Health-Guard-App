import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth/signup_provider.dart';
import 'custom_dropdown.dart';
import 'custom_textfield.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(
          lableText: "Full name",
          //don't add (context, listen: false) when calling provider methods for property values.
          //add (listen: false) only when calling provider methods within a function.
          controller: Provider.of<SignUpProvider>(context).nameController,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomTextfield(
          lableText: "Age",
          controller: Provider.of<SignUpProvider>(context).ageController,
        ),
        const SizedBox(
          height: 12,
        ),
        CustomDropdown(),
        const SizedBox(
          height: 12,
        ),
        CustomTextfield(
          lableText: "Email",
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
