import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'data/handler/app_environment.dart';
import 'my_app.dart';
import 'utils/common_enums.dart';

void main() async {
  // 🧩 Inject the selected environment into the app's configuration
  AppEnvironment.setEnvironment(EnvironmentType.local);

  // 🧱 Execute bootstrap logic (storage, Firebase, notifications, orientation, crashlytics, etc.)
  await bootstrap();

  // 🏁 Run the app
  runApp(const MyApp());
}
