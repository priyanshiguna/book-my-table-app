// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:book_my_table_app/bootstrap.dart';
import 'package:book_my_table_app/data/handler/app_environment.dart';
import 'package:book_my_table_app/my_app.dart';
import 'package:book_my_table_app/utils/common_enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // 🧩 Inject the selected environment into the app's configuration
    AppEnvironment.setEnvironment(EnvironmentType.production);

    // 🧱 Execute bootstrap logic (storage, Firebase, notifications, orientation, crashlytics, etc.)
    await bootstrap();

    // 🚀 Launch the app
    await tester.pumpWidget(const MyApp());
  });
}
