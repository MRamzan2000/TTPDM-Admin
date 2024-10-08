import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationServices() {
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    var androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          // Handle notification tap
          // _handleNotificationTap(payload);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
     MySharedPreferences().saveNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap
      // _handleNotificationTap(message.data);
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // Handle notification tap
        // _handleNotificationTap(message.data);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    const channelId = 'your_channel_id';
    const channelName = 'Your Channel Name';

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.max,
      playSound: true,
      showBadge: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      notificationDetails,
    );
  }


  Future<String?> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        log('Device Token: $token');
      } else {
        log('Failed to get device token');
      }
      return token;
    } catch (e) {
      log('Error getting device token: $e');
      return null;
    }
  }
}
