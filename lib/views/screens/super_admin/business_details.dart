import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_fcm_send_notification_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
class BusinessAdmin extends StatefulWidget {
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
  final String ownerId;
  const BusinessAdmin(
      {super.key,
      this.title,
      required this.businessName,
      required this.phoneNumber,
      required this.location,
      required this.targetArea,
      required this.description,
      required this.businessId,
      required this.imagesList,
      required this.logo,
      required this.webUrl,
      required this.fb,
      required this.insta,
      required this.tiktok,
      required this.linkdin, required this.ownerId});

  @override
  State<BusinessAdmin> createState() => _BusinessAdminState();
}

class _BusinessAdminState extends State<BusinessAdmin> {
  final AddDesignController addDesignController =
      Get.put(AddDesignController());
  late GetBusinessController getBusinessController;
  RxString token = "".obs;
  RxString id = "".obs;
  RxString name = "".obs;
  late GetFcmTokenSendNotificationController getFcmTokenSendNotificationController;

  @override
  void initState() {
    super.initState();
    getBusinessController = Get.put(GetBusinessController(context: context));
    getFcmTokenSendNotificationController=Get.put(GetFcmTokenSendNotificationController(context: context));
    token.value = MySharedPreferences.getString(authToken);
    id.value = MySharedPreferences.getString(authToken);
    name.value = MySharedPreferences.getString(userName);
    log("Auth Token is that :${token.value}");
  }
  @override
  Widget build(BuildContext context) {
    log("${widget.title}");
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
          widget.businessName,
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
                            backgroundImage: NetworkImage(widget.logo),
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
                      widget.businessName,
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
                      widget.phoneNumber,
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
                      widget.location,
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
                      widget.targetArea,
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
                      widget.description,
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
                        itemCount: widget.imagesList.length,
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
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.imagesList[index])),
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
                    widget.title == "rejected"
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "Business was Rejected",
                              style: CustomTextStyles.onBoardingHeading
                                  .copyWith(fontSize: 16.px),
                            ),
                          )
                        : widget.title == "accepted"
                            ? Column(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "Business was Approved",
                                      style: CustomTextStyles.onBoardingHeading
                                          .copyWith(
                                              fontSize: 14.px,
                                              color: AppColors.blackColor),
                                    ),
                                  ),
                                  getVerticalSpace(1.h),
              Obx(() => Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: customElevatedButton(
                        onTap: () {
                          log("widget.businessId :${widget.businessId}");
                          getBusinessController.businessManageRequest(
                            token: token.value,
                            businessId: widget.businessId,
                          ).then((value) {
                            getFcmTokenSendNotificationController
                                .fetchFcmToken(
                                loading:
                                getFcmTokenSendNotificationController
                                    .fcmToken.value ==
                                    null,
                                userId: "66edbd3bbfa32fafa2a4ebb3",
                                token: token.value,
                                title: "Request",
                                message: "${name.value}Business Manage Request",
                                info1: "id ${id.value}",
                                info2: "");
                          },);
                        },
                        horizentalPadding: 0,
                        title: getBusinessController.businessManageLoader.value
                            ? spinkit
                            : Text(
                          "Request for manage",
                          style: CustomTextStyles.buttonTextStyle,
                        ),
                        bgColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              )),

              ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: customElevatedButton(
                                        onTap: () {
                                          openRejectReason(context,
                                              token: token.value,
                                              businessId: widget.businessId, ownerId: widget.ownerId, id: id.value);
                                        },
                                        horizentalPadding: 0,
                                        title: Text(
                                          "Reject",
                                          style:
                                              CustomTextStyles.buttonTextStyle,
                                        ),
                                        bgColor: const Color(0xff999999)),
                                  ),
                                  getHorizentalSpace(1.8.h),
                                  Expanded(
                                    child: Obx(
                                      () => customElevatedButton(
                                          onTap: () {
                                            getBusinessController
                                                .changeBusinessStatus(
                                                    token: token.value,
                                                    businessId:
                                                        widget.businessId,
                                                    status: "accepted",
                                                    rejectionReason: "Approved")
                                                .then(
                                              (value) {

                                                getFcmTokenSendNotificationController
                                                    .fetchFcmToken(
                                                    loading:
                                                    getFcmTokenSendNotificationController
                                                        .fcmToken.value ==
                                                        null,
                                                    userId: widget.ownerId,
                                                    token: token.value,
                                                    title: "Congratulation",
                                                    message: "${name.value}Business Was Approved",
                                                    info1: "id ${id.value}",
                                                    info2: "");
                                              },
                                            );
                                            log("businessId :${widget.businessId}");
                                          },
                                          horizentalPadding: 0,
                                          title: getBusinessController
                                                  .approvedLoader.value
                                              ? spinkit
                                              : Text(
                                                  "Approve",
                                                  style: CustomTextStyles
                                                      .buttonTextStyle,
                                                ),
                                          bgColor: AppColors.mainColor),
                                    ),
                                  )
                                ],
                              ),
                    getVerticalSpace(4.h)
                  ]),
            ),
          )),
    );
  }
}
