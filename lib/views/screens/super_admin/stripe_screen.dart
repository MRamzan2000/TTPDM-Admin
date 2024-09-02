import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

class StripeScreen extends StatelessWidget {
   StripeScreen({super.key});
final RxBool isEdit=false.obs;
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
        actions: [
          isEdit.value==true?const SizedBox.shrink() : GestureDetector(
              onTap: () {
                isEdit.value=true;
              },
              child: Padding(
                padding:  EdgeInsets.only(right: 3.h),
                child: Text(
                  "Edit",
                  style: CustomTextStyles.buttonTextStyle.copyWith(
                      color: const Color(0xff007AFF),
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Stripe Key',
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
          child: Obx(() =>
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(6.h),
                Text(
                  "Secret Key",
                  style: CustomTextStyles.buttonTextStyle.copyWith(
                      color: AppColors.blackColor, fontWeight: FontWeight.bold),
                ),
                getVerticalSpace(1.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.h),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 12,
                          spreadRadius: 0,
                        )
                      ]),
                  child: customTextFormField(
                      title: isEdit.value==true?"pk_test_51PWFAtRsuZrhcR6RkiVOIRrb6Nfhw9f8alHztCUuBZBSaBU6VHzlbpS2E4PaVcQF6VLDI66X5YKjnCJYkVCorioY00cQAyLk2R": "*************",
                      borderRadius: BorderRadius.circular(4.h),
                      bgColor: AppColors.whiteColor),
                ),
                getVerticalSpace(3.h),
                isEdit.value==true? Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customElevatedButton(
                        title: Text("Save",style: CustomTextStyles.buttonTextStyle,),
                      bgColor: AppColors.mainColor
                    ),
                  ],
                ):const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
