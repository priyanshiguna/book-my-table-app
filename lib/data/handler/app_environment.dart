import 'package:book_my_table_app/utils/common_enums.dart';

import '../../exports.dart';

/// A utility class to manage the application's API environment configuration.
class AppEnvironment {
  AppEnvironment._();

  /// Environment type.
  // static EnvironmentType envType = EnvironmentType.development;
  static late EnvironmentType envType;

  /// Set Environment, set in `main.dart`
  static void setEnvironment(EnvironmentType env) {
    envType = env;
    printData(key: "Set APP Environment", value: env.slug);
  }

  // Initial Version.
  static const String initialVersionCode = "v1";

  /// Returns the base URL for the current environment, appending the version code if necessary.
  static String getBaseURL({bool ignoreVersion = false}) {
    // printData(key: "APP Environment", value: envType.name);

    final String url = _getBaseURLByEnvironment(envType);
    return ignoreVersion ? url : "$url/";
  }

  /// Determines the base URL based on the environment type.
  static String _getBaseURLByEnvironment(EnvironmentType env) {
    switch (env) {
      case EnvironmentType.production:
        return "https://ppa-api.happypet.care";

      case EnvironmentType.staging:
        return "http://13.126.213.87:7028";

      case EnvironmentType.development:
        return "https://cool-radically-martin.ngrok-free.app";

      case EnvironmentType.local:
        return "http://192.168.1.11:3002";
    }
  }
}
