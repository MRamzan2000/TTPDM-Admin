import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/views/screens/super_admin/stripe_screen.dart';
import 'package:ttpdm_admin/views/screens/super_admin/tab_bar.dart';


class SuperAdminSettingScreen extends StatelessWidget {
  const SuperAdminSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'TTPDM',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(2.4.h),


              GestureDetector(onTap: () {
                Get.to(()=> StripeScreen());
              },
                child: Text(
                  'Stripe Key',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      color: const Color(0xff191918),
                      fontSize: 14.px),
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              GestureDetector(
                onTap: () {
                  Get.to(()=>const BundlesTabBar());
                },
                child: Text(
                  'Bundles',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      color: const Color(0xff191918),
                      fontSize: 14.px),
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),

              GestureDetector(
                onTap: () {
                  
                },
                child: Text(
                  'Change Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      color: const Color(0xff191918),
                      fontSize: 14.px),
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),

              getVerticalSpace(1.h),
              GestureDetector(
                onTap: () {
                  logoutPopUp(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      color: const Color(0xff191918),
                      fontSize: 16.px),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
