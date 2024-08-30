import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';


import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/getx_controllers/get_design_controller.dart';


class CampaignDetails  extends StatelessWidget {
   CampaignDetails ({super.key});
  final List<String> items = [
    'Edit',
    'Delete',
    'View Campaign ',
  ];
   final AddDesignController addDesignController =Get.put(AddDesignController());

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return _buildPopupMenuItems(items);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
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
                              TextSpan(text: 'Pending: ',style: TextStyle(
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
                              ,image: const DecorationImage(image: AssetImage('assets/pngs/mainposter.png'),fit: BoxFit.cover)
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
                        Text('Business name',style: TextStyle(
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
                        Text('Ads Name',style: TextStyle(
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
                        Text('What’s the business name?',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6E6D)
                        ),),
                        getVerticalSpace(1.2.h),
                        const Divider(color: Color(0xff6E6E6D),
                          thickness: 1,),
                        getVerticalSpace(1.2.h),
                        Text('What’s your website URL?',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)
                        ),),
                        getVerticalSpace(.8.h),
                        Text('www.com',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const  Color(0xff007AFF)
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
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',style: TextStyle(
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
                        Text('Google    Facebook    Instagram',style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor
                        ),),
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
                                  range.isNotEmpty ? range : '25 May 24 TO 04 June 24',
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
                          range.isNotEmpty ? range : 'From 8am to 4pm',
                          style: TextStyle(
                            color: range.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'bold',
                            fontSize: 12.px,
                          ),
                        ),





                      ],),
                  ),
                  getVerticalSpace(2.4.h),
                  Text(
                    'Add Analysis ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold',
                        fontSize: 14.px,
                        color: AppColors.mainColor),
                  ),
                  getVerticalSpace(1.6.h),
                  GestureDetector(onTap: (){
                    addAnalytics(context);
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
                  ),getVerticalSpace(4.h)

                ]
            ),
          ),
        ),
      ),
    );
  }
  List<PopupMenuEntry<String>> _buildPopupMenuItems(List<String> items) {
    List<PopupMenuEntry<String>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      menuItems.add(
        PopupMenuItem<String>(
          value: items[i],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[i]),
              if (i < items.length - 1) const Divider(thickness: 1),
            ],
          ),
        ),
      );
    }
    return menuItems;
  }


}
