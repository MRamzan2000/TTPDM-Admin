

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/admin_controller.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

import '../../../controller/utils/alert_box.dart';

class AdminsScreen extends StatefulWidget {
  const AdminsScreen({super.key});

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen> {
  final List<String> items = [
    'Edit',
    'Delete',
  ];

  late AdminController adminController;
RxString token="".obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminController = Get.put(AdminController(context: context));
    adminController.fetchAllMidAdmins(
        loading: adminController.allMidAdmins.isEmpty);
    token.value=MySharedPreferences.getString(authToken);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerticalSpace(2.4.h),
                  adminController.isLoading.value
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: AppColors.baseColor,
                              highlightColor: AppColors.highlightColor,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 1.2.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.6.h, vertical: 2.0.h),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(1.h)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "",
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 1.h, bottom: 2.h),
                                      height: 3.h,
                                      width: 3.h,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : adminController.allMidAdmins.isEmpty
                          ? Center(
                              child: Text(
                                "No Users Found",
                                style: TextStyle(
                                  fontSize: 18.px,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                ),
                              ),
                            )
                          : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: adminController.allMidAdmins.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: .8.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.6.h, vertical: .8.h),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(1.h)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      adminController
                                          .allMidAdmins[index]!.fullname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold',
                                          fontSize: 14.px,
                                          color: const Color(0xff282827)),
                                    ),
                                    PopupMenuButton<String>(
                                      itemBuilder: (BuildContext context) {
                                        return _buildPopupMenuItems(items);
                                      },
                                      onSelected: (String value) {
                                        if (value == 'Edit') {
                                          openUserEdit(
                                              context,
                                              adminController
                                                  .allMidAdmins[index]!
                                                  .fullname,
                                              adminController
                                                  .allMidAdmins[index]!
                                                  .id
                                          );
                                        }
                                      },
                                      icon:  Icon(Icons.more_vert,
                                      size: 3.5.h,),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  getVerticalSpace(1.6.h),
                  adminController.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: AppColors.baseColor,
                          highlightColor: AppColors.highlightColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.h)),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            adminController.fetchAdminCode(token: token.value, loading: adminController.adminCode.value == null)
                                .then((_) {
                              log("admin code :${adminController.adminCode.value!.adminCode.code}");

                              if (adminController.adminCode.value != null) {
                                openShareCode(context, adminController.adminCode.value!.adminCode.code.toString());
                              } else {
                                log("Admin code is null or not fetched yet");
                              }
                            });



                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 20,
                                  color: AppColors.mainColor,
                                ),
                                Text(
                                  'Add New Admin',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'bold',
                                      fontSize: 14.px,
                                      color: AppColors.mainColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                  getVerticalSpace(9.h)
                ],
              ),
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
