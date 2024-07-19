import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

import '../super_admin/business_details.dart';

class BusinessTabBar extends StatelessWidget {
  BusinessTabBar({super.key});
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final RxList<String>profilesList=<String>['Business Profile One','Business Profile Two',
      'Business Profile Three'].obs;
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
              ListView.builder(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                itemCount: profilesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    Get.to(()=> BusinessAdmin());
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
                          isSelected.value=='Approved'?getHorizentalSpace(3.h):getHorizentalSpace(0),
                          isSelected.value=='Approved'? Text('Managed by Mohsin',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 12.px,
                                color:AppColors.mainColor
                            ),):const SizedBox.shrink(),
                          Icon(Icons.arrow_forward_ios_sharp,
                            size: 2.4.h,color:
                            const Color(0xff191918),)
                        ],
                      ),
                    ),
                  );
                },),
            ],
          ),
        ),
      ),
    );
  }
}
