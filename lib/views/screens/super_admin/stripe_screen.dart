
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_stripe_key_controller.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';

class StripeScreen extends StatefulWidget {
  const StripeScreen({super.key});

  @override
  State<StripeScreen> createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  final RxBool isEdit = false.obs;
  late GetStripeKeyController getStripeKeyController;
  final TextEditingController stripeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getStripeKeyController = Get.put(GetStripeKeyController(context: context));
    getStripeKeyController.fetchStripeKey(loading: getStripeKeyController.stripeKey.value==null).then((_) {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Scaffold(
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
            isEdit.value
                ? const SizedBox.shrink()
                : GestureDetector(
              onTap: () {
                isEdit.value = true;
                stripeController.text= getStripeKeyController.stripeKey.value!.secretKey.toString();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 3.h),
                child: Text(
                  "Edit",
                  style: CustomTextStyles.buttonTextStyle.copyWith(
                    color: const Color(0xff007AFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Stripe Key',
            style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor,
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child:
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerticalSpace(6.h),
                  Text(
                    "Secret Key",
                    style: CustomTextStyles.buttonTextStyle.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  getVerticalSpace(1.h),
                  getStripeKeyController.keyLoading.value
                      ? Shimmer.fromColors(
                    baseColor: AppColors.baseColor,
                    highlightColor: AppColors.highlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.h),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.1),
                            offset: const Offset(0, 2),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: customTextFormField(
                        controller: stripeController,
                        title:"*************",
                        borderRadius: BorderRadius.circular(4.h),
                        borderRadius1: BorderRadius.circular(4.h),
                        bgColor: AppColors.whiteColor,
                      ),
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.h),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child:
                    customTextFormField(
                      controller: stripeController,
                      title: isEdit.value
                          ? getStripeKeyController.stripeKey.value?.secretKey.toString()
                          : "*************",
                      borderRadius: BorderRadius.circular(4.h),
                      borderRadius1: BorderRadius.circular(4.h),
                      bgColor: AppColors.whiteColor,
                    ),
                  ),
                  getVerticalSpace(3.h),
                  isEdit.value
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customElevatedButton(
                        onTap: () {
                          if(stripeController.text.isEmpty){
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Please enter Stripe Key"),
                              ));
                            }
                          }else{
                            getStripeKeyController.updateStripeKey(secretKey: stripeController.text.trim());
                          }
                        },
                        title:getStripeKeyController.editLoading.value?spinkit: Text(
                          "Save",
                          style: CustomTextStyles.buttonTextStyle,
                        ),
                        bgColor: AppColors.mainColor,
                      ),
                    ],
                  )
                      : const SizedBox.shrink(),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
