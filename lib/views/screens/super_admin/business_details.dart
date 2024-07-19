import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/add_design_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';

class BusinessAdmin extends StatelessWidget {
  final String? title;
  BusinessAdmin({
    super.key,
    this.title
  });
  final AddDesignController addDesignController =
      Get.put(AddDesignController());
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/pngs/itemfive.png',
      'assets/pngs/itemfour.png',
      'assets/pngs/itemthree.png',
      'assets/pngs/itemtwo.png'
    ];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 2.4.h,
            color: const Color(0xff191918),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Business Profile One',
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
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerticalSpace(2.4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.6.h, vertical: 2.0.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Business Profile Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 14.px,
                                color: const Color(0xff282827)),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up,
                            size: 2.6.h,
                            color: const Color(0xff191918),
                          )
                        ],
                      ),
                    ),
                    getVerticalSpace(1.6.h),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 4.2.h,
                            child: Text(
                              'Logo',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'bold',
                                  fontSize: 20.px,
                                  color: const Color(0xffC3C3C2)),
                            ),
                          ),
                          getVerticalSpace(.8.h),
                          Text(
                            'Logo',
                            style: TextStyle(
                                fontSize: 14.px,
                                color: const Color(0xff454544),
                                fontFamily: 'regular',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    getVerticalSpace(4.h),
                    Text(
                      'Business Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      'Video gaming',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.blackColor,
                          fontSize: 12.px),
                    ),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      '03316027450',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.blackColor,
                          fontSize: 12.px),
                    ),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      'Pakistan',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.blackColor,
                          fontSize: 12.px),
                    ),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Target Map Area',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      'Lahore',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.blackColor,
                          fontSize: 12.px),
                    ),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Business description',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.blackColor,
                          fontSize: 12.px),
                    ),
                    getVerticalSpace(1.6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                              fontSize: 14.px,
                              color: const Color(0xff282827)),
                        ),
                      ],
                    ),
                    getVerticalSpace(1.2.h),
                    SizedBox(
                      height: 30.3.h,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: images.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 2.1.h,
                            crossAxisSpacing: 1.6.h),
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: .5.h, vertical: .5.h),
                              height: 11.3.h,
                              width: 11.6.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.h),
                                  color: AppColors.whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                        color: Color(0xffFFE4EA))
                                  ]),
                              child: Image.asset(images[index]),
                            ),
                          ]);
                        },
                      ),
                    ),
                    getVerticalSpace(3.1.h),
                    Row(
                      children: [
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                openRejectReason(context);
                              },
                              title: 'Reject',
                              bgColor: const Color(0xff000000).withOpacity(0.3),
                              verticalPadding: .6.h,
                              horizentalPadding: 4.6.h),
                        ),
                        getHorizentalSpace(1.6.h),
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                if(title=='SuperAdmin'){
                                  manageApproval(context);
                                }
                              },
                              title: 'Approve',
                              bgColor:AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 2.h),
                        ),
                      ],
                    ),
                    getVerticalSpace(4.h)
                  ]),
            ),
          )),
    );
  }
}
