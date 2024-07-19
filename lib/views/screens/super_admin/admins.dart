import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

import '../../../controller/utils/alert_box.dart';

class AdminsScreen extends StatelessWidget {
  AdminsScreen({super.key});
  final RxList<String> profilesList = <String>['Mohsin', 'Ali', 'Raza'].obs;
  final List<String> items = [
    'Edit',
    'Delete',
  ];
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(2.4.h),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: profilesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.to(()=> BusinessProfile());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1.2.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.6.h, vertical: 2.0.h),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(1.h)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            profilesList[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 14.px,
                                color: const Color(0xff282827)),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 1.h, bottom: 2.h),
                            height: 3.h,
                            width: 3.h,
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return _buildPopupMenuItems(items);

                              },
                              onSelected: (String value) {
                                if(value=='Edit'){
                                  openUserEdit(context,profilesList[index]);
                                }
                              },
                              icon: const Icon(Icons.more_vert),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              getVerticalSpace(1.6.h),
              GestureDetector(onTap: (){
                openShareCode(context);
              },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 2.0.h),
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
              )
            ],
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
