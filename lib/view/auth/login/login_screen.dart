import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../exports.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: UiUtils.systemUiOverlayStyle(isReverse: true, systemNavigationBarColor: Theme.of(context).primaryColor),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                title: "Sign Up",
                onPressed: () {
                  // Action
                },
              ),

              AppTextField(title: "Owner Name", hintText: "Enter Owner Name"),
            ],
          ),
        ),
      ),
    );
  }
}
