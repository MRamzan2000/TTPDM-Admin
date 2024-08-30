import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../super_admin/business_details.dart';

class BusinessTabBar extends StatefulWidget {
  const BusinessTabBar({super.key});

  @override
  State<BusinessTabBar> createState() => _BusinessTabBarState();
}

class _BusinessTabBarState extends State<BusinessTabBar> {
  final RxInt selectedIndex = 0.obs;
late GetBusinessController getBusinessController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusinessController=Get.put(GetBusinessController(context: context));
    getBusinessController.fetchBusinessByStatus(context: context,
        isLoad: getBusinessController.pendingBusiness.value==null,
        status: 'pending');
  }
  @override
  Widget build(BuildContext context) {

    final RxString isSelected = 'Pending'.obs;
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
        child: Obx(
          () => Column(
            children: [
              Container(
                color: const Color(0xffE0E0DF),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {

                        isSelected.value = 'Pending';
                        getBusinessController.fetchBusinessByStatus(context: context,
                            isLoad: getBusinessController.pendingBusiness.value==null,
                            status: 'pending');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.symmetric(vertical: 1.2.h),
                        color: isSelected.value == 'Pending'
                            ? AppColors.mainColor
                            : Colors.transparent,
                        child: Text(
                          'Pending',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 12.px,
                              color: isSelected.value == 'Pending'
                                  ? AppColors.whiteColor
                                  : const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isSelected.value = 'Approved';
                        getBusinessController.fetchBusinessByStatus(context: context,
                            isLoad: getBusinessController.approvedBusiness.value==null,
                            status: 'approved');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.2.h),
                        color: isSelected.value == 'Approved'
                            ? AppColors.mainColor
                            : Colors.transparent,
                        child: Text(
                          'Approved',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 12.px,
                              color: isSelected.value == 'Approved'
                                  ? AppColors.whiteColor
                                  : const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isSelected.value = 'Rejected';
                        getBusinessController.fetchBusinessByStatus(context: context,
                            isLoad: getBusinessController.rejectedBusinesses.value==null,
                            status: 'rejected');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.2.h),
                        color: isSelected.value == 'Rejected'
                            ? AppColors.mainColor
                            : Colors.transparent,
                        child: Text(
                          'Rejected',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 12.px,
                              color: isSelected.value == 'Rejected'
                                  ? AppColors.whiteColor
                                  : const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              getVerticalSpace(2.4.h),
        isSelected.value == 'Pending'?
              getBusinessController.isLoading.value?
              Expanded(
                child: ListView.builder(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.baseColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.2.h),
                        padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                            vertical: 4.0.h),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h)
                        ),

                      ),
                    );
                  },),
              ):getBusinessController.pendingBusiness.value!.businesses.isEmpty?
              Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ getVerticalSpace(20.h),
            Align(alignment: Alignment.bottomCenter,
              child: Text(
                "No Pending Business",
                style: TextStyle(
                  fontSize: 18.px,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'bold',
                ),
              ),
            ),
          ],
        ):
              Expanded(
                child: ListView.builder(shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                  itemCount: getBusinessController.pendingBusiness.value!.businesses.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(onTap: (){
                      Get.to(()=> BusinessAdmin(
                        businessName: getBusinessController.pendingBusiness.value!.businesses[index].name,
                        phoneNumber:  getBusinessController.pendingBusiness.value!.businesses[index].phone,
                        location:  getBusinessController.pendingBusiness.value!.businesses[index].location,
                        targetArea:  getBusinessController.pendingBusiness.value!.businesses[index].targetMapArea,
                        description:  getBusinessController.pendingBusiness.value!.businesses[index].description,
                        businessId:  getBusinessController.pendingBusiness.value!.businesses[index].id,
                        imagesList:  getBusinessController.pendingBusiness.value!.businesses[index].gallery,
                        logo:  getBusinessController.pendingBusiness.value!.businesses[index].logo,
                
                        webUrl:  getBusinessController.pendingBusiness.value!.businesses[index].websiteUrl,
                        fb:  getBusinessController.pendingBusiness.value!.businesses[index].facebookUrl,
                        insta:  getBusinessController.pendingBusiness.value!.businesses[index].instagramUrl,
                        tiktok:  getBusinessController.pendingBusiness.value!.businesses[index].tiktokUrl,
                        linkdin:  getBusinessController.pendingBusiness.value!.businesses[index].linkedinUrl,
                
                      ));
                    },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.2.h),
                        padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                            vertical: 2.0.h),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h)
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getBusinessController.pendingBusiness.value!.businesses[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: const Color(0xff282827)
                              ),),
                
                            Icon(Icons.arrow_forward_ios_sharp,
                              size: 2.4.h,color:
                              const Color(0xff191918),)
                          ],
                        ),
                      ),
                    );
                  },),
              ):
        isSelected.value == 'Approved'?
              getBusinessController.isLoading.value?
              Expanded(
                child: ListView.builder(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.baseColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.2.h),
                        padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                            vertical: 4.0.h),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h)
                        ),

                      ),
                    );
                  },),
              ):
              getBusinessController.approvedBusiness.value!.businesses.isEmpty?
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getVerticalSpace(20.h),
                  Align(alignment: Alignment.bottomCenter,
                    child: Text(
                      "No Approved Business",
                      style: TextStyle(
                        fontSize: 18.px,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold',
                      ),
                    ),
                  ),
                ],
              ):
              ListView.builder(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                itemCount: getBusinessController.approvedBusiness.value!.businesses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    Get.to(()=> BusinessAdmin(
                      businessName: getBusinessController.approvedBusiness.value!.businesses[index].name,
                      phoneNumber:  getBusinessController.approvedBusiness.value!.businesses[index].phone,
                      location:  getBusinessController.approvedBusiness.value!.businesses[index].location,
                      targetArea:  getBusinessController.approvedBusiness.value!.businesses[index].targetMapArea,
                      description:  getBusinessController.approvedBusiness.value!.businesses[index].description,
                      businessId:  getBusinessController.approvedBusiness.value!.businesses[index].id,
                      imagesList:  getBusinessController.approvedBusiness.value!.businesses[index].gallery,
                      logo:  getBusinessController.approvedBusiness.value!.businesses[index].logo,

                      webUrl:  getBusinessController.approvedBusiness.value!.businesses[index].websiteUrl,
                      fb:  getBusinessController.approvedBusiness.value!.businesses[index].facebookUrl,
                      insta:  getBusinessController.approvedBusiness.value!.businesses[index].instagramUrl,
                      tiktok:  getBusinessController.approvedBusiness.value!.businesses[index].tiktokUrl,
                      linkdin:  getBusinessController.approvedBusiness.value!.businesses[index].linkedinUrl,

                    ));
                  },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1.2.h),
                      padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                          vertical: 2.0.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1.h)
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getBusinessController.approvedBusiness.value!.businesses[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 14.px,
                                color: const Color(0xff282827)
                            ),),

                          Icon(Icons.arrow_forward_ios_sharp,
                            size: 2.4.h,color:
                            const Color(0xff191918),)
                        ],
                      ),
                    ),
                  );
                },):
              getBusinessController.isLoading.value?
              Expanded(
                child: ListView.builder(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.baseColor,
                      highlightColor: AppColors.baseColor,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.2.h),
                        padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                            vertical: 4.0.h),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h)
                        ),

                      ),
                    );
                  },),
              ):
              getBusinessController.rejectedBusinesses.value!.businesses.isEmpty?
              Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ getVerticalSpace(20.h),
                  Align(alignment: Alignment.center,
                    child: Text(
                      "No Rejected Business",
                      style: TextStyle(
                        fontSize: 18.px,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold',
                      ),
                    ),
                  ),
                ],
              ):
              ListView.builder(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                itemCount: getBusinessController.rejectedBusinesses.value!.businesses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    Get.to(()=> BusinessAdmin(
                      businessName: getBusinessController.rejectedBusinesses.value!.businesses[index].name,
                      phoneNumber:  getBusinessController.rejectedBusinesses.value!.businesses[index].phone,
                      location:  getBusinessController.rejectedBusinesses.value!.businesses[index].location,
                      targetArea:  getBusinessController.rejectedBusinesses.value!.businesses[index].targetMapArea,
                      description:  getBusinessController.rejectedBusinesses.value!.businesses[index].description,
                      businessId:  getBusinessController.rejectedBusinesses.value!.businesses[index].id,
                      imagesList:  getBusinessController.rejectedBusinesses.value!.businesses[index].gallery,
                      logo:  getBusinessController.rejectedBusinesses.value!.businesses[index].logo,

                      webUrl:  getBusinessController.rejectedBusinesses.value!.businesses[index].websiteUrl,
                      fb:  getBusinessController.rejectedBusinesses.value!.businesses[index].facebookUrl,
                      insta:  getBusinessController.rejectedBusinesses.value!.businesses[index].instagramUrl,
                      tiktok:  getBusinessController.rejectedBusinesses.value!.businesses[index].tiktokUrl,
                      linkdin:  getBusinessController.rejectedBusinesses.value!.businesses[index].linkedinUrl,

                    ));
                  },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1.2.h),
                      padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                          vertical: 2.0.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1.h)
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getBusinessController.rejectedBusinesses.value!.businesses[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 14.px,
                                color: const Color(0xff282827)
                            ),),

                          Icon(Icons.arrow_forward_ios_sharp,
                            size: 2.4.h,color:
                            const Color(0xff191918),)
                        ],
                      ),
                    ),
                  );
                },)

            ],
          ),
        ),
      ),
    );
  }

}
