import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

import 'business_profile_detail.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RxList<String> profilesList = <String>[
    'Business Profile One',
    'Business Profile Two',
    'Business Profile Three'
  ].obs;
  final RxList<String> svgs = <String>[
    'assets/svgs/cancel.svg',
    'assets/svgs/ok.svg',
    'assets/svgs/new.svg'
  ].obs;
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
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 2.8.h,
                  backgroundImage: const AssetImage('assets/pngs/profile.png'),
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
                      child: svgImage('assets/svgs/midadminnotification.svg')),
                ),
              ),
              getVerticalSpace(1.h),
              Text(
                'Request Designs',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    fontSize: 14.px,
                    color: const Color(0xff191918)),
              ),
              getVerticalSpace(1.5.h),
              SizedBox(
                height: 12.2.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: index == 0 ? 0 : .8.h),
                      padding: EdgeInsets.symmetric(
                          vertical: 1.6.h, horizontal: .8.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 5.6.h,
                              width: 5.6.h,
                              child: const Image(
                                image: AssetImage('assets/pngs/designpng.png'),
                                fit: BoxFit.cover,
                              )),
                          getVerticalSpace(.8.h),
                          Text(
                            'The North face',
                            style: TextStyle(
                                fontSize: 12.px,
                                color: const Color(0xff191918),
                                fontFamily: 'bold',
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              getVerticalSpace(2.4.h),
              Text(
                'Businesses list ',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    fontSize: 14.px,
                    color: const Color(0xff191918)),
              ),
              getVerticalSpace(1.2.h),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: profilesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => BusinessProfile());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1.2.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.6.h, vertical: 2.0.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 2.h,
                                  width: 2.h,
                                  child: SvgPicture.asset(svgs[index])),
                              getHorizentalSpace(1.h),
                              Text(
                                profilesList[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'bold',
                                    fontSize: 14.px,
                                    color: const Color(0xff282827)),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Text('Managed by Mohsin',style: TextStyle(
                              fontWeight:FontWeight.w500,
                          fontSize: 12.px,
                          color: AppColors.mainColor,
                          fontFamily:'bold' ),),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 2.4.h,
                            color: const Color(0xff191918),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
