import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/admin_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/coins_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_all_plans_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_campaign_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_fcm_send_notification_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/image_picker_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/screens/auth_section/login_screen.dart';

import '../getx_controllers/get_design_request_controller.dart';

void openChooseEditProfile(
  BuildContext context, {
  required String name,
  required String profileImage,
}) {
  final TextEditingController nameController = TextEditingController();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController(context: context));
  log(profileImage);
  void resetImagePicker() {
    imagePickerController.image.value = null;
  }

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              height: 42.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox()),
                      getHorizentalSpace(5.h),
                      Text(
                        'Profile',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'regular',
                            fontSize: 20.px),
                      ),
                      const Expanded(child: SizedBox()),
                      getHorizentalSpace(5.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close dialog
                          resetImagePicker(); // Reset image picker
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.h),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        imagePickerController.pickImage(ImageSource.gallery);
                      },
                      child: imagePickerController.image.value == null
                          ? CircleAvatar(
                              radius: 6.h,
                              backgroundColor: AppColors.baseColor,
                              backgroundImage: NetworkImage(profileImage),
                            )
                          : CircleAvatar(
                              radius: 6.h,
                              backgroundColor: AppColors.baseColor,
                              backgroundImage: FileImage(File(
                                  imagePickerController.image.value!.path)),
                            ),
                    ),
                  ),
                  getVerticalSpace(1.3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff454544)),
                      ),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.25),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField(
                      controller: nameController, // Set the controller
                      title: name,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(3.h),
                      borderRadius1: BorderRadius.circular(3.h),
                    ),
                  ),
                  getVerticalSpace(2.6.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                            onTap: () {
                              String token =
                                  MySharedPreferences.getString(authToken);

                              userProfileController
                                  .uploadProfileImage(
                                      token: token,
                                      profileImage: imagePickerController
                                                  .image.value?.path.isEmpty ??
                                              true
                                          ? File("")
                                          : File(imagePickerController
                                              .image.value!.path),
                                      fullname: nameController.text.isEmpty
                                          ? name
                                          : nameController.text)
                                  .then(
                                (value) {
                                  Navigator.of(context).pop(); // Close dialog
                                },
                              );
                            },
                            title: userProfileController.uploading.value
                                ? spinkit
                                : Text(
                                    'Save',
                                    style: CustomTextStyles.buttonTextStyle
                                        .copyWith(
                                            color: AppColors.whiteColor,
                                            fontFamily: 'bold'),
                                  ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .8.h,
                            horizentalPadding: 6.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Check if the image is null or not

void openUserEdit(
  BuildContext context,
  String userName,
  String adminId,
) {
  RxList namesList = ['Campaign', 'Design Ad', 'Businesses'].obs;
  RxList pngs = [
    'assets/pngs/campaign.png',
    'assets/pngs/design.png',
    'assets/pngs/business.png'
  ].obs;
  RxList indexes = [].obs;
  RxInt selectedIndex = 0.obs;
  final AdminController adminController =
      Get.put(AdminController(context: context));

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.5.h, vertical: 2.h),
              height: 45.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      ' $userName',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontFamily: 'regular',
                          fontSize: 20.px),
                    ),
                  ),
                  getVerticalSpace(2.2.h),
                  Text(
                    'Admin Rights',
                    style: TextStyle(
                        color: const Color(0xff191918),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'bold',
                        fontSize: 20.px),
                  ),
                  const Divider(
                    color: Color(0xffC3C3C2),
                  ),
                  getVerticalSpace(1.h),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: namesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.6.h),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 3.2.h,
                              width: 3.2.h,
                              child: Image(image: AssetImage(pngs[index])),
                            ),
                            getHorizentalSpace(.8.h),
                            Text(
                              namesList[index],
                              style: TextStyle(
                                  fontSize: 16.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff101010)),
                            ),
                            const Expanded(child: SizedBox()),
                            GestureDetector(
                              onTap: () {
                                selectedIndex.value = index;
                                if (!indexes.contains(selectedIndex.value)) {
                                  indexes.add(selectedIndex.value);
                                } else {
                                  indexes.remove(selectedIndex.value);
                                }
                              },
                              child: Obx(
                                () => Container(
                                  alignment: indexes.contains(index)
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  width: 4.h,
                                  height: 2.h,
                                  decoration: BoxDecoration(
                                      color: indexes.contains(index)
                                          ? AppColors.mainColor.withOpacity(0.3)
                                          : const Color(0xff959595)
                                              .withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.h)),
                                  child: Container(
                                    height: 2.h,
                                    width: 2.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: indexes.contains(index)
                                            ? AppColors.mainColor
                                            : const Color(0xff959595)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  getVerticalSpace(1.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Cancel',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xff999999),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Obx(
                        () => Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                adminController
                                    .updateMidAdminRights(
                                        adminId: adminId,
                                        campaignPermission: indexes.contains(0),
                                        designAdPermission: indexes.contains(1),
                                        businessesPermission:
                                            indexes.contains(2))
                                    .then(
                                      (value) {},
                                    );
                                // Get.to(() => const BottomNavigationBarAdmin());
                              },
                              title: adminController.updateLoading.value
                                  ? spinkit
                                  : Text(
                                      'Save',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: const Color(0xff34C759),
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openShareCode(BuildContext context, String adminCode) {
  showDialog(
    context: context,
    builder: (context) {
      final AdminController adminController =
          Get.put(AdminController(context: context));
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              height: 33.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        '    New Admin Registration Code',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'regular',
                            fontSize: 14.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(4.5.h),
                  Text(
                    adminCode,
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'bold',
                        fontSize: 40.px),
                  ),
                  getVerticalSpace(4.h),
                  customElevatedButton(
                      onTap: () {
                        adminController.shareApp(adminCode: adminCode);
                      },
                      title: Text(
                        'Share',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.whiteColor, fontFamily: 'bold'),
                      ),
                      bgColor: AppColors.mainColor,
                      verticalPadding: .6.h,
                      horizentalPadding: 4.6.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCreateNewPlan(BuildContext context,
    {required String title,
    required String coinPlanId,
    required String token}) {
  final CoinsController coinsController =
      Get.put(CoinsController(context: context));
  TextEditingController coinsPriceController = TextEditingController();
  TextEditingController numberCoinsController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 40.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontFamily: 'bold',
                          fontSize: 16.px),
                    ),
                  ),
                  getVerticalSpace(2.3.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Number of Coin',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.250),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField(
                      controller: numberCoinsController,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(2.h),
                      borderRadius1: BorderRadius.circular(2.h),
                    ),
                  ),
                  getVerticalSpace(1.6.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Coin Price',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.250),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField(
                      controller: coinsPriceController,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(2.h),
                      borderRadius1: BorderRadius.circular(2.h),
                    ),
                  ),
                  getVerticalSpace(3.8.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Cancel',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xff999999),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Obx(
                        () => Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                if (title == "Update your plan") {
                                  if (numberCoinsController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Number of Coins")));
                                  } else if (coinsPriceController
                                      .text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Price of Coins")));
                                  } else {
                                    coinsController.updateCoinsPlan(
                                        token: token,
                                        numberOfCoins:
                                            numberCoinsController.text,
                                        coinsPrice: coinsPriceController.text,
                                        coinsPlanId: coinPlanId);
                                  }
                                } else {
                                  if (numberCoinsController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Number of Coins")));
                                  } else if (coinsPriceController
                                      .text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Enter Price of Coins")));
                                  } else {
                                    coinsController.createNewCoinsPlan(
                                        token: token,
                                        numberOfCoins:
                                            numberCoinsController.text,
                                        coinsPrice: coinsPriceController.text);
                                  }
                                }
                              },
                              title: coinsController.coinsLoading.value
                                  ? spinkit
                                  : Text(
                                      title == "Update your plan"
                                          ? "Update"
                                          : 'Create',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openSubscription(
  BuildContext context, {
  required title,
  required price,
  required businessLimit,
  required subPlanId,
  required token,
}) {
  final AllPlansController allPlansController =
      Get.put(AllPlansController(context: context));
  final TextEditingController priceController = TextEditingController();
  final TextEditingController businessLimitController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 44.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontFamily: 'bold',
                          fontSize: 16.px),
                    ),
                  ),
                  getVerticalSpace(2.3.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Plan Price',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.250),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField(
                      title: "$price",
                      controller: priceController,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(2.h),
                      borderRadius1: BorderRadius.circular(2.h),
                    ),
                  ),
                  getVerticalSpace(1.6.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Business Limit',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.250),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField(
                      title: "$businessLimit",
                      keyboardType: TextInputType.number,
                      controller: businessLimitController,
                      maxLines: 3,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(2.h),
                      borderRadius1: BorderRadius.circular(2.h),
                    ),
                  ),
                  getVerticalSpace(3.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Cancel',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xff000000).withOpacity(0.8),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Obx(
                        () => Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                if (priceController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please Enter price of plan")));
                                } else if (businessLimitController
                                    .text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please Enter Business Limit of plan")));
                                } else {
                                  allPlansController.updateSubPlan(
                                      name: title,
                                      token: token,
                                      price: priceController.text,
                                      businessLimit:
                                          businessLimitController.text,
                                      subPlanId: subPlanId);
                                }
                                // Get.to(() => const BundlesTabBar());
                              },
                              title: allPlansController.subplanLoading.value
                                  ? spinkit
                                  : Text(
                                      'Save',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: const Color(0xff34C759),
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openRejectReason(
  BuildContext context, {
  required String token,
  required String businessId,
  required String ownerId,
  required String id,
}) {
  final GetBusinessController getBusinessController =
      Get.put(GetBusinessController(context: context));
  final TextEditingController rejectionController = TextEditingController();
  GetFcmTokenSendNotificationController getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 33.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Rejection Reasons',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontFamily: 'bold',
                          fontSize: 16.px),
                    ),
                  ),
                  getVerticalSpace(2.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descriptions',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  customTextFormField(
                    controller: rejectionController,
                    maxLines: 2,
                    bgColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(1.h),
                    borderRadius1: BorderRadius.circular(1.h),
                  ),
                  getVerticalSpace(2.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Deny',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xffC3C3C2),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Expanded(
                        child: Obx(
                          () => customElevatedButton(
                              onTap: () {
                                if (rejectionController.text.isEmpty) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please enter the reason")));
                                  }
                                } else {
                                  getBusinessController
                                      .changeBusinessStatus(
                                          token: token,
                                          businessId: businessId,
                                          status: "rejected",
                                          rejectionReason:
                                              rejectionController.text)
                                      .then(
                                    (value) {
                                      getFcmTokenSendNotificationController
                                          .fetchFcmToken(
                                              loading:
                                                  getFcmTokenSendNotificationController
                                                          .fcmToken.value ==
                                                      null,
                                              userId: ownerId,
                                              token: token,
                                              title: "Sorry",
                                              message:
                                                  "Your Business was Rejected Because ${rejectionController.text}",
                                              info1: "id $id",
                                              info2: "");
                                    },
                                  );
                                }
                              },
                              title: getBusinessController.rejectLoader.value
                                  ? spinkit
                                  : Text(
                                      'Send',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignStatus(
  BuildContext context, {
  required String token,
  required String campaignId,
  required String ownerId,
}) {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController(context: context));
  final TextEditingController rejectionController = TextEditingController();
  final GetFcmTokenSendNotificationController
      getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 30.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Rejection Reasons',
                      style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.blackColor,
                          fontFamily: 'bold',
                          fontSize: 16.px),
                    ),
                  ),
                  getVerticalSpace(2.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descriptions',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff454544)),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  customTextFormField(
                    controller: rejectionController,
                    maxLines: 2,
                    bgColor: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(1.h),
                    borderRadius1: BorderRadius.circular(1.h),
                  ),
                  getVerticalSpace(2.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Deny',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xffC3C3C2),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Expanded(
                        child: Obx(
                          () => customElevatedButton(
                              onTap: () {
                                if (rejectionController.text.isEmpty) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please enter the reason")));
                                  }
                                } else {
                                  addCampaignController
                                      .changeCampaignStatus(
                                          token: token,
                                          campaignId: campaignId,
                                          status: "rejected",
                                          rejectionReason:
                                              rejectionController.text)
                                      .then(
                                    (value) {
                                      getFcmTokenSendNotificationController
                                          .fetchFcmToken(
                                              loading:
                                                  getFcmTokenSendNotificationController
                                                          .fcmToken.value ==
                                                      null,
                                              userId: ownerId,
                                              token: token,
                                              title: "Sorry",
                                              message: "Campaign Was Rejected",
                                              info1: "",
                                              info2: "");
                                    },
                                  );
                                }
                              },
                              title: addCampaignController.rejectLoader.value
                                  ? spinkit
                                  : Text(
                                      'Send',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void addAnalytics(
  BuildContext context, {
  required String campaignId,
  required String token,
  required String ownerId,
  required String ownerName,
}) {
  final TextEditingController impressionController = TextEditingController();
  final TextEditingController clickController = TextEditingController();
  AddCampaignController addCampaignController =
      Get.put(AddCampaignController(context: context));
  GetFcmTokenSendNotificationController getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 37.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Data add',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'bold',
                            fontSize: 16.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.2.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          addCampaignController.pickDate();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.2.h, vertical: .85.h),
                          height: 4.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                          child: Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  height: 2.4.h,
                                  width: 2.4.h,
                                  child: const Image(
                                    image:
                                        AssetImage('assets/pngs/dateicon.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: .8.h),
                                addCampaignController.formattedDate
                                        .toString()
                                        .isEmpty
                                    ? Text(
                                        'Select',
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'bold',
                                          fontSize: 12.px,
                                        ),
                                      )
                                    : Text(
                                        addCampaignController.formattedDate,
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'bold',
                                          fontSize: 12.px,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  getVerticalSpace(1.2.h),
                  Row(
                    children: [
                      Text(
                        'Impression',
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff191918),
                            fontWeight: FontWeight.w500),
                      ),
                      getHorizentalSpace(13.h),
                      Text(
                        'Clicks',
                        style: TextStyle(
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff191918),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.h),
                  Row(
                    children: [
                      Expanded(
                        child: customTextFormField(
                          controller: impressionController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          bgColor: const Color(0xffEBEDF0),
                          borderRadius: BorderRadius.circular(3.h),
                          borderRadius1: BorderRadius.circular(3.h),
                        ),
                      ),
                      getHorizentalSpace(1.2.h),
                      Expanded(
                        child: customTextFormField(
                          controller: clickController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          bgColor: const Color(0xffEBEDF0),
                          borderRadius: BorderRadius.circular(3.h),
                          borderRadius1: BorderRadius.circular(3.h),
                        ),
                      ),
                    ],
                  ),
                  getVerticalSpace(3.8.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'Deny',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xffC3C3C2),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Obx(
                        () => Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                if (impressionController.text.isEmpty) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("please add impression")));
                                  }
                                } else if (clickController.text.isEmpty) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("please add Clicks")));
                                  }
                                } else {
                                  addCampaignController
                                      .addAnalysis(
                                          campaignId: campaignId,
                                          date: addCampaignController
                                              .formattedDate,
                                          impressions: impressionController.text
                                              .toString(),
                                          clicks:
                                              clickController.text.toString())
                                      .then(
                                    (value) {
                                      getFcmTokenSendNotificationController
                                          .fetchFcmToken(
                                              loading:
                                                  getFcmTokenSendNotificationController
                                                          .fcmToken.value ==
                                                      null,
                                              userId: ownerId,
                                              token: token,
                                              title: "Analysis",
                                              message:
                                                  "$ownerName Added your Campaign Analysis",
                                              info1: "id $ownerId",
                                              info2: "");
                                    },
                                  ).then(
                                    (value) {
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              title: addCampaignController.analysisLoader.value
                                  ? spinkit
                                  : Text(
                                      'Send',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void manageApproval(
  BuildContext context, {
  required String midAdminName,
  required String requestId,
  required String midAdminId,
  required String token,
}) {
  AdminController adminController = Get.put(AdminController(context: context));
  final GetFcmTokenSendNotificationController
      getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 33.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Manage Request',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'bold',
                            fontSize: 16.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.2.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(5.h),
                  Text(
                    '$midAdminName want to manage the business name',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                        fontSize: 16.px,
                        fontFamily: 'bold'),
                  ),
                  getVerticalSpace(4.7.h),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                adminController
                                    .updateBusinessManageRequest(
                                        requestId: requestId, status: "reject")
                                    .then(
                                  (value) {
                                    getFcmTokenSendNotificationController
                                        .fetchFcmToken(
                                            loading:
                                                getFcmTokenSendNotificationController
                                                        .fcmToken.value ==
                                                    null,
                                            userId: midAdminId,
                                            token: token,
                                            title: "Sorry",
                                            message: "Manage Request Rejected",
                                            info1: "",
                                            info2: "")
                                        .then(
                                      (value) {
                                        Get.back();
                                      },
                                    );
                                  },
                                );
                              },
                              title: adminController
                                      .updateBusinessManageLoading1.value
                                  ? spinkit
                                  : Text(
                                      'Reject',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: const Color(0xffC3C3C2),
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                        getHorizentalSpace(1.6.h),
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                adminController
                                    .updateBusinessManageRequest(
                                        requestId: requestId, status: "approve")
                                    .then(
                                  (value) {
                                    getFcmTokenSendNotificationController
                                        .fetchFcmToken(
                                            loading:
                                                getFcmTokenSendNotificationController
                                                        .fcmToken.value ==
                                                    null,
                                            userId: midAdminId,
                                            token: token,
                                            title: "Congratulation",
                                            message: "Manage Request Approved",
                                            info1: "",
                                            info2: "")
                                        .then(
                                      (value) {
                                        Get.back();
                                      },
                                    );
                                  },
                                );
                              },
                              title: adminController
                                      .updateBusinessManageLoading.value
                                  ? spinkit
                                  : Text(
                                      'Approve',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontFamily: 'bold'),
                                    ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void logoutPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 36.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Manage Logout',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'bold',
                            fontSize: 16.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.2.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(1.h),
                  SvgPicture.asset(
                    "assets/svgs/logout.svg",
                    color: AppColors.mainColor,
                  ),
                  getVerticalSpace(1.h),
                  Text(
                    'Are You Sure ! you want to Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                        fontSize: 16.px,
                        fontFamily: 'bold'),
                  ),
                  getVerticalSpace(4.7.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'No',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xffC3C3C2),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              MySharedPreferences.setBool(isLoggedInKey, false);
                              Get.off(() => const LoginScreen());
                            },
                            title: Text(
                              'Yes',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
                            ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignSubmit(
  BuildContext context, {
  required String token,
  required String businessId,
  required String ownerId,
  required String currentUserName,
  required String id,
}) {
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final DesignRequestController designRequestController =
      Get.put(DesignRequestController());
  final GetFcmTokenSendNotificationController
      getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));

  RxString isSelected = "This Business".obs;

  showDialog(
    context: context,
    builder: (context) {
      return Obx(
        () => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                height: 48.h,
                decoration: BoxDecoration(
                    color: const Color(0xffF8F9FA),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(child: SizedBox()),
                        Text(
                          'Campaign Data add',
                          style: TextStyle(
                              fontSize: 16.px,
                              fontFamily: 'bold',
                              fontWeight: FontWeight.w800,
                              color: const Color(0xff191918)),
                        ),
                        const Expanded(child: SizedBox()),
                        getVerticalSpace(1.h),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const SizedBox(
                              height: 33,
                              child: Image(
                                  image:
                                      AssetImage('assets/pngs/crossicon.png'))),
                        )
                      ],
                    ),
                    getVerticalSpace(1.h),
                    Divider(
                      color: AppColors.textFieldGreyColor,
                    ),
                    getVerticalSpace(1.h),
                    GestureDetector(
                      onTap: () {
                        imagePickerController.pickImage(ImageSource.gallery);
                      },
                      child: imagePickerController.image.value == null
                          ? Container(
                              alignment: Alignment.center,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: AppColors.textFieldGreyColor,
                                borderRadius: BorderRadius.circular(2.h),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 5.h,
                                    Icons.add,
                                    color: AppColors.mainColor,
                                  ),
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontSize: 16.px,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.mainColor),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldGreyColor,
                                  borderRadius: BorderRadius.circular(2.h),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(imagePickerController
                                            .image.value!.path),
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                    ),
                    getVerticalSpace(1.1.h),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                isSelected.value = "This Business";
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(2.h),
                                    border: Border.all(
                                        color:
                                            isSelected.value == "This Business"
                                                ? AppColors.mainColor
                                                : Colors.transparent)),
                                child: Text(
                                  'This Business',
                                  style: TextStyle(
                                      fontSize: 12.px,
                                      fontFamily: 'bold',
                                      fontWeight: FontWeight.w600,
                                      color: isSelected.value == "This Business"
                                          ? AppColors.mainColor
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                          getHorizentalSpace(2.h),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                isSelected.value = "Public";
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(2.h),
                                    border: Border.all(
                                        color: isSelected.value == "Public"
                                            ? AppColors.mainColor
                                            : Colors.transparent)),
                                child: Text(
                                  'Public',
                                  style: TextStyle(
                                      fontSize: 12.px,
                                      fontFamily: 'bold',
                                      fontWeight: FontWeight.w600,
                                      color: isSelected.value == "Public"
                                          ? AppColors.mainColor
                                          : Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    getVerticalSpace(2.h),
                    customElevatedButton(
                      title:designRequestController.uploading.value?spinkit: Text(
                        'Upload',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.whiteColor),
                      ),
                      bgColor: AppColors.mainColor,
                      verticalPadding: .6.h,
                      horizentalPadding: 4.h,
                      onTap: () {
                        if (isSelected.value == "This Business") {
                          if (imagePickerController.image.value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select an image"),
                              ),
                            );
                          } else {
                            designRequestController
                                .uploadProfileImage(
                              token: token,
                              designs:
                                  File(imagePickerController.image.value!.path),
                              context: context,
                              businessId: businessId,
                            )
                                .then(
                              (value) {
                                getFcmTokenSendNotificationController
                                    .fetchFcmToken(
                                        loading:
                                            getFcmTokenSendNotificationController
                                                    .fcmToken.value ==
                                                null,
                                        userId: ownerId,
                                        token: token,
                                        title: "Uploaded design",
                                        message:
                                            "${currentUserName}Uploaded design",
                                        info1: id,
                                        info2: "")
                                    .then(
                                      (value) {
                                        Get.back();

                                      },
                                    );
                              },
                            );
                          }
                        } else {
                          if (imagePickerController.image.value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select an image"),
                              ),
                            );
                          } else {
                            designRequestController
                                .uploadProfileImage(
                              token: token,
                              designs:
                                  File(imagePickerController.image.value!.path),
                              context: context,
                              businessId: "",
                            )
                                .then(
                              (value) {
                                getFcmTokenSendNotificationController
                                    .fetchFcmToken(
                                        loading:
                                            getFcmTokenSendNotificationController
                                                    .fcmToken.value ==
                                                null,
                                        userId: ownerId,
                                        token: token,
                                        title: "Uploaded design",
                                        message:
                                            "${currentUserName}Uploaded design",
                                        info1: id,
                                        info2: "")
                                    .then(
                                      (value) {
                                        Get.back();
                                      },
                                    );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
