import 'app_environment.dart';

class ApiUrls {
  ApiUrls._();
  
  static String baseUrl = AppEnvironment.getBaseURL();

  //? Auth Api's
  static String loginUrl = "";
  static String registerUrl = "";

  //TODO : REFRESH TOKEN URL MUST BE CHANGE
  static const String refreshTokenUrl = "auth/update-token";

  //? Dashboard Api's
  static String dashboardUrl = "";
}
