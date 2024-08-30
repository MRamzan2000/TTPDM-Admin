import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';

class BusinessAdmin extends StatelessWidget {
  final String? title;
  final String businessName;
  final String phoneNumber;
  final String location;
  final String targetArea;
  final String description;
  final String businessId;
  final List<String> imagesList;
  final String logo;
  final String webUrl;
  final String fb;
  final String insta;
  final String tiktok;
  final String linkdin;
  BusinessAdmin({
    super.key,
    this.title, required this.businessName, required this.phoneNumber, required this.location, required this.targetArea, required this.description, required this.businessId, required this.imagesList, required this.logo, required this.webUrl, required this.fb, required this.insta, required this.tiktok, required this.linkdin
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
         businessName,
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
                            backgroundImage: NetworkImage(logo),
                            // child: Text(
                            //   'Logo',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w700,
                            //       fontFamily: 'bold',
                            //       fontSize: 20.px,
                            //       color: const Color(0xffC3C3C2)),
                            // ),
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
                     businessName,
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
                      phoneNumber,
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
                    location,
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
                    targetArea,
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
                      description,
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
                        itemCount: imagesList.length,
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
                                  image: DecorationImage(image: NetworkImage(imagesList[index])),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                        color: Color(0xffFFE4EA))
                                  ]),
                            
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
                              title: Text(
                                'Reject',
                                style: CustomTextStyles.buttonTextStyle.copyWith(
                                    color:  AppColors.whiteColor, fontFamily: 'bold'),
                              ),
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
                              title: Text(
                                'Approve',
                                style: CustomTextStyles.buttonTextStyle.copyWith(
                                    color:  AppColors.whiteColor, fontFamily: 'bold'),
                              ),
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
