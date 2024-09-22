import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/coins_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_all_plans_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';

class BundlesTabBar extends StatefulWidget {
  const BundlesTabBar({super.key});

  @override
  State<BundlesTabBar> createState() => _BundlesTabBarState();
}

class _BundlesTabBarState extends State<BundlesTabBar> {
  final RxInt selectedIndex = 0.obs;
  late CoinsController coinsController;
  late AllPlansController allPlansController;
  RxString token = "".obs;
  @override
  void initState() {
    super.initState();
    coinsController = Get.put(CoinsController(context: context));
    allPlansController = Get.put(AllPlansController(context: context));
    token.value = MySharedPreferences.getString(authToken);
    coinsController.fetchCoinsPlan(
        token: token.value,
        loading: coinsController.getAllCoinsPlane.isEmpty,
        context: context);
    allPlansController.fetchAllPlans(
        loading: allPlansController.getAllPlans.isEmpty, context: context);
  }

  @override
  Widget build(BuildContext context) {
    RxList description = [
      'Add Business only',
      'Add up to Business only',
      'Add up to Business only'
    ].obs;
    final RxString isSelected = 'Coin bundles'.obs;
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
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Subscription',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        Column(
            children: [
              // Container(
              //   color: const Color(0xffE0E0DF),
              //   child: Row(
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           isSelected.value = 'Coin bundles';
              //         },
              //         child: Container(
              //           width: MediaQuery.of(context).size.width / 2,
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 6.9.h, vertical: 1.2.h),
              //           color: isSelected.value == 'Coin bundles'
              //               ? AppColors.mainColor
              //               : Colors.transparent,
              //           child: Text(
              //             'Coin bundles',
              //             style: TextStyle(
              //                 fontFamily: 'bold',
              //                 fontSize: 12.px,
              //                 color: isSelected.value == 'Coin bundles'
              //                     ? AppColors.whiteColor
              //                     : const Color(0xff7C7C7C),
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           isSelected.value = 'Subscription';
              //         },
              //         child: Container(
              //           width: MediaQuery.of(context).size.width / 2,
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 6.9.h, vertical: 1.2.h),
              //           color: isSelected.value == 'Subscription'
              //               ? AppColors.mainColor
              //               : Colors.transparent,
              //           child: Text(
              //             'Subscription',
              //             style: TextStyle(
              //                 fontFamily: 'bold',
              //                 fontSize: 12.px,
              //                 color: isSelected.value == 'Subscription'
              //                     ? AppColors.whiteColor
              //                     : const Color(0xff7C7C7C),
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              getVerticalSpace(2.4.h),
              // isSelected.value == 'Coin bundles'
              //     ? Obx(
              //         () => coinsController.isLoading.value
              //             ? Expanded(
              //                 child: GridView.builder(
              //                   padding:
              //                       EdgeInsets.symmetric(horizontal: 2.5.h),
              //                   itemCount: 7,
              //                   gridDelegate:
              //                       SliverGridDelegateWithFixedCrossAxisCount(
              //                           crossAxisCount: 3,
              //                           mainAxisSpacing: 2.1.h,
              //                           crossAxisSpacing: 1.6.h),
              //                   itemBuilder: (context, index) {
              //                     return Shimmer.fromColors(
              //                       baseColor: AppColors.baseColor,
              //                       highlightColor: AppColors.highlightColor,
              //                       child: Container(
              //                         alignment: Alignment.center,
              //                         padding: EdgeInsets.symmetric(
              //                             horizontal: .5.h, vertical: .5.h),
              //                         height: 11.3.h,
              //                         width: 11.6.h,
              //                         decoration: BoxDecoration(
              //                             borderRadius:
              //                                 BorderRadius.circular(1.h),
              //                             color: AppColors.whiteColor,
              //                             boxShadow: const [
              //                               BoxShadow(
              //                                   offset: Offset(0, 1),
              //                                   spreadRadius: 0,
              //                                   blurRadius: 8,
              //                                   color: Color(0xffFFE4EA))
              //                             ]),
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               )
              //             : coinsController.getAllCoinsPlane.isEmpty
              //                 ? Expanded(
              //                     child: Center(
              //                       child: Text(
              //                         "No Users Found",
              //                         style: TextStyle(
              //                           fontSize: 18.px,
              //                           color: AppColors.mainColor,
              //                           fontWeight: FontWeight.w500,
              //                           fontFamily: 'bold',
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                 : Expanded(
              //                     child: GridView.builder(
              //                       padding:
              //                           EdgeInsets.symmetric(horizontal: 2.5.h),
              //                       itemCount:
              //                           coinsController.getAllCoinsPlane.length,
              //                       gridDelegate:
              //                           SliverGridDelegateWithFixedCrossAxisCount(
              //                               crossAxisCount: 3,
              //                               mainAxisSpacing: 2.1.h,
              //                               crossAxisSpacing: 1.6.h),
              //                       itemBuilder: (context, index) {
              //                         return Stack(children: [
              //                           Container(
              //                             alignment: Alignment.center,
              //                             padding: EdgeInsets.symmetric(
              //                                 horizontal: .3.h, vertical: .5.h),
              //                             height: 13.3.h,
              //                             width: 13.6.h,
              //                             decoration: BoxDecoration(
              //                                 borderRadius:
              //                                     BorderRadius.circular(1.h),
              //                                 color: AppColors.whiteColor,
              //                                 boxShadow: const [
              //                                   BoxShadow(
              //                                       offset: Offset(0, 1),
              //                                       spreadRadius: 0,
              //                                       blurRadius: 8,
              //                                       color: Color(0xffFFE4EA))
              //                                 ]),
              //                             child: index ==
              //                                     coinsController
              //                                             .getAllCoinsPlane
              //                                             .length -
              //                                         1
              //                                 ? GestureDetector(
              //                                     onTap: () {
              //                                       openCreateNewPlan(context,
              //                                           title:
              //                                               'Create New Plan',
              //                                           coinPlanId:
              //                                               coinsController
              //                                                   .getAllCoinsPlane[
              //                                                       index]!
              //                                                   .id,
              //                                           token: token.value);
              //                                     },
              //                                     child: Column(
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment
              //                                               .center,
              //                                       children: [
              //                                         Icon(
              //                                           size: 4.h,
              //                                           Icons.add,
              //                                           color:
              //                                               AppColors.mainColor,
              //                                         ),
              //                                         Text(
              //                                           'Create new',
              //                                           style: CustomTextStyles
              //                                               .buttonTextStyle
              //                                               .copyWith(
              //                                                   color: AppColors
              //                                                       .mainColor,
              //                                                   fontSize:
              //                                                       12.px),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   )
              //                                 : Column(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.center,
              //                                     children: [
              //                                       SizedBox(
              //                                           height: 3.2.h,
              //                                           child: const Image(
              //                                               image: AssetImage(
              //                                                   'assets/pngs/coinicon.png'))),
              //                                       Text(
              //                                         '${coinsController.getAllCoinsPlane[index]!.amount}',
              //                                         style: TextStyle(
              //                                             fontSize: 14.px,
              //                                             fontFamily: 'bold',
              //                                             fontWeight:
              //                                                 FontWeight.w500,
              //                                             color: const Color(
              //                                                 0xff4D4F53)),
              //                                       ),
              //                                       getVerticalSpace(1.2.h),
              //                                       Container(
              //                                         padding:
              //                                             EdgeInsets.symmetric(
              //                                                 horizontal: .5.h,
              //                                                 vertical: .5.h),
              //                                         decoration: BoxDecoration(
              //                                             color: AppColors
              //                                                 .mainColor,
              //                                             borderRadius:
              //                                                 BorderRadius
              //                                                     .circular(
              //                                                         5.h)),
              //                                         child: Text(
              //                                           '\$${coinsController.getAllCoinsPlane[index]!.priceInCents}',
              //                                           style: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w400,
              //                                               fontFamily: 'bold',
              //                                               fontSize: 12.px,
              //                                               color: AppColors
              //                                                   .whiteColor),
              //                                         ),
              //                                       )
              //                                     ],
              //                                   ),
              //                           ),
              //                           index ==
              //                                   coinsController.getAllCoinsPlane
              //                                           .length -
              //                                       1
              //                               ? const SizedBox.shrink()
              //                               : Positioned(
              //                                   top: 0.5.h,
              //                                   right: 1.h,
              //                                   child: GestureDetector(
              //                                     onTapDown:
              //                                         (TapDownDetails details) {
              //                                       _showPopupMenu(
              //                                           context,
              //                                           details.globalPosition,
              //                                           0);
              //                                     },
              //                                     child: SizedBox(
              //                                       height: 2.5.h,
              //                                       width: 2.5.h,
              //                                       child: Icon(
              //                                         Icons.more_vert,
              //                                         color: const Color(
              //                                             0xff282827),
              //                                         size: 3.5.h,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                         ]);
              //                       },
              //                     ),
              //                   ),
              //       )
                   Obx(
                      () => allPlansController.isLoading.value
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  highlightColor: AppColors.highlightColor,
                                  baseColor: AppColors.baseColor,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.2.h,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 3.5.h, vertical: 1.6.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(2.h),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14.px,
                                                  color: AppColors.mainColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'bold'),
                                            ),
                                            getVerticalSpace(.8.h),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 16.px,
                                                  color:
                                                      const Color(0xff191918),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'bold'),
                                            ),
                                            getVerticalSpace(.8.h),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 12.px,
                                                  color:
                                                      const Color(0xff444545),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'bold'),
                                            ),
                                          ],
                                        ),
                                        const Expanded(child: SizedBox()),
                                        Padding(
                                          padding: EdgeInsets.only(right: 2.h),
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontSize: 10.px,
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff007AFF)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : allPlansController.getAllPlans.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: Text(
                                      "No Plans Found",
                                      style: TextStyle(
                                        fontSize: 18.px,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      allPlansController.getAllPlans.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        openSubscription(context,
                                            title: allPlansController
                                                .getAllPlans[index]!.name,
                                            subPlanId: allPlansController
                                                .getAllPlans[index]!.id,
                                            token: token.value,
                                            price: allPlansController
                                                .getAllPlans[index]!.price,
                                            businessLimit: allPlansController
                                                .getAllPlans[index]!
                                                .businessLimit);
                                      },
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 1.2.h,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 3.5.h, vertical: 1.6.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(2.h),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(child: SizedBox()),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  allPlansController
                                                      .getAllPlans[index]!.name,
                                                  style: TextStyle(
                                                      fontSize: 14.px,
                                                      color:
                                                          AppColors.mainColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'bold'),
                                                ),
                                                getVerticalSpace(.8.h),
                                                Text(
                                                  "${allPlansController.getAllPlans[index]!.price}",
                                                  style: TextStyle(
                                                      fontSize: 16.px,
                                                      color: const Color(
                                                          0xff191918),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'bold'),
                                                ),
                                                getVerticalSpace(.8.h),
                                                Text(
                                                  " ${description[index]}${allPlansController.getAllPlans[index]!.businessLimit}",
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      color: const Color(
                                                          0xff444545),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'bold'),
                                                ),
                                              ],
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 2.h),
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: 10.px,
                                                    fontFamily: 'bold',
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xff007AFF)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    )
            ],
          ),

      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset position, int index) async {
    final selectedValue = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: _buildPopupMenuItems1(items),
    );
    if (selectedValue != null) {
      String id = coinsController.getAllCoinsPlane[index]!.id;
      if (selectedValue == "Delete") {
        coinsController.getAllCoinsPlane.removeAt(index);
        log(coinsController.getAllCoinsPlane[index]!.id);
        coinsController.deleteCoinsPlan(
            coinsPlanId: coinsController.getAllCoinsPlane[index]!.id,
            token: token.value);
      } else {
       if(context.mounted){
         openCreateNewPlan(context,
             title: 'Update your plan', coinPlanId: id, token: token.value);
       }
      }
      log(selectedValue);
      // _performAction(selectedValue);
    }
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems1(List<String> items) {
    List<PopupMenuEntry<String>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      menuItems.add(
        PopupMenuItem<String>(
          onTap: () {},
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

  final List<String> items = [
    'Edit',
    'Delete',
  ];
}
