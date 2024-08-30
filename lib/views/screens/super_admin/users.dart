import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/getx_controllers/get_users_emails_controller.dart';

class UsersEmail extends StatefulWidget {
  const UsersEmail({super.key});

  @override
  State<UsersEmail> createState() => _UsersEmailState();
}

class _UsersEmailState extends State<UsersEmail> {
  late GetUserEmailController getUserEmailController;

  @override
  void initState() {
    super.initState();
    getUserEmailController = Get.put(GetUserEmailController(context));
    getUserEmailController.fetchUserEmail(
        loading: getUserEmailController.getAllEmail.isEmpty
    );
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
              color: AppColors.mainColor
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: Obx(
                () => Column(
              children: [
                getVerticalSpace(2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.4.h),
                  decoration: BoxDecoration(
                      color: const Color(0xffFF7A2C).withOpacity(0.50),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.h),
                          topRight: Radius.circular(2.h)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918),
                            fontFamily: 'bold',
                            fontSize: 16.px
                        ),
                      ),
                      Text(
                        'Plan',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918),
                            fontFamily: 'bold',
                            fontSize: 16.px
                        ),
                      ),
                    ],
                  ),
                ),
                getUserEmailController.isLoading.value
                    ? Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        highlightColor: AppColors.highlightColor,
                        baseColor: AppColors.baseColor,
                        child: Container(
                          height: 8.h,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(1.5.h),
                          child:  Container(
                          height: 8.h,
                          color: Colors.grey[300],
                          ),
                      ));
                    },
                  ),
                )
                    : getUserEmailController.getAllEmail.isEmpty
                    ? Expanded(
                  child: Center(
                    child: Text(
                      "No Users Found",
                      style: TextStyle(
                        fontSize: 18.px,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold',
                      ),
                    ),
                  ),
                )
                    : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getUserEmailController.getAllEmail.length,
                    itemBuilder: (context, index) {
                      final email = getUserEmailController.getAllEmail[index]!;
                      return Container(
                        padding: EdgeInsets.all(1.5.h),
                        color: email.subscriptionPlan.name == "PRO"
                            ? AppColors.whiteColor
                            : Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              email.email.length >= 18
                                  ? "${email.email.substring(0, 18)}..."
                                  : email.email,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                  fontFamily: 'bold',
                                  fontSize: 16.px
                              ),
                            ),
                            Text(
                              email.subscriptionPlan.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mainColor,
                                  fontFamily: 'bold',
                                  fontSize: 12.px
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                getVerticalSpace(3.3.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
