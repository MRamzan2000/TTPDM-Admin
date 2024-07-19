import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';

class UsersEmail extends StatelessWidget {
   UsersEmail({super.key});
final RxList<String>emailsList=<String>['Itsmohsinar@gmail.com','Itsmohsinar@gmail.com',
'Itsmohsinar@gmail.com','Itsmohsinar@gmail.com','Itsmohsinar@gmail.com','Itsmohsinar@gmail.com'].obs;
   final RxList<String>versions=<String>['Standard','Pro',
     'Basic','Standard','Pro','Basic'].obs;
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
          padding:  EdgeInsets.symmetric(horizontal: 1.h),
          child: Column(
            children: [
              getVerticalSpace(2.h),
              Container(padding: EdgeInsets.symmetric(horizontal: 1.5.h,
               vertical: 1.4.h),
                decoration: BoxDecoration(
                    color: const Color(0xffFF7A2C).withOpacity(0.50),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.h),
                        topRight: Radius.circular(2.h))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Email',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918),
                          fontFamily: 'bold',
                          fontSize: 16.px),
                    ),
                    Text('Plan',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918),
                            fontFamily: 'bold',
                            fontSize: 16.px)),
                  ],
                ),
              ),
              ListView.builder(padding:EdgeInsets.zero,
                itemCount: emailsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return Container(padding: EdgeInsets.all(1.5.h),
                color: index==1||index==4?AppColors.whiteColor:Colors.transparent,
                child:   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        emailsList[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918),
                            fontFamily: 'bold',
                            fontSize: 16.px),
                      ),
                      Text(versions[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor,
                              fontFamily: 'bold',
                              fontSize: 16.px)),

                    ],
                  ),
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
