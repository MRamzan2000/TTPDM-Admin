
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_campaign_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_fcm_send_notification_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';


class CampaignDetails  extends StatefulWidget {
  final String campaignId;
  final String businessName;
  final String campaignName;
  final String campaignDescription;
  final String selectedPoster;
  final List campaignPlatForms;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String token;
  final String status;
  final String id;
  final String ownerID;
  final String name;
   const CampaignDetails ({
     super.key,
     required this.campaignId,
     required this.campaignName,
     required this.campaignDescription,
     required this.selectedPoster,
     required this.campaignPlatForms,
     required this.startDate,
     required this.endDate,
     required this.businessName,
     required this.token, required this.status, required this.startTime, required this.endTime, required this.id, required this.name, required this.ownerID
   });

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  final List<String> items = [
    'Cancel',
  ];

   final AddDesignController addDesignController =Get.put(AddDesignController());
   late AddCampaignController addCampaignController ;
  late GetFcmTokenSendNotificationController
  getFcmTokenSendNotificationController;
@override
  void initState() {
    super.initState();
    addCampaignController =Get.put(AddCampaignController(context: context));
    getFcmTokenSendNotificationController =
        Get.put(GetFcmTokenSendNotificationController(context: context));
}
   @override
  Widget build(BuildContext context) {
    String range = '';
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){
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
          'Campaign Name',
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
          padding:  EdgeInsets.symmetric(horizontal: 2.5.h),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  getVerticalSpace(2.4.h),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 1.2.h),
                    padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                        vertical: 2.0.h),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1.h)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Campaign details',
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),

                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.h)
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ad Banner',style: TextStyle(
                                fontSize: 14.px,
                                fontFamily: 'bold',
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff191918)
                            ),),
                            RichText(text: TextSpan(children: [
                              TextSpan(text: 'Status: ',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffFF9500),
                                fontSize: 13.px,
                                fontFamily: 'regular'
                              )),
                              TextSpan(text: '${widget.status}: ',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff999999),
                                fontSize: 13.px,
                                fontFamily: 'regular'
                              )),
                            ]))
                          ],
                        ),
                        getVerticalSpace(.5.h),
                        Container(
                          height: 24.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h)
                              ,image:  DecorationImage(image: NetworkImage(widget.selectedPoster),fit: BoxFit.cover)
                          ),

                        ),
                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D),
                          thickness: 1,),
                        getVerticalSpace(1.2.h),
                        Text('Business Profile',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(.8.h),
                        Text(widget.businessName,style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6E6D)
                        ),),
                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D),
                          thickness: 1,),
                        Text('Ads Name',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(.8.h),
                        Text(widget.campaignName,style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6E6D)
                        ),),
                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D),
                          thickness: 1,),
                        getVerticalSpace(1.2.h),
                        Text('What’s the business name?',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(.8.h),
                        Text(widget.businessName,style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6E6D)
                        ),),

                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D),
                          thickness: 1,),
                        getVerticalSpace(1.2.h),
                        Text('Campaign Descriptions',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        Text(widget.campaignDescription,style: TextStyle(
                            fontSize: 12.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w400,
                            color: const  Color(0xff6E6E6D)
                        ),),
                        getVerticalSpace(2.4.h),
                        getVerticalSpace(1.2.h),
                        Text('Campaign Platform ',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(.8.h),
                    Wrap(
                      spacing: 8.0, // Horizontal spacing between items
                      runSpacing: 4.0, // Vertical spacing between lines
                      children: widget.campaignPlatForms.map((platform) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            platform,
                            style: TextStyle(
                              fontSize: 14, // Flutter uses logical pixels; adjust as needed
                              fontFamily: 'bold',
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor, // Ensure this is defined in your AppColors
                            ),
                          ),
                        );
                      }).toList(),),
                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D)),
                        getVerticalSpace(1.2.h),
                        Text('Date Schedule',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(1.2.h),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 2.4.h,
                                  width: 2.4.h,
                                  child: const Image(
                                    image: AssetImage('assets/pngs/dateicon.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: .8.h),
                                Text(
                                  range.isNotEmpty ? range : widget.startDate+widget.endDate,
                                  style: TextStyle(
                                    color: range.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'bold',
                                    fontSize: 12.px,
                                  ),
                                ),

                              ],
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                        const Divider(color: Color(0xff6E6E6D)),
                        getVerticalSpace(1.2.h),
                        Text('Time Duration',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(1.2.h),
                        Text(
                          range.isNotEmpty ? range : 'From ${widget.startDate+widget.endDate}',
                          style: TextStyle(
                            color: range.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'bold',
                            fontSize: 12.px,
                          ),
                        ),





                      ],),
                  ),
                  widget.status == "pending"||widget.status == "rejected"
                      ?const SizedBox.shrink():    Text(
                    'Add Analysis ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold',
                        fontSize: 14.px,
                        color: AppColors.mainColor),
                  ),
                  getVerticalSpace(1.6.h),
                  widget.status == "pending"||widget.status == "rejected"
                      ?const SizedBox.shrink():    GestureDetector(onTap: (){
                    addAnalytics(context,
                        campaignId: widget.campaignId,
                        token: widget.token,
                        ownerId: widget.ownerID, ownerName:widget.name);
                  },
                    child: Container(
                      alignment: Alignment.center,
                      height: 23.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(size: 4.h,
                            Icons.add,
                            color: AppColors.mainColor,
                          ),
                          Text('Add',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),)
                        ],
                      ),
                    ),
                  ),getVerticalSpace(4.h),
                  widget.status == "rejected" ? Align(alignment: Alignment.bottomCenter,
                    child: Text("Campaign was Rejected",style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 16.px),
                    ),
                  )
                      : widget.status == "approved"
                      ? Align(alignment: Alignment.bottomCenter,
                    child: Text(
                      "Campaign was Approved",
                      style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 16.px),
                    ),
                  ):
                  Obx(() =>
                   Row(
                      children: [
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                openCampaignStatus(context,
                                    token: widget.token,
                                    campaignId:widget.campaignId, ownerId: widget.ownerID);
                              },
                              horizentalPadding: 0,
                              title:addCampaignController.rejectLoader.value?spinkit: Text(
                                "Reject",
                                style: CustomTextStyles.buttonTextStyle,
                              ),
                              bgColor: const Color(0xff999999)),
                        ),
                        getHorizentalSpace(1.8.h),
                        Expanded(
                          child: customElevatedButton(
                                onTap: () {
                                  log("campaign id :${widget.campaignId}");
                                  addCampaignController.changeCampaignStatus(
                                      token: widget.token,
                                      campaignId: widget.campaignId,
                                      status: "approved", rejectionReason: "Approved").then((value) {
                                    getFcmTokenSendNotificationController
                                        .fetchFcmToken(
                                        loading:
                                        getFcmTokenSendNotificationController
                                            .fcmToken.value ==
                                            null,
                                        userId:widget.ownerID ,
                                        token:widget.token,
                                        title: "Congratulation",
                                        message: "Campaign Was Approved",
                                        info1: "",
                                        info2: "");
                                      },);
                                },
                                horizentalPadding: 0,
                                title:addCampaignController.approvedLoader.value?spinkit:
                                Text(
                                  "Approve",
                                  style: CustomTextStyles
                                      .buttonTextStyle,
                                ),
                                bgColor: AppColors.mainColor),



                        )
                      ],
                    ),
                  ),
                  getVerticalSpace(2.h)

                ]
            ),
          ),
        ),
      ),
    );
  }
}
