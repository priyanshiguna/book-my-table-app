import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../exports.dart';
import '../../utils/common_enums.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

abstract class NotificationService {
  NotificationService._();

  static AndroidNotificationChannel timerChannel = const AndroidNotificationChannel(
    'NOTIFICATION_CHANEL',
    'Notification Chanel',
    description: 'This channel is used for app notification',
    importance: Importance.min,
  );

  static Future<void> init() async {
    await getNotificationPermission();
    await firebaseMessagingInit();
    await getMessage();
    cancelNotification(0);
  }

  static Future getNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(timerChannel);
  }

  static Future<void> firebaseMessagingInit() async {
    final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('ic_notification');
    final DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  static Future<dynamic> onSelectNotification(NotificationResponse notificationResponse) async {
    debugPrint("-=-=-=-=-=-=-> onSelectNotification <-=-=-=-=-=--=-");
    if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
      navigation(notificationResponse.payload, state: NotificationState.open);
    }
  }

  static Future<void> getMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // KILL APP
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      debugPrint("-=-=-=-=-=-=-> getInitialMessage <-=-=-=-=-=--");
      if (message != null) {
        Future.delayed(const Duration(seconds: 3), () {
          navigation(message.data, state: NotificationState.kill);
        });
      }
    });

    // BACKGROUND
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      debugPrint("-=-=-=-=-=-=-> onMessageOpenedApp <-=-=-=-=-=--");
      if (message != null) {
        navigation(message.data, state: NotificationState.background);
      }
    });

    // OPEN APP
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      debugPrint("-=-=-=-=-=-=-> onMessage <-=-=-=-=-=--");

      // await NotificationType.fromSlugToAction(message, state: NotificationState.open);
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
  }

  static Future<void> showNotification({RemoteMessage? remoteMessage}) async {
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      remoteMessage?.data['id'] ?? 'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    printYellow("Notification id: ${channel.id}");

    final AndroidNotificationDetails android = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      priority: Priority.high,
      importance: Importance.max,
      sound: channel.sound,
    );

    final DarwinNotificationDetails iOS = const DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
      sound: 'notification_sound.wav',
    );

    printYellow(int.tryParse(remoteMessage?.data['id'].toString() ?? ""));
    printWarning(int.tryParse(remoteMessage?.data['id'].toString() ?? "") ?? remoteMessage!.notification.hashCode.toString());

    final int customNotificationId = int.tryParse(remoteMessage?.data['id'].toString() ?? "") ?? remoteMessage!.notification.hashCode;

    printWhite("Channel id: ${channel.id}");
    printWhite("Channel id: $customNotificationId");

    final NotificationDetails platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
      customNotificationId,
      // remoteMessage!.notification.hashCode,
      remoteMessage!.notification!.title,
      remoteMessage.notification!.body,
      platform,
      payload: jsonEncode(remoteMessage.data),
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void navigation(payload, {required NotificationState state}) async {
    final Map<String, dynamic> newPay = payload.runtimeType == String ? jsonDecode(payload) : payload;

    debugPrint(newPay.toString());

    // if (!isValEmpty(LocalStorage.accessToken.value)) {
    //   if (state != NotificationState.open) {}

    //   if (Get.isRegistered<BottombarViewModel>()) {
    //     // Get.find<BottombarViewModel>().currentBottomIndex.value = 3;
    //   }
    //   if (!isValEmpty(newPay['screen-route']) && Get.currentRoute != AppRoutes.walkInProgressView) {
    //     Get.toNamed(AppRoutes.walkInProgressView);
    //   }
    // }

    ///* -=-=-=-=-=-=-= GLOBALLY -=-=-=-=-=-=-=-==->
    if (!isValEmpty(newPay) && !isValEmpty(newPay['notification_type'])) {
      await Future.delayed(
        Durations.short3,
        () async {
          //! First create bottombar route than navigate any route.
          // if (isRegistered<BottombarViewModel>() && await getConnectivityResult()) {
          //   await NotificationType.fromSlugToNavigate(newPay['notification_type'], payload: newPay);
          // }
        },
      );
    } else {
      printErrors(type: "Notification payload isEmpty", errText: newPay);
    }
  }

  static Future<List<ActiveNotification>> removeConversationNotification({required String conversationId}) async {
    final List<ActiveNotification> pendingNotifications = await flutterLocalNotificationsPlugin.getActiveNotifications();

    final List<ActiveNotification> commonNotification = pendingNotifications.where(
      (element) {
        return element.channelId == conversationId;
      },
    ).toList();

    for (int i = 0; i < commonNotification.length; i++) {
      if (commonNotification[i].id != null) {
        flutterLocalNotificationsPlugin.cancel(commonNotification[i].id!);
      }
    }
    return pendingNotifications;
  }

  static Future<List<ActiveNotification>> removeRequestNotification({required String requestId}) async {
    final List<ActiveNotification> pendingNotifications = await flutterLocalNotificationsPlugin.getActiveNotifications();

    final List<ActiveNotification> commonNotification = pendingNotifications.where(
      (element) {
        return element.channelId == requestId;
      },
    ).toList();

    for (int i = 0; i < commonNotification.length; i++) {
      if (commonNotification[i].id != null) {
        flutterLocalNotificationsPlugin.cancel(commonNotification[i].id!);
      }
    }
    return pendingNotifications;
  }
}
