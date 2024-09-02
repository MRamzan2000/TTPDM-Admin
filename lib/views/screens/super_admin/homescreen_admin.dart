import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_statistics_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final RxList<String> profilesList =
      <String>['Total users', 'Campaigns', 'Cancellation', 'Return Rate'].obs;

  final RxList<String> valuesList =
      <String>['+2.5%', '+0.5% ', '-1.5%', '+2.5%'].obs;

  final RxList<String> numbers = <String>['10289', '20921', '149', '17390'].obs;

  final RxList<String> descriptionList = <String>[
    "Compared to(21340 last Month)",
    'Compared to(19000 last Month)',
    'Compared to(165 last Month)',
    'Compared to(10500 last Month)'
  ].obs;
  late UserProfileController userProfileController;
  late GetStatisticsController getStatisticsController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatisticsController =
        Get.put(GetStatisticsController(context: context));
    userProfileController = Get.put(UserProfileController(context: context));
    String id = MySharedPreferences.getString(userId);

    userProfileController.fetchUserProfile(
        loading: userProfileController.userProfile.value == null, id: id);
    getStatisticsController.fetchStatistics(
        loading: getStatisticsController.statics.isEmpty);
    log("user profile :${userProfileController.userProfile.value}");
    log("user id :$id");
  }

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
      body: Obx(() =>
         SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userProfileController.isLoading.value
                      ? Shimmer.fromColors(
                    highlightColor: AppColors.highlightColor,
                    baseColor: AppColors.baseColor,
                    child: SizedBox(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 2.8.h,
                        ),
                        title: const Text(
                          '',
                        ),
                        subtitle: const Text(
                          '',
                        ),
                        trailing: SizedBox(
                          height: 4.8.h,
                          width: 4.8.h,
                        ),
                      ),
                    ),
                  )
                      : userProfileController.userProfile.value == null
                      ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 2.8.h,
                      backgroundImage:
                      const AssetImage('assets/pngs/profile.png'),
                    ),
                    title: Text(
                      'Hello Mid Admin',
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w400,
                          fontSize: 18.px,
                          color: const Color(0xff2F3542)),
                    ),
                    subtitle: Text('Welcome Back',
                        style: TextStyle(
                            fontFamily: 'light',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.px,
                            color: const Color(0xff2F3542))),
                    trailing: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                          height: 4.8.h,
                          width: 4.8.h,
                          child: svgImage(
                              'assets/svgs/midadminnotification.svg')),
                    ),
                  )
                      : ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 2.8.h,
                      backgroundImage:
                      const AssetImage('assets/pngs/profile.png'),
                    ),
                    title: Text(
                      userProfileController.userProfile.value!.fullname,
                      style: TextStyle(
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w400,
                          fontSize: 18.px,
                          color: const Color(0xff2F3542)),
                    ),
                    subtitle: Text('Welcome Back',
                        style: TextStyle(
                            fontFamily: 'light',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.px,
                            color: const Color(0xff2F3542))),
                    trailing: GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                          height: 4.8.h,
                          width: 4.8.h,
                          child: svgImage(
                              'assets/svgs/midadminnotification.svg')),
                    ),
                  ),
                  getVerticalSpace(2.8.h),
                  getStatisticsController.isLoading.value
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profilesList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: .6.h,
                            mainAxisSpacing: .6.h,
                          ),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: AppColors.baseColor,
                              highlightColor: AppColors.highlightColor,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.8.h, vertical: 1.7.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.h),
                                  color: Colors
                                      .white, // Assuming AppColors.whiteColor is Colors.white
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getVerticalSpace(1.1.h),
                                    const Text(
                                      "",
                                    ),
                                    getVerticalSpace(1.h),
                                    const Text(
                                      "",
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profilesList.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: .6.h,
                            mainAxisSpacing: .6.h,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.8.h, vertical: 1.7.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.h),
                                color: Colors
                                    .white, // Assuming AppColors.whiteColor is Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: profilesList[index],
                                            style: TextStyle(
                                                color: const Color(0xff171725),
                                                fontSize: 14.px,
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.w600)),
                                        TextSpan(
                                            text: " ${valuesList[index]}",
                                            style: TextStyle(
                                                color: index == 2
                                                    ? const Color(0xffFC5A5A)
                                                    : const Color(0xff3DD598),
                                                fontSize: 14.px,
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.w600)),
                                      ])),
                                      getHorizentalSpace(.2.h),
                                      index == 2
                                          ? SvgPicture.asset(
                                              'assets/svgs/arrowdown.svg')
                                          : SvgPicture.asset(
                                              'assets/svgs/arrowup.svg')
                                    ],
                                  ),
                                  getVerticalSpace(1.1.h),
                                  Text(
                                    numbers[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'bold',
                                      fontSize: 26.px,
                                      color: const Color(0xff171725),
                                    ),
                                  ),
                                  getVerticalSpace(1.h),
                                  Text(
                                    descriptionList[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'regular',
                                      fontSize: 13.px,
                                      color: const Color(0xff92929D),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                  getVerticalSpace(1.4.h),
                  getStatisticsController.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: AppColors.baseColor,
                          highlightColor: AppColors.highlightColor,
                          child: Container(
                            height: 30.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.7.h, vertical: 1.9.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.h),
                                color: AppColors.whiteColor),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.7.h, vertical: 1.9.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.h),
                              color: AppColors.whiteColor),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/svgs/left.svg'),
                                  Text(
                                    'Subscription ',
                                    style: TextStyle(
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.px,
                                        color: const Color(0xff171725)),
                                  ),
                                  SvgPicture.asset('assets/svgs/right.svg'),
                                ],
                              ),
                              getVerticalSpace(3.h),
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 16.7.h,
                                    width: 16.7.h,
                                    child: const CircularProgressIndicator(
                                      backgroundColor: Colors.yellow,
                                      value: 1.0, // full circle
                                      strokeWidth: 5,
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xffFFC542)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.7.h,
                                    width: 16.7.h,
                                    child: const CircularProgressIndicator(
                                      value: 0.5, // 70% of the circle
                                      strokeWidth: 5,
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xff0062FF)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.7.h,
                                    width: 16.7.h,
                                    child: const CircularProgressIndicator(
                                      value: 0.1, // 40% of the circle
                                      strokeWidth: 5,
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xff3DD598)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6.h,
                                    left: 2.h,
                                    right: 2.h,
                                    child: Column(
                                      children: [
                                        Text(
                                          '22.870',
                                          style: TextStyle(
                                            fontSize: 20.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff171725),
                                          ),
                                        ),
                                        Text(
                                          'Visitors this year',
                                          style: TextStyle(
                                            fontSize: 10.px,
                                            fontFamily: 'regular',
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff696974),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              getVerticalSpace(2.8.h),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 11,
                                        width: 13,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: const Color(0xff0062FF)),
                                      ),
                                      getHorizentalSpace(1.h),
                                      Text(
                                        'Basic',
                                        style: TextStyle(
                                            color: const Color(0xff44444F),
                                            fontSize: 15.px,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'regular'),
                                      ),
                                      getHorizentalSpace(2.h),
                                      Text(
                                        '2.1k',
                                        style: TextStyle(
                                            color: const Color(0xff44444F),
                                            fontSize: 15.px,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'bold'),
                                      ),
                                    ],
                                  ),
                                  getHorizentalSpace(3.5.h),
                                  Row(
                                    children: [
                                      Container(
                                        height: 11,
                                        width: 13,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: const Color(0xffFF974A)),
                                      ),
                                      getHorizentalSpace(1.h),
                                      Text(
                                        'Standard',
                                        style: TextStyle(
                                            color: const Color(0xff44444F),
                                            fontSize: 15.px,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'regular'),
                                      ),
                                      getHorizentalSpace(2.h),
                                      Text(
                                        '1k',
                                        style: TextStyle(
                                            color: const Color(0xff44444F),
                                            fontSize: 15.px,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'bold'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              getVerticalSpace(1.1.h),
                              Row(
                                children: [
                                  Container(
                                    height: 11,
                                    width: 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.h),
                                        color: const Color(0xff3DD598)),
                                  ),
                                  getHorizentalSpace(1.h),
                                  Text(
                                    'Pro',
                                    style: TextStyle(
                                        color: const Color(0xff44444F),
                                        fontSize: 15.px,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'regular'),
                                  ),
                                  getHorizentalSpace(2.h),
                                  Text(
                                    '1.9k',
                                    style: TextStyle(
                                        color: const Color(0xff44444F),
                                        fontSize: 15.px,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'bold'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                  getVerticalSpace(10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
