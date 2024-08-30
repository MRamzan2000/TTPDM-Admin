import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_campaign_controller.dart';

import 'campaign_details.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  final RxList<String>profilesList=<String>['Campaign name','Campaign name',
    'Campaign name'].obs;
late AddCampaignController addCampaignController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    addCampaignController=Get.put(AddCampaignController());
    addCampaignController.fetchCampaignByStatus(context: context,
        isLoad: addCampaignController.pendingCampaigns.value ==null
        , status: 'pending');
  }
  @override
  Widget build(BuildContext context) {
    final RxString isSelected = 'Pending'.obs;

    return  Scaffold(
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
        child: Obx(()=> Column(
            children: [
              Container(
                color: const Color(0xffE0E0DF),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isSelected.value = 'Pending';
                        addCampaignController.fetchCampaignByStatus(context: context,
                            isLoad: addCampaignController.pendingCampaigns.value ==null
                            , status: 'pending');
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
                        isSelected.value = 'Posted';
                        addCampaignController.fetchCampaignByStatus(context: context,
                            isLoad: addCampaignController.pendingCampaigns.value ==null
                            , status: 'approved');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.2.h),
                        color: isSelected.value == 'Posted'
                            ? AppColors.mainColor
                            : Colors.transparent,
                        child: Text(
                          'Posted',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 12.px,
                              color: isSelected.value == 'Posted'
                                  ? AppColors.whiteColor
                                  : const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        isSelected.value = 'Cancelled';
                        addCampaignController.fetchCampaignByStatus(context: context,
                            isLoad: addCampaignController.pendingCampaigns.value ==null
                            , status: 'rejected');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.2.h),
                        color: isSelected.value == 'Cancelled'
                            ? AppColors.mainColor
                            : Colors.transparent,
                        child: Text(
                          'Cancelled',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: 12.px,
                              color: isSelected.value == 'Cancelled'
                                  ? AppColors.whiteColor
                                  : const Color(0xff7C7C7C),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2.4.h),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    getVerticalSpace(2.4.h),
                    isSelected.value == 'Pending'?addCampaignController.isLoading.value?
                 ListView.builder(shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: profilesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: (){
                          Get.to(()=> CampaignDetails());
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
                                Text(profilesList[index],
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
                 addCampaignController.pendingCampaigns.value==null?
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Text(
                     "No Pending Campaign",
                     style: TextStyle(
                       fontSize: 18.px,
                       color: AppColors.mainColor,
                       fontWeight: FontWeight.w500,
                       fontFamily: 'bold',
                     ),
                   ),
                 ):  ListView.builder(shrinkWrap: true,
                   padding: EdgeInsets.zero,
                   itemCount: addCampaignController.pendingCampaigns.value!.campaigns.length,
                   itemBuilder: (context, index) {
                     return GestureDetector(onTap: (){
                       Get.to(()=> CampaignDetails());
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
                             Text(addCampaignController.pendingCampaigns.value!.campaigns[index].adsName,
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
                    isSelected.value == 'Posted'?
                    addCampaignController.isLoading.value?
                    ListView.builder(shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: profilesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: (){
                          Get.to(()=> CampaignDetails());
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
                                Text(profilesList[index],
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
                    addCampaignController.previousCampaigns.value==null?
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "No Pending Campaign",
                        style: TextStyle(
                          fontSize: 18.px,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold',
                        ),
                      ),
                    ):
                    ListView.builder(shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: addCampaignController.previousCampaigns.value!.campaigns.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: (){
                          Get.to(()=> CampaignDetails());
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
                                Text(addCampaignController.pendingCampaigns.value!.campaigns[index].adsName,
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
                    addCampaignController.isLoading.value?
                    ListView.builder(shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: profilesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: (){
                          Get.to(()=> CampaignDetails());
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
                                Text(profilesList[index],
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
                    addCampaignController.upcomingCampaigns.value==null?
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "No Pending Campaign",
                        style: TextStyle(
                          fontSize: 18.px,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold',
                        ),
                      ),
                    ):
                    ListView.builder(shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: addCampaignController.upcomingCampaigns.value!.campaigns.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: (){
                          Get.to(()=> CampaignDetails());
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
                                Text(addCampaignController.upcomingCampaigns.value!.campaigns[index].adsName,
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
                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
