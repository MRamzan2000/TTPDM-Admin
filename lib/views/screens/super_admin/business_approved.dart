import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

class BusinessApproval extends StatefulWidget {
  const BusinessApproval({super.key});
  @override
  State<BusinessApproval> createState() => _BusinessApprovalState();
}

class _BusinessApprovalState extends State<BusinessApproval> {
  final RxInt selectedIndex = 0.obs;
  late GetBusinessController getBusinessController;
  final RxString token="".obs;
  @override
  void initState() {
    super.initState();
    getBusinessController = Get.put(GetBusinessController(context: context));
    token.value=MySharedPreferences.getString(authToken);
    getBusinessController.fetchAllBusinessManageRequests(
        loading: getBusinessController.businessRequest.value==null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'ADVYRO',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => Column(
            children: [
              getVerticalSpace(2.4.h),
              getBusinessController.isLoading.value
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                      itemCount: 6,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getHorizentalSpace(3.h),
                                const Text(
                                  '',
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
                  : getBusinessController
                          .businessRequest.value==null
                      ? Center(
                          child: Text(
                            "No Business Request Found",
                            style: TextStyle(
                              fontSize: 18.px,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                            ),
                          ),
                        )
                      : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                            itemCount: getBusinessController
                                .businessRequest.value!.requests.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  manageApproval(context,
                                      midAdminName: getBusinessController
                                          .businessRequest.value!.requests[index].midAdmin.fullname,
                                      requestId: getBusinessController
                                          .businessRequest.value!.requests[index].id,
                                    midAdminId: getBusinessController
                                        .businessRequest.value!.requests[index].midAdmin.id, token: token.value ,
                                  );
                                  // Get.to(() => BusinessAdmin(
                                  //       title: 'SuperAdmin',
                                  //       businessName: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .name,
                                  //       phoneNumber: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .phone,
                                  //       location: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .location,
                                  //       targetArea: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .targetMapArea,
                                  //       description: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .description,
                                  //       businessId: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .id,
                                  //       imagesList: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .gallery,
                                  //       logo: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .logo,
                                  //       webUrl: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .websiteUrl,
                                  //       fb: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .facebookUrl,
                                  //       insta: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .instagramUrl,
                                  //       tiktok: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .tiktokUrl,
                                  //       linkdin: getBusinessController
                                  //           .businessRequest
                                  //           .value!
                                  //           .requests[index]
                                  //           .business
                                  //           .linkedinUrl,
                                  //     ));
                                },
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
                                        getBusinessController.businessRequest
                                            .value!.requests[index].business.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'bold',
                                            fontSize: 14.px,
                                            color: const Color(0xff282827)),
                                      ),
                                   const Expanded(child: SizedBox()),
                                      Text(
                                        getBusinessController
                                            .businessRequest
                                            .value!
                                            .requests[index]
                                            .status=="approved"?"Managed by ${ getBusinessController
                                            .businessRequest
                                            .value!
                                            .requests[index]
                                            .midAdmin
                                            .fullname.toString().substring(0,8)}..." :
                                             "Request By ${ getBusinessController
                                           .businessRequest
                                           .value!
                                           .requests[index]
                                           .midAdmin
                                           .fullname.toString().substring(0,8)}...",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'bold',
                                            fontSize: 12.px,
                                            color: AppColors.mainColor),
                                      ),
                                      getHorizentalSpace(2.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
