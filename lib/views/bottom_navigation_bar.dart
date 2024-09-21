import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/screens/mid_admin/campaigns.dart';
import 'package:ttpdm_admin/views/screens/mid_admin/designs.dart';
import 'package:ttpdm_admin/views/screens/mid_admin/home_screen.dart';
import 'package:ttpdm_admin/views/screens/mid_admin/settings.dart';
import 'package:ttpdm_admin/views/screens/mid_admin/businesses.dart';

import '../controller/custom_widgets/app_colors.dart';
import '../controller/custom_widgets/custom_text_styles.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late UserProfileController userProfileController;
  final RxString id="".obs;
  @override
  void initState() {
    super.initState();
    id.value=MySharedPreferences.getString(userId);
    userProfileController=Get.put(UserProfileController(context: context));
    userProfileController.fetchUserProfile(loading: userProfileController.userProfile.value==null, id: id.value);
  }

  @override
  Widget build(BuildContext context) {
    RxInt isSelectedIndex = 0.obs;
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: Obx(
        () =>userProfileController.isLoading.value?
           const SizedBox.shrink():
        BottomAppBar(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
          color: AppColors.whiteColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
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
                          )),
                      Text(
                        'Home',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 0
                                ? AppColors.mainColor
                                : const Color(0xff999999),overflow:TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),
              userProfileController.userProfile.value!.permissions.adBannerDesigns.manage?

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 1;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                            image: const AssetImage('assets/pngs/designicon.png'),
                            color: isSelectedIndex.value == 1
                                ? AppColors.mainColor
                                : const Color(0xff999999),
                          )),
                      Text(
                        'Design ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 1
                                ? AppColors.mainColor
                                : const Color(0xff999999),overflow:TextOverflow.ellipsis ),
                      )
                    ],
                  ),
                ),
              ): const SizedBox.shrink(),
              userProfileController.userProfile.value!.permissions.businesses.manage?

              Expanded(
                child: GestureDetector(
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
                                  : const Color(0xff999999))),
                      Text(
                        'Businesses',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 2
                                ? AppColors.mainColor
                                : const Color(0xff999999),overflow:TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ):   const SizedBox.shrink(),
              userProfileController.userProfile.value!.permissions.campaigns.manage?

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 3;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                              image: const AssetImage(
                                  'assets/pngs/campaignicon.png'),
                              color: isSelectedIndex.value == 3
                                  ? AppColors.mainColor
                                  : const Color(0xff999999))),
                      Text(
                        'Campaign ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 3
                                ? AppColors.mainColor
                                : const Color(0xff999999),overflow:TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ): const SizedBox.shrink(),
              Expanded(
                child: GestureDetector(
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
                                  : const Color(0xff999999))),
                      Text(
                        'Setting ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 4
                                ? AppColors.mainColor
                                : const Color(0xff999999),overflow:TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
            () => isSelectedIndex.value == 0
            ?  const HomeScreen()
            : isSelectedIndex.value == 1
            ?   const DesignScreen()
            :isSelectedIndex.value == 2?   const BusinessTabBar():isSelectedIndex.value == 3? CampaignScreen():const SettingScreen(),
      )
    );
  }
}
