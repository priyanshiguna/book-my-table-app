import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../exports.dart';

const double defaultPadding = 16.0;
const double defaultRadius = 8.0;
const int defaultAmountLength = 12;
const List<BoxShadow> defaultShadow = [BoxShadow(color: Colors.black12, blurRadius: 1)];

const Duration defaultDuration = Duration(milliseconds: 300);

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
}

/// ------ To Check Internet Ability -------------------->>>
ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();

Future<bool> getConnectivityResult({bool showToast = true, RxBool? isLoader}) async {
  try {
    connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      if (showToast == true) {
        UiUtils.toast(AppStrings.noInternetAvailable);
        isLoader?.value = false;
      }
      return false;
    }
  } on PlatformException catch (e) {
    printErrors(type: "getConnectivityResult Function", errText: e);
    UiUtils.toast(AppStrings.noInternetAvailable);
    isLoader?.value = false;
    return false;
  }
}

Future<void> launchUrlFunction(String url, {String? errorMess}) async {
  try {
    if (!await launchUrl(Uri.parse(url), mode: Platform.isIOS ? LaunchMode.externalApplication : LaunchMode.externalNonBrowserApplication)) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    if (!isValEmpty(errorMess)) {
      // SnackbarHelper.showOnChangeStatus(title: errorMess, snackbarType: SnackbarType.wrong);
    }
    printWarning("launchUrl Function");
  }
}

Future<String?> getClipboardData() async {
  final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
  if (clipboardData != null && clipboardData.text != null) {
    return clipboardData.text!;
  } else {
    return null;
  }
}

Future<PackageInfo> getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  printData(key: "AppName", value: packageInfo.appName);
  printData(key: "Version", value: packageInfo.version);
  printData(key: "PackageName", value: packageInfo.packageName);

  return packageInfo;
}

UnsupportedError get platformUnsupportedError => UnsupportedError("Sorry, this app is Android and iOS so it does not support another platform.");

Future<void> deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

ThemeMode themeMode({required String theme}) {
  ThemeMode themeMode = ThemeMode.light;
  switch (theme) {
    case 'light':
      themeMode = ThemeMode.light;
      break;
    case 'dark':
      themeMode = ThemeMode.dark;
      break;
    case 'system':
      themeMode = ThemeMode.system;
      break;
    default:
      themeMode = ThemeMode.light;
  }
  return themeMode;
}
