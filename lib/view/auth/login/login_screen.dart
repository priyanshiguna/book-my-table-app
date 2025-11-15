import 'package:flutter/material.dart';

import '../../../res/app_button.dart';
import '../../../utils/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
