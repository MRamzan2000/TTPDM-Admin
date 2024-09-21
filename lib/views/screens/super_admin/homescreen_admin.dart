import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_statistics_controller.dart';
import 'package:ttpdm_admin/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/screens/notification_section/super_admin_notification_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final RxList<String> profilesList =
      <String>['Total users', 'Campaigns', 'Cancellation', 'Return Rate'].obs;

  final RxList<String> valuesList =
      <String>['+2.5%', '+0.5% ', '-1.5%', '+2.5%'].obs;

  final RxList<String> numbers = <String>['10289', '20921', '149', '17390'].obs;

  final RxList<String> descriptionList = <String>[
    "Compared to(21340 last Month)",
    'Compared to(19000 last Month)',
    'Compared to(165 last Month)',
    'Compared to(10500 last Month)'
  ].obs;
  final RxList<Color> allColors = [
    const Color(0xff0062FF),
    const Color(0xffFF974A),
    const Color(0xff3DD598)
  ].obs;
  late UserProfileController userProfileController;
  late GetStatisticsController getStatisticsController;
  @override
  void initState() {
    super.initState();
    getStatisticsController =
        Get.put(GetStatisticsController(context: context));
    userProfileController = Get.put(UserProfileController(context: context));
    String id = MySharedPreferences.getString(userId);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await userProfileController.fetchUserProfile(
          loading: userProfileController.userProfile.value == null, id: id);
      await getStatisticsController.fetchMonthlyStates(
          loading: getStatisticsController.monthlyStatics.value == null);
      await getStatisticsController.fetchStatistics(
          loading: getStatisticsController.statics.value == null);
    });
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
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: Column(
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
                                Get.to(
                                    () => const SuperAdminNotiFicationScreen());
                              },
                              child: SizedBox(
                                  height: 4.8.h,
                                  width: 4.8.h,
                                  child: svgImage(
                                      'assets/svgs/midadminnotification.svg')),
                            ),
                          ),
                getVerticalSpace(1.h),
                getStatisticsController.statisticsLoading.value
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profilesList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: .6.h,
                          mainAxisSpacing: .6.h,
                        ),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: AppColors.baseColor,
                            highlightColor: AppColors.highlightColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.8.h, vertical: 1.7.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.h),
                                color: Colors
                                    .white, // Assuming AppColors.whiteColor is Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getVerticalSpace(1.1.h),
                                  const Text(
                                    "",
                                  ),
                                  getVerticalSpace(1.h),
                                  const Text(
                                    "",
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profilesList.length,
                          padding:
                              const EdgeInsets.all(8.0), // Adjusted padding
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0, // Adjusted spacing
                            mainAxisSpacing: 4.0, // Adjusted spacing
                            childAspectRatio: 1.24,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, // Adjusted padding
                                vertical: 8.0, // Adjusted padding
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: profilesList[index],
                                            style: TextStyle(
                                              color: const Color(0xff171725),
                                              fontSize: 14.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${index == 0 ? getStatisticsController.totalUserPercentage : index == 1 ? getStatisticsController.cancellationPercentage : index == 2 ? getStatisticsController.cancellationPercentage : getStatisticsController.returnRatePercentage.value}",
                                            style: TextStyle(
                                              color: (index == 0 &&
                                                          getStatisticsController
                                                              .totalUser.value) ||
                                                      (index == 1 &&
                                                          getStatisticsController
                                                              .campaign
                                                              .value) ||
                                                      (index == 2 &&
                                                          getStatisticsController
                                                              .cancellation
                                                              .value)
                                                  ? const Color(0xff3DD598)
                                                  : const Color(0xffFC5A5A),
                                              fontSize: 14.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SvgPicture.asset(
                                        (index == 0 &&
                                                    getStatisticsController
                                                        .totalUser.value) ||
                                                (index == 1 &&
                                                    getStatisticsController
                                                        .campaign.value) ||
                                                (index == 2 &&
                                                    getStatisticsController
                                                        .cancellation.value)
                                            ? 'assets/svgs/arrowup.svg'
                                            : 'assets/svgs/arrowdown.svg',
                                      ),
                                    ],
                                  ),
                                  // Other Text Widgets
                                  Text(
                                    index == 0
                                        ? "${getStatisticsController.monthlyStatics.value!.totalUsers.thisMonth}"
                                        : index == 1
                                            ? "${getStatisticsController.monthlyStatics.value!.campaigns.created.thisMonth}"
                                            : index == 2
                                                ? "${getStatisticsController.monthlyStatics.value?.cancellations.thisMonth}"
                                                : "${getStatisticsController.monthlyStatics.value?.returnRate.thisMonth}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'bold',
                                      fontSize: 26.px,
                                      color: const Color(0xff171725),
                                    ),
                                  ),
                                  // Comparison Text
                                  Text(
                                    index == 0
                                        ? "Compared to( ${getStatisticsController.monthlyStatics.value?.totalUsers.lastMonth} last Month)"
                                        : index == 1
                                            ? "Compared to( ${getStatisticsController.monthlyStatics.value?.campaigns.created.lastMonth} last Month)"
                                            : index == 2
                                                ? "Compared to( ${getStatisticsController.monthlyStatics.value?.cancellations.lastMonth} last Month)"
                                                : "Compared to( ${getStatisticsController.monthlyStatics.value?.returnRate.lastMonth} last Month)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'regular',
                                      fontSize: 13.px,
                                      color: const Color(0xff92929D),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                getVerticalSpace(1.4.h),
                getStatisticsController.statsLoading.value
                    ? Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        child: Container(
                          height: 20.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.7.h, vertical: 1.9.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.h),
                              color: AppColors.whiteColor),
                        ),
                      )
                    : getStatisticsController.statics.value == null
                        ? Text(
                            "No Plan Count Buy",
                            style: CustomTextStyles.buttonTextStyle
                                .copyWith(color: AppColors.mainColor),
                          )
                        : Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.7.h, vertical: 1.9.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.h),
                                  color: AppColors.whiteColor),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset('assets/svgs/left.svg'),
                                      Text(
                                        'Subscription ',
                                        style: TextStyle(
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.px,
                                            color: const Color(0xff171725)),
                                      ),
                                      SvgPicture.asset('assets/svgs/right.svg'),
                                    ],
                                  ),
                                  getVerticalSpace(1.h),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      chart(context,
                                          basic: getStatisticsController
                                              .statics.value!.plans[0].count
                                              .toDouble(),
                                          standard: getStatisticsController
                                              .statics.value!.plans[1].count
                                              .toDouble(),
                                          pro: getStatisticsController
                                              .statics.value!.plans[2].count
                                              .toDouble()),
                                      Column(
                                        children: [
                                          Text(
                                            getStatisticsController
                                                .statics.value!.users
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 16.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff171725),
                                            ),
                                          ),
                                          Text(
                                            'User this year',
                                            style: TextStyle(
                                              fontSize: 08.px,
                                              fontFamily: 'regular',
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff696974),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  getVerticalSpace(2.h),
                                  Expanded(
                                    child: GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: .6.h,
                                        crossAxisSpacing: .5.w,
                                        childAspectRatio: 1 / 0.13,
                                      ),

                                      itemCount: getStatisticsController
                                          .statics
                                          .value!
                                          .plans
                                          .length, // Number of items in the grid
                                      itemBuilder: (context, index) {
                                        final plan = getStatisticsController
                                            .statics.value!.plans[index];
                                        return _buildStatisticItem(
                                          color: allColors[
                                              index], // Replace with actual color
                                          label: plan.plan.isEmpty
                                              ? "No Plan"
                                              : plan
                                                  .plan, // Replace with actual label
                                          count: plan.count
                                              .toString(), // Replace with actual count
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                getVerticalSpace(2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticItem({
    required Color color,
    required String label,
    required String count,
  }) {
    return Row(
      children: [
        Container(
          height: 8.h,
          width: 5.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: color,
          ),
        ),
        SizedBox(width: 5.w), // Horizontal space
        Text(
          label,
          style: TextStyle(
            color: const Color(0xff44444F),
            fontSize: 15.sp, // Adjust according to your screen size
            fontWeight: FontWeight.w400,
            fontFamily: 'regular',
          ),
        ),
        getHorizentalSpace(2.h),
        Text(
          count,
          style: TextStyle(
            color: const Color(0xff44444F),
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'bold',
          ),
        ),
      ],
    );
  }

  Widget chart(
    BuildContext context, {
    required double basic,
    required double standard,
    required double pro,
  }) {
    final List<ChartData> chartData = [
      ChartData('Basic', basic, const Color(0xff0062FF)),
      ChartData('Standard', standard, const Color(0xffFF974A)),
      ChartData('Pro', pro, const Color(0xff3DD598)),
    ];

    return SizedBox(
      height: 16.h,
      width: 16.h,
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            strokeWidth: 2,
            innerRadius: '80%',
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
