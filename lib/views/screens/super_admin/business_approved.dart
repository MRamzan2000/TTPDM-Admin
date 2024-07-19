import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

import 'business_details.dart';


class BusinessApproval extends StatelessWidget {
  BusinessApproval({super.key});
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final RxList<String>profilesList=<String>['Business Profile One','Business Profile Two',
      'Business Profile Three'].obs;
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

              getVerticalSpace(2.4.h),
              ListView.builder(shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                itemCount: profilesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: (){
                    Get.to(()=> BusinessAdmin(title: 'SuperAdmin',));
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
                         getHorizentalSpace(3.h),
                        Text('Managed by Mohsin',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 12.px,
                                color:AppColors.mainColor
                            ),),
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
