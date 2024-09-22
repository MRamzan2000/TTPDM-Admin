import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_request_controller.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

import '../../../controller/getx_controllers/get_business_controller.dart';
import 'business_profile_detail.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  late DesignRequestController designRequestController;
  final RxString id = "".obs;
  final RxString name = "".obs;
  late GetBusinessController getBusinessController;

  @override
  void initState() {
    super.initState();
    getBusinessController = Get.put(GetBusinessController(context: context));

    designRequestController = Get.put(DesignRequestController());
    id.value = MySharedPreferences.getString(userId);
    name.value = MySharedPreferences.getString(userName);
    designRequestController.fetchDesignRequest(
        loading: designRequestController.getDesignRequest.isEmpty);
    log("${designRequestController.getDesignRequest.isEmpty}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Designs',
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
              getVerticalSpace(2.4.h),
              Obx(
                () => designRequestController.isLoading.value
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: AppColors.baseColor,
                            highlightColor: AppColors.highlightColor,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 1.2.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.6.h, vertical: 2.0.h),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(1.h)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "'",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                        fontSize: 14.px,
                                        color: const Color(0xff282827)),
                                  ),
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
                      )
                    : designRequestController.getDesignRequest.isEmpty
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No designs request found",
                                      style: TextStyle(
                                        fontSize: 18.px,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: designRequestController
                                  .getDesignRequest.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => BusinessProfile(
                                          businessName: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .name,
                                          phoneNumber: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .phone,
                                          location: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .location,
                                          targetArea: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .targetMapArea,
                                          description: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .description,
                                          businessId: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .id,
                                          imagesList: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .gallery,
                                          logo: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .logo,
                                          webUrl: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .websiteUrl,
                                          fb: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .facebookUrl,
                                          insta: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .instagramUrl,
                                          tiktok: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .tiktokUrl,
                                          linkdin: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .linkedinUrl,
                                          title: 'new',
                                          ownerId: designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .owner,
                                          status: "design",
                                          id: id.value,
                                          currentUserName: name.value,
                                        ));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 1.2.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.6.h, vertical: 2.0.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(1.h)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          designRequestController
                                              .getDesignRequest[index]!
                                              .business
                                              .name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'bold',
                                              fontSize: 14.px,
                                              color: const Color(0xff282827)),
                                        ),
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
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
