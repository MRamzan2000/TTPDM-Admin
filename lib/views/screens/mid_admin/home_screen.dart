import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_business_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_design_request_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/screens/notification_section/mid_admin_notification_screen.dart';
import 'business_profile_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DesignRequestController designRequestController;
  late GetBusinessController getBusinessController;
  late UserProfileController userProfileController;
  final RxString id = "".obs;
  final RxString name = "".obs;
  final RxList<String> svgs = <String>[
    'assets/svgs/cancel.svg',
    'assets/svgs/ok.svg',
    'assets/svgs/new.svg'
  ].obs;
  @override
  void initState() {
    super.initState();
    getBusinessController = Get.put(GetBusinessController(context: context));
    designRequestController = Get.put(DesignRequestController());
    userProfileController = Get.put(UserProfileController(context: context));
    id.value = MySharedPreferences.getString(userId);
    name.value = MySharedPreferences.getString(userName);
    designRequestController.fetchDesignRequest(
        loading: designRequestController.getDesignRequest.isEmpty);
    userProfileController.fetchUserProfile(
        loading: userProfileController.userProfile.value == null, id: id.value);
    getBusinessController.fetchBusinessByStatus(
        context: context,
        isLoad: getBusinessController.pendingBusiness.value == null,
        status: 'pending');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'ADVYRO',
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
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userProfileController.isLoading.value
                    ? Shimmer.fromColors(
                        highlightColor: AppColors.highlightColor,
                        baseColor: AppColors.baseColor,
                        child: SizedBox(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 2.8.h,
                            ),
                            title: const Text(
                              '',
                            ),
                            subtitle: const Text(
                              '',
                            ),
                            trailing: SizedBox(
                              height: 4.8.h,
                              width: 4.8.h,
                            ),
                          ),
                        ),
                      )
                    : userProfileController.userProfile.value == null
                        ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 2.8.h,
                              backgroundImage:
                                  const AssetImage('assets/pngs/profile.png'),
                            ),
                            title: Text(
                              'Hello Mid Admin',
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.px,
                                  color: const Color(0xff2F3542)),
                            ),
                            subtitle: Text('Welcome Back',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.px,
                                    color: const Color(0xff2F3542))),
                            trailing: GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                  height: 4.8.h,
                                  width: 4.8.h,
                                  child: svgImage(
                                      'assets/svgs/midadminnotification.svg')),
                            ),
                          )
                        : ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: GestureDetector(
                              onTap: () {
                                openChooseEditProfile(
                                  context,
                                  name: userProfileController
                                      .userProfile.value!.fullname,
                                  profileImage:
                                      "${userProfileController.userProfile.value!.profilePic}",
                                );
                              },
                              child: userProfileController
                                          .userProfile.value!.profilePic !=
                                      null
                                  ? CircleAvatar(
                                      radius: 2.8.h,
                                      backgroundImage: NetworkImage(
                                          userProfileController
                                              .userProfile.value!.profilePic))
                                  : CircleAvatar(
                                      radius: 2.8.h,
                                      backgroundImage: const AssetImage(
                                          'assets/pngs/profile.png'),
                                    ),
                            ),
                            title: Text(
                              userProfileController.userProfile.value!.fullname,
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.px,
                                  color: const Color(0xff2F3542)),
                            ),
                            subtitle: Text('Welcome Back',
                                style: TextStyle(
                                    fontFamily: 'light',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.px,
                                    color: const Color(0xff2F3542))),
                            trailing: GestureDetector(
                              onTap: () {
                                Get.to(()=>const MidAdminNotiFicationScreen());
                              },
                              child: SizedBox(
                                  height: 4.8.h,
                                  width: 4.8.h,
                                  child: svgImage(
                                      'assets/svgs/midadminnotification.svg')),
                            ),
                          ),
                getVerticalSpace(1.h),
                Text(
                  'Request Designs',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      fontSize: 14.px,
                      color: const Color(0xff191918)),
                ),
                getVerticalSpace(1.5.h),
                SizedBox(
                  height: 12.2.h,
                  child: designRequestController.isLoading.value
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: AppColors.baseColor,
                              highlightColor: AppColors.highlightColor,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: index == 0 ? 0 : .8.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.6.h, horizontal: .8.h),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(1.h),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.6.h,
                                      width: 5.6.h,
                                    ),
                                    getVerticalSpace(.8.h),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : designRequestController.getDesignRequest.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: Text(
                                "No Design Request Found",
                                style: TextStyle(
                                  fontSize: 18.px,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: designRequestController
                                  .getDesignRequest.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => BusinessProfile(
                                          businessName: designRequestController
                                              .getDesignRequest
                                              [index]!
                                              .business.name
                                              ,
                                          phoneNumber: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .phone,
                                          location:designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .location,
                                          targetArea: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .targetMapArea,
                                          description: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .description,
                                          businessId:designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .id,
                                          imagesList: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .gallery,
                                          logo: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .logo,
                                          webUrl: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .websiteUrl,
                                          fb:designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .facebookUrl,
                                          insta: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .instagramUrl,
                                          tiktok: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .tiktokUrl,
                                          linkdin: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .linkedinUrl,
                                          title: 'new',
                                          ownerId: designRequestController
                                              .getDesignRequest
                                          [index]!
                                              .business
                                              .owner
                                              ,
                                          status: "design",
                                          id: id.value,
                                          currentUserName: name.value,
                                        ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: index == 0 ? 0 : .8.h),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.6.h, horizontal: .8.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height: 5.6.h,
                                            width: 5.6.h,
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/pngs/designpng.png'),
                                              fit: BoxFit.cover,
                                            )),
                                        getVerticalSpace(.8.h),
                                        Text(
                                          designRequestController
                                              .getDesignRequest[index]!
                                              .user
                                              .fullname,
                                          style: TextStyle(
                                              fontSize: 12.px,
                                              color: const Color(0xff191918),
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'New Business',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      fontSize: 14.px,
                      color: const Color(0xff191918)),
                ),
                getVerticalSpace(1.2.h),
                getBusinessController.isLoading.value
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 1.2.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                      width: 2.h,
                                    ),
                                    getHorizentalSpace(1.h),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          );
                        },
                      )
                    : getBusinessController.pendingBusiness.value == null &&
                            getBusinessController.approvedBusiness.value ==
                                null &&
                            getBusinessController.rejectedBusinesses.value ==
                                null
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "No Businesses",
                              style: TextStyle(
                                fontSize: 18.px,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: getBusinessController
                                  .pendingBusiness.value!.businesses.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => BusinessProfile(
                                          businessName: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .name,
                                          phoneNumber: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .phone,
                                          location: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .location,
                                          targetArea: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .targetMapArea,
                                          description: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .description,
                                          businessId: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .id,
                                          imagesList: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .gallery,
                                          logo: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .logo,
                                          webUrl: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .websiteUrl,
                                          fb: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .facebookUrl,
                                          insta: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .instagramUrl,
                                          tiktok: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .tiktokUrl,
                                          linkdin: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .linkedinUrl,
                                          title: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .status,
                                          ownerId: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .owner
                                              .id,
                                          status: getBusinessController
                                              .pendingBusiness
                                              .value!
                                              .businesses[index]
                                              .status,
                                          id: id.value,
                                          currentUserName: name.value,
                                        ));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 1.2.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.6.h, vertical: 2.0.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(1.h)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 2.h,
                                                width: 2.h,
                                                child:
                                                    SvgPicture.asset(svgs[2])),
                                            getHorizentalSpace(1.h),
                                            Text(
                                              getBusinessController
                                                  .pendingBusiness
                                                  .value!
                                                  .businesses[index]
                                                  .name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'bold',
                                                  fontSize: 14.px,
                                                  color:
                                                      const Color(0xff282827)),
                                            ),
                                          ],
                                        ),
                                        const Expanded(child: SizedBox()),
                                        getBusinessController
                                                    .pendingBusiness
                                                    .value!
                                                    .businesses[index]
                                                    .status ==
                                                "pending"
                                            ? const SizedBox.shrink()
                                            : Text(
                                                getBusinessController
                                                    .pendingBusiness
                                                    .value!
                                                    .businesses[index]
                                                    .status,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.px,
                                                    color: AppColors.mainColor,
                                                    fontFamily: 'bold'),
                                              ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 2.4.h,
                                          color: const Color(0xff191918),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                getVerticalSpace(8.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
