import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ttpdm_admin/views/screens/super_admin/admins.dart';
import 'package:ttpdm_admin/views/screens/super_admin/super_admin_settings.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import 'business_approved.dart';
import 'homescreen_admin.dart';
import 'users.dart';

class BottomNavigationBarAdmin extends StatelessWidget {
  const BottomNavigationBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt isSelectedIndex = 0.obs;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
            () => BottomAppBar(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
          color: AppColors.whiteColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  isSelectedIndex.value = 0;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: Image(
                        image: const AssetImage(
                          'assets/pngs/homeicon.png',
                        ),
                        color: isSelectedIndex.value == 0
                            ? AppColors.mainColor
                            : const Color(0xff999999),
                      ),
                    ),
                    Text(
                      'Home',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 14.px,
                          color: isSelectedIndex.value == 0
                              ? AppColors.mainColor
                              : const Color(0xff999999)),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isSelectedIndex.value = 1;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: Image(
                        image: const AssetImage('assets/pngs/mainadmin.png'),
                        color: isSelectedIndex.value == 1
                            ? AppColors.mainColor
                            : const Color(0xff999999),
                      ),
                    ),
                    Text(
                      'Admin ',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 14.px,
                          color: isSelectedIndex.value == 1
                              ? AppColors.mainColor
                              : const Color(0xff999999)),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isSelectedIndex.value = 2;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: Image(
                        image: const AssetImage(
                            'assets/svgs/busineses.png'),
                        color: isSelectedIndex.value == 2
                            ? AppColors.mainColor
                            : const Color(0xff999999),
                      ),
                    ),
                    Text(
                      'Businesses',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 14.px,
                          color: isSelectedIndex.value == 2
                              ? AppColors.mainColor
                              : const Color(0xff999999)),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isSelectedIndex.value = 3;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: Image(
                        image: const AssetImage(
                            'assets/pngs/mdi_user.png'),
                        color: isSelectedIndex.value == 3
                            ? AppColors.mainColor
                            : const Color(0xff999999),
                      ),
                    ),
                    Text(
                      'User ',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 14.px,
                          color: isSelectedIndex.value == 3
                              ? AppColors.mainColor
                              : const Color(0xff999999)),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isSelectedIndex.value = 4;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                      child: Image(
                        image: const AssetImage('assets/pngs/setting.png'),
                        color: isSelectedIndex.value == 4
                            ? AppColors.mainColor
                            : const Color(0xff999999),
                      ),
                    ),
                    Text(
                      'Settings ',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 14.px,
                          color: isSelectedIndex.value == 4
                              ? AppColors.mainColor
                              : const Color(0xff999999)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
            () => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: isSelectedIndex.value == 0
                    ? const AdminHomeScreen()
                    : isSelectedIndex.value == 1
                    ? const AdminsScreen()
                    : isSelectedIndex.value == 2
                    ? const BusinessApproval()
                    : isSelectedIndex.value == 3
                    ? const UsersEmail()
                    : const SuperAdminSettingScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
