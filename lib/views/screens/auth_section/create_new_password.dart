import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/create_new_password_controller.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';


class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  late CreateNewPasswordController createNewPasswordController;
  RxString id="".obs;
  RxString token="".obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createNewPasswordController = Get.put(CreateNewPasswordController(context));
    id.value=  MySharedPreferences.getString(userId);
    token.value=  MySharedPreferences.getString(authToken);
    log("user id is that :$id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.4.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                getVerticalSpace(12.h),
                Text(
                  'Create a new password',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading
                      .copyWith(fontSize: 24.px),
                ),
                getVerticalSpace(1.2.h),
                Text(
                  "Your new password must be different from previous used passwords.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: passwordController),
                getVerticalSpace(1.6.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Confirm Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: confirmPasswordController),
                getVerticalSpace(2.4.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() =>
                      customElevatedButton(
                          title:createNewPasswordController.isLoading.value?spinkit: Text(
                            'Save ',
                            style: CustomTextStyles.buttonTextStyle
                                .copyWith(color: AppColors.whiteColor),
                          ),
                          bgColor: AppColors.mainColor,
                          onTap: () {
                            if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please enter your password")));
                            } else if (confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Please enter your confirmPassword")));
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      "password and confirmPassword should not match")));
                            } else {
                              createNewPasswordController.createNewPassword(
                                  newPassword: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                  userId: id.value, token: token.value);
                            }
                            // Get.to(() => LoginScreen());
                          },
                          horizentalPadding: 5.9.h,
                          verticalPadding: 1.2.h),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
