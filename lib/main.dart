import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/push_notification.dart';
import 'package:ttpdm_admin/splash_screen.dart';

import 'controller/getx_controllers/internet_connectvty_controller.dart';
import 'controller/utils/check_internet_connectivity.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await notificationServices.showNotification(message);

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ConnectivityController()); // Ensure ConnectivityController is initialized

  runApp(const MyApp());
}

final NotificationServices notificationServices = NotificationServices();
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    notificationServices.firebaseInit(context);
    MySharedPreferences().getSavedNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConnectivityWrapper(child: SplashScreen()),
      );
    });
  }
}
class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController = Get.find();
    return Obx(() {
      if (connectivityController.isConnected.value) {
        return child; // Show the child widget if connected
      } else {
        return const ConnectivityScreen(); // Show ConnectivityScreen if disconnected
      }
    });
  }

}