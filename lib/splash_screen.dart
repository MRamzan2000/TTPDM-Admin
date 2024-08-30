import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/screens/auth_section/login_screen.dart';

import 'controller/custom_widgets/app_colors.dart';
import 'views/bottom_navigation_bar.dart';
import 'views/screens/super_admin/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateBasedOnLoginStatus() {
    MySharedPreferences.init().then(
      (value) {
        if (MySharedPreferences.getBool(isLoggedInKey)) {
          if (MySharedPreferences.getString("role") == "mid admin") {
            Get.off(() => const CustomBottomNavigationBar());
          } else {
            Get.off(() => const BottomNavigationBarAdmin());
          }
        } else {
          Get.off(() => LoginScreen());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigateBasedOnLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getVerticalSpace(6.5.h),
                SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: Image.asset('assets/pngs/logo.png')),
                getVerticalSpace(1.6.h),
                Text(
                  "TTPDM",
                  style: CustomTextStyles.onBoardingHeading,
                ),
                getVerticalSpace(8.h),
                SizedBox(
                  height: 2.4.h,
                  width: 2.4.h,
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                    strokeWidth: 5,
                  ),
                ),
                getVerticalSpace(11.8.h),
                Text(
                  'Welcome to TTPDM',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading,
                ),
                getVerticalSpace(2.1.h),
                Text(
                  'The best digital marketing app for your business',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight,
                ),
                getVerticalSpace(15.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
