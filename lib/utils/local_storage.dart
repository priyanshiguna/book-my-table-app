import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/model/get_user_model.dart';
import '../exports.dart';

class Prefs {
  static const String userId = "ID";
  static const String userName = "NAME";
  static const String userMobile = "MOBILE";
  static const String userImage = "USER_IMAGE";
  static const String accessToken = "TOKEN";
  static const String refreshToken = "REFRESH_TOKEN";
}

class DevicePrefs {
  //* =-=-=-=-=-=-=-=> Device Data <-=-=-=-=-=-=-=- //
  static const String deviceID = "DEVICE_ID";
  static const String deviceTOKEN = "DEVICE_TOKEN";
  static const String deviceTYPE = "DEVICE_TYPE";
  static const String deviceNAME = "DEVICE_NAME";
}

class LocalStorage {
  static GetStorage prefs = GetStorage();
  static const String _userModel = "user_model";

  //* -=-=-=-=-=-=-> API User Store <-=-=-=-=-=-=-= //
  /// UserModelData
  static set userModel(UserModel value) {
    final String encodedValue = jsonEncode(value);
    prefs.write(_userModel, encodedValue);
  }

  static UserModel get userModel {
    final String result = prefs.read(_userModel) ?? "";
    return !isValEmpty(result) ? UserModel.fromJson(json.decode(result)) : UserModel();
  }

  //* -=-=-=-=-=-=-> Store access token <-=-=-=-=-=-=-= //
  static RxString accessToken = "".obs;
  static RxString refreshToken = "".obs;

  static Future<void> storeAccessTokens({Tokens? tokens}) async {
    if (!isValEmpty(tokens?.access?.token)) {
      await prefs.write(Prefs.accessToken, tokens?.access?.token ?? "");
      accessToken.value = prefs.read(Prefs.accessToken) ?? "";
    }
    if (!isValEmpty(tokens?.refresh?.token)) {
      await prefs.write(Prefs.refreshToken, tokens?.refresh?.token ?? "");
      refreshToken.value = prefs.read(Prefs.refreshToken) ?? "";
    }

    printData(key: "Access Token", value: accessToken.value);
    printData(key: "Refresh Token", value: refreshToken.value);
  }

  //* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-> Devices Module <=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= *//
  static GetStorage devicePrefs = GetStorage();
  static String deviceId = "", deviceName = "", deviceType = "", deviceToken = "";

  static Future storeDeviceInfo({
    required String deviceID,
    required String deviceTOKEN,
    required String deviceTYPE,
    required String deviceNAME,
  }) async {
    await devicePrefs.write(DevicePrefs.deviceID, deviceID);
    await devicePrefs.write(DevicePrefs.deviceTOKEN, deviceTOKEN);
    await devicePrefs.write(DevicePrefs.deviceTYPE, deviceTYPE);
    await devicePrefs.write(DevicePrefs.deviceNAME, deviceNAME);

    deviceId = devicePrefs.read(DevicePrefs.deviceID) ?? '';
    deviceToken = devicePrefs.read(DevicePrefs.deviceTOKEN) ?? '';
    deviceType = devicePrefs.read(DevicePrefs.deviceTYPE) ?? '';
    deviceName = devicePrefs.read(DevicePrefs.deviceNAME) ?? '';
  }

  //* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-> Common Functions <=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- *//

  //* -=-=-=-=-=-=-=-> Read Local Storage <-=-=-=-=-=-=-=- //
  static Future<void> readDataInfo() async {
    accessToken.value = prefs.read(Prefs.accessToken) ?? "";
    printData(key: "accessToken Type", value: accessToken.value);
    refreshToken.value = prefs.read(Prefs.refreshToken) ?? "";
    accessToken.value = prefs.read(Prefs.accessToken) ?? "";

    deviceId = devicePrefs.read(DevicePrefs.deviceID) ?? '';
    deviceToken = devicePrefs.read(DevicePrefs.deviceTOKEN) ?? '';
    deviceType = devicePrefs.read(DevicePrefs.deviceTYPE) ?? '';
    deviceName = devicePrefs.read(DevicePrefs.deviceNAME) ?? '';
  }

  //! -=-=-=-=-=-=-=> Clear Local Storage  <-=-=-=-=-=-=-= //
  static Future<void> clearLocalStorage() async {
    await prefs.erase(); //? Prefs Storage Erase
    userModel = UserModel();
    accessToken = "".obs;
  }

  static Future<void> printLocalStorageData() async {
    printData(key: "Access Token", value: accessToken.value);

    printDate("Device Permanent Data");

    printData(key: "Local Device Id", value: deviceId);
    printData(key: "Local Device Type", value: deviceType);
    printData(key: "Local Device Name", value: deviceName);
    printData(key: "Local Device Token", value: deviceToken);
  }
}
