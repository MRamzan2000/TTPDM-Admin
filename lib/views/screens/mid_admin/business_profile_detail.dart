import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_request_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_fcm_send_notification_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/image_picker_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/poster_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

class BusinessProfile extends StatefulWidget {
  final String title;
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
  final String status;
  final String id;
  final String currentUserName;
  const BusinessProfile({
    super.key,
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
    required this.linkdin,
    required this.title,
    required this.ownerId,
    required this.status,
    required this.id,
    required this.currentUserName,
  });

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final AddDesignController addDesignController =
      Get.put(AddDesignController());

  final List<String> items = ["View Changes", "Re-upload", "Delete"];
  final List<String> images = [
    'assets/pngs/uploaddesign1.png',
    'assets/pngs/uploaddesign2.png',
    'assets/pngs/uploaddesign3.png',
  ];

  late GetBusinessController getBusinessController;
  late PosterController posterController;
  late DesignRequestController designRequestController;

  RxString token = "".obs;
  RxString id = "".obs;
  late GetFcmTokenSendNotificationController
      getFcmTokenSendNotificationController;
  late ImagePickerController imagePickerController;
  @override
  void initState() {
    super.initState();
    getBusinessController = Get.put(GetBusinessController(context: context));
    getFcmTokenSendNotificationController =
        Get.put(GetFcmTokenSendNotificationController(context: context));
    imagePickerController = Get.put(ImagePickerController());
    posterController = Get.put(PosterController(context: context));
    designRequestController = Get.put(DesignRequestController());
    posterController.fetchPosters(
        context: context, loading: posterController.allPosters.value == null);
    token.value = MySharedPreferences.getString(authToken);
    id.value = MySharedPreferences.getString(userId);
    log("Auth Token is that :${widget.status}");
  }

  @override
  Widget build(BuildContext context) {
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
                getVerticalSpace(2.h),
                getVerticalSpace(1.6.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 4.2.h,
                        backgroundImage: NetworkImage(widget.logo, scale: 1.0),
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
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  widget.businessName,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  widget.phoneNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  widget.location,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Target Map Area',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  widget.targetArea,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Business description',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
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
                        color: const Color(0xff282827),
                      ),
                    ),
                  ],
                ),
                getVerticalSpace(1.2.h),
                widget.imagesList.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                            color: AppColors.baseColor),
                        height: 30.3.h,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.imagesList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 2.h,
                            crossAxisSpacing: 3.w,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 11.3.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1.h),
                                    color: AppColors.whiteColor,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          widget.imagesList[index],
                                        ),
                                        fit: BoxFit.cover,
                                        scale: 1.0),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                getVerticalSpace(2.4.h),
                widget.title == "pending"
                    ? const SizedBox.shrink()
                    : Text(
                        'Upload Design',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          fontSize: 14.px,
                          color: AppColors.mainColor,
                        ),
                      ),
                getVerticalSpace(1.h),
                widget.title == "pending"
                    ? const SizedBox.shrink()
                    : Obx(
                        () => posterController.isLoading.value
                            ? SizedBox(
                                height: 14.h,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        3, // Number of items in a row
                                    crossAxisSpacing:
                                        8.0, // Space between items horizontally
                                    mainAxisSpacing:
                                        8.0, // Space between items vertically
                                    childAspectRatio:
                                        1, // Aspect ratio for each item
                                  ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: AppColors.baseColor,
                                      highlightColor: AppColors.highlightColor,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                              blurRadius: 8,
                                              color: Color(0xffFFE4EA),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : posterController.allPosters.value!.designs.isEmpty
                                ? Column(
                                    children: [
                                      Text(
                                        "No Design Available",
                                        style: CustomTextStyles.buttonTextStyle
                                            .copyWith(
                                                color: AppColors.mainColor),
                                      )
                                    ],
                                  )
                                : Container(
                                    padding: EdgeInsets.all(1.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.baseColor,
                                      borderRadius: BorderRadius.circular(2.h),
                                    ),
                                    height: 30.h,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            3, // Number of items in a row
                                        crossAxisSpacing:
                                            8.0, // Space between items horizontally
                                        mainAxisSpacing:
                                            8.0, // Space between items vertically
                                        childAspectRatio:
                                            1, // Aspect ratio for each item
                                      ),
                                      itemCount: posterController
                                          .allPosters.value!.designs
                                          .where((design) =>
                                              design.businessId ==
                                              widget.businessId)
                                          .length,
                                      itemBuilder: (context, index) {
                                        // Create the filtered designs list
                                        final filteredDesigns = posterController
                                            .allPosters.value!.designs
                                            .where((design) =>
                                                design.businessId ==
                                                widget.businessId)
                                            .toList();

                                        return Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: Colors.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          offset: Offset(0, 1),
                                                          spreadRadius: 0,
                                                          blurRadius: 8,
                                                          color:
                                                              Color(0xffFFE4EA),
                                                        ),
                                                      ],
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          filteredDesigns[index]
                                                              .fileUrl,
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                filteredDesigns[index]
                                                            .likeCount >
                                                        0
                                                    ? SizedBox(
                                                        height: 3.h,
                                                        width: 7.h,
                                                        child: const Image(
                                                          image: AssetImage(
                                                              'assets/pngs/like.png'),
                                                        ),
                                                      )
                                                    : filteredDesigns[index]
                                                                .dislikeCount >
                                                            0
                                                        ? SizedBox(
                                                            height: 3.h,
                                                            width: 7.h,
                                                            child: const Image(
                                                              image: AssetImage(
                                                                  'assets/pngs/dislike.png'),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                      ),
                getVerticalSpace(2.h),
                widget.title == "pending"
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () {
                          openCampaignSubmit(context,
                              token: token.value, ownerId:widget.ownerId,
                              currentUserName: widget.currentUserName, id: id.value, businessId: widget.businessId);
                          // imagePickerController.pickImage(ImageSource.gallery);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15.h,
                              width: 15.h,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(2.h),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 3.h,
                                    Icons.add,
                                    color: AppColors.mainColor,
                                  ),
                                  Text(
                                    'Upload',
                                    style: CustomTextStyles.buttonTextStyle
                                        .copyWith(color: AppColors.mainColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                widget.title == "pending"
                    ? const SizedBox.shrink()
                    : getVerticalSpace(2.h),
                widget.title == "pending"
                    ? Row(
                        children: [
                          Expanded(
                            child: customElevatedButton(
                                onTap: () {
                                  openRejectReason(context,
                                      token: token.value,
                                      businessId: widget.businessId,
                                      ownerId: widget.ownerId,
                                      id: id.value);
                                },
                                horizentalPadding: 0,
                                title: Text(
                                  "Reject",
                                  style: CustomTextStyles.buttonTextStyle,
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
                                            businessId: widget.businessId,
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
                                                message:
                                                    "Business Was Approved",
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
                                          style:
                                              CustomTextStyles.buttonTextStyle,
                                        ),
                                  bgColor: AppColors.mainColor),
                            ),
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
                getVerticalSpace(2.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
