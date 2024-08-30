

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_controller.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';

class BusinessProfile extends StatelessWidget {
  final String businessName;
  final String phoneNumber;
  final String location;
  final String targetArea;
  final String description;
  final String businessId;
  final List<String> imagesList;
  final String logo;
  final String webUrl;
  final String fb;
  final String insta;
  final String tiktok;
  final String linkdin;
  BusinessProfile({
    super.key, required this.businessName, required this.phoneNumber, required this.location, required this.targetArea, required this.description, required this.businessId, required this.imagesList, required this.logo, required this.webUrl, required this.fb, required this.insta, required this.tiktok, required this.linkdin,
  });
  final AddDesignController addDesignController =
      Get.put(AddDesignController());

  final List<String> items = ["View Changes", "Re-upload", "Delete"];

  @override
  Widget build(BuildContext context) {

    final List<String> images = [
      'assets/pngs/itemfive.png',
      'assets/pngs/itemfour.png',
      'assets/pngs/itemthree.png',
      'assets/pngs/itemtwo.png'
    ];

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
         businessName,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(2.4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 2.0.h),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Profile Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold',
                          fontSize: 14.px,
                          color: const Color(0xff282827),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 2.6.h,
                        color: const Color(0xff191918),
                      )
                    ],
                  ),
                ),
                getVerticalSpace(1.6.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 4.2.h,
                        backgroundImage:NetworkImage(logo),
                        // child: Text(
                        //   'Logo',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w700,
                        //       fontFamily: 'bold',
                        //       fontSize: 20.px,
                        //       color: const Color(0xffC3C3C2)),
                        // ),
                      ),
                      getVerticalSpace(.8.h),
                      Text(
                        'Logo',
                        style: TextStyle(
                            fontSize: 14.px,
                            color: const Color(0xff454544),
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                getVerticalSpace(4.h),
                Text(
                  'Business Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                 businessName,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                location,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Target Map Area',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                 targetArea,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Text(
                  'Business description',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff454544),
                    fontSize: 14.px,
                  ),
                ),
                getVerticalSpace(.8.h),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: AppColors.blackColor,
                    fontSize: 12.px,
                  ),
                ),
                getVerticalSpace(1.6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold',
                        fontSize: 14.px,
                        color: const Color(0xff282827),
                      ),
                    ),
                  ],
                ),
                getVerticalSpace(1.2.h),
                SizedBox(
                  height: 30.3.h,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: imagesList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2.1.h,
                      crossAxisSpacing: 1.6.h,
                    ),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: .5.h, vertical: .5.h),
                            height: 11.3.h,
                            width: 11.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.whiteColor,
                              image: DecorationImage(image: NetworkImage(imagesList[index],),fit: BoxFit.cover),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  color: Color(0xffFFE4EA),
                                ),
                              ],
                            ),

                          ),
                        ],
                      );
                    },
                  ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'Upload Design',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    fontSize: 14.px,
                    color: AppColors.mainColor,
                  ),
                ),
                getVerticalSpace(1.6.h),
                // Obx(
                //   () {
                //     return addDesignController.pickedMediaList.isEmpty
                //         ? const SizedBox.shrink()
                //         : SizedBox(
                //             height: 30.3.h,
                //             child: GridView.builder(
                //               padding: EdgeInsets.zero,
                //               itemCount:
                //                   addDesignController.pickedMediaList.length,
                //               physics: const NeverScrollableScrollPhysics(),
                //               gridDelegate:
                //                   SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 3,
                //                 mainAxisSpacing: 2.1.h,
                //                 crossAxisSpacing: 1.6.h,
                //               ),
                //               itemBuilder: (context, index) {
                //                 return Stack(
                //                   children: [
                //                     Container(
                //                       alignment: Alignment.center,
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: .5.h, vertical: .5.h),
                //                       height: 11.3.h,
                //                       width: 11.6.h,
                //                       decoration: BoxDecoration(
                //                         borderRadius:
                //                             BorderRadius.circular(1.h),
                //                         color: AppColors.whiteColor,
                //                         boxShadow: const [
                //                           BoxShadow(
                //                             offset: Offset(0, 1),
                //                             spreadRadius: 0,
                //                             blurRadius: 8,
                //                             color: Color(0xffFFE4EA),
                //                           ),
                //                         ],
                //                       ),
                //                       child: ClipRRect(
                //                         borderRadius:
                //                             BorderRadius.circular(1.h),
                //                         child: Image.file(
                //                           File(addDesignController
                //                               .pickedMediaList[index]['path']!),
                //                           fit: BoxFit.cover,
                //                           height: 11.3.h,
                //                           width: 11.6.h,
                //                         ),
                //                       ),
                //                     ),
                //                     Positioned(
                //                       top: 1.h,
                //                       right: 3.h,
                //                       child: GestureDetector(
                //                         onTapDown: (TapDownDetails details) {
                //                           _showPopupMenu(context,
                //                               details.globalPosition, index);
                //                         },
                //                         child: SizedBox(
                //                           height: 2.5.h,
                //                           width: 2.5.h,
                //                           child: Icon(
                //                             Icons.more_vert,
                //                             color: AppColors.mainColor,
                //                             size: 3.5.h,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 );
                //               },
                //             ),
                //           );
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: .5.h, vertical: .5.h),
                        height: 13.3.h,
                        width: 14.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            color: AppColors.whiteColor,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                                blurRadius: 8,
                                color: Color(0xffFFE4EA),
                              ),
                            ],
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/pngs/uploaddesign1.png'))),
                      ),
                      Positioned(
                        top: 1.h,
                        right: 2.h,
                        child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            _showPopupMenu(context, details.globalPosition, 0);
                          },
                          child: SizedBox(
                            height: 2.5.h,
                            width: 2.5.h,
                            child: Icon(
                              Icons.more_vert,
                              color: AppColors.mainColor,
                              size: 3.5.h,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: .5.h, vertical: .5.h),
                          height: 13.3.h,
                          width: 14.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  color: Color(0xffFFE4EA),
                                ),
                              ],
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/pngs/uploaddesign2.png'))),
                        ),
                        Positioned(
                                                top: 1.h,
                                                right: 2.h,
                                                child: GestureDetector(
                                                  onTapDown: (TapDownDetails details) {
                                                    _showPopupMenu(context,
                                                        details.globalPosition, 1);
                                                  },
                                                  child: SizedBox(
                                                    height: 2.5.h,
                                                    width: 2.5.h,
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: AppColors.mainColor,
                                                      size: 3.5.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: .5.h, vertical: .5.h),
                          height: 13.3.h,
                          width: 14.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  color: Color(0xffFFE4EA),
                                ),
                              ],
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/pngs/uploaddesign3.png'))),
                        ),
                        Positioned(
                                                top: 1.h,
                                                right: 2.h,
                                                child: GestureDetector(
                                                  onTapDown: (TapDownDetails details) {
                                                    _showPopupMenu(context,
                                                        details.globalPosition, 2);
                                                  },
                                                  child: SizedBox(
                                                    height: 2.5.h,
                                                    width: 2.5.h,
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: AppColors.mainColor,
                                                      size: 3.5.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                      ],
                    )
                  ],
                ),
                getVerticalSpace(1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 3.h,
                        width: 7.h,
                        child: const Image(
                            image: AssetImage('assets/pngs/like.png'))),
                    SizedBox(
                        height: 3.h,
                        width: 7.h,
                        child: const Image(
                            image: AssetImage('assets/pngs/dislike.png'))),
                    SizedBox(
                        height: 3.h,
                        width: 7.h,
                        child: const Image(
                            image: AssetImage('assets/pngs/edit.png'))),
                    getHorizentalSpace(1.h)
                  ],
                ),
                getVerticalSpace(2.h),
                GestureDetector(
                  onTap: () {
                    addDesignController.pickMedia();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 15.h,
                        width: 15.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: 3.h,
                              Icons.add,
                              color: AppColors.mainColor,
                            ),
                            Text(
                              'Upload',
                              style: CustomTextStyles.buttonTextStyle
                                  .copyWith(color: AppColors.mainColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(4.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<PopupMenuEntry<String>> _buildPopupMenuItems(List<String> items) {
  //   List<PopupMenuEntry<String>> menuItems = [];
  //   for (int i = 0; i < items.length; i++) {
  //     menuItems.add(
  //       PopupMenuItem<String>(
  //         value: items[i],
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(items[i]),
  //             if (i < items.length - 1) const Divider(thickness: 1),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   return menuItems;
  // }

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
    if (selectedValue != null) {}
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems1(List<String> items) {
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
