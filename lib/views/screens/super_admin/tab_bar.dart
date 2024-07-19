import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm_admin/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm_admin/controller/custom_widgets/widgets.dart';
import 'package:ttpdm_admin/controller/utils/alert_box.dart';

class BundlesTabBar extends StatelessWidget {
   BundlesTabBar({super.key});
 final RxInt selectedIndex=0.obs;

  @override
  Widget build(BuildContext context) {
    RxList versions=['Basic','Standard','Pro'].obs;
    RxList description=['Add 1 Business only','Add up to 3 Business only','Add up to 10 Business only'].obs;
    RxList price=['\$10','\$25','\$50'].obs;
    final RxString isSelected='Coin bundles'.obs;
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
        child: Obx(()=>
           Column(
            children: [

                 Container(
                  color: const Color(0xffE0E0DF),
                  child: Row(
                    children: [
                      GestureDetector(onTap: (){
                        isSelected.value='Coin bundles';
                      },
                        child: Container(width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.symmetric(horizontal: 6.9.h,vertical: 1.2.h),
                          color: isSelected.value=='Coin bundles'?AppColors.mainColor:Colors.transparent,
                          child: Text(
                            'Coin bundles',
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 12.px,
                                color: isSelected.value=='Coin bundles'? AppColors.whiteColor:const Color(0xff7C7C7C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      GestureDetector(onTap: (){
                        isSelected.value='Subscription';
                      },
                        child: Container(width: MediaQuery.of(context).size.width/2,
                          padding: EdgeInsets.symmetric(horizontal: 6.9.h,vertical: 1.2.h),
                          color: isSelected.value=='Subscription'?AppColors.mainColor:Colors.transparent,
                          child: Text(
                            'Subscription',
                            style: TextStyle(
                                fontFamily: 'bold',
                                fontSize: 12.px,
                                color: isSelected.value=='Subscription'?AppColors.whiteColor: const Color(0xff7C7C7C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),


              getVerticalSpace(2.4.h),
              isSelected.value=='Coin bundles'? Expanded(
                child: GridView.builder(padding: EdgeInsets.symmetric(horizontal: 2.5.h),
                  itemCount: 7,

                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2.1.h,
                      crossAxisSpacing: 1.6.h),
                  itemBuilder: (context, index) {
                    return
                        Container(alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: .5.h,vertical: .5.h),
                          height: 11.3.h,
                          width: 11.6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color:
                              AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                    color: Color(0xffFFE4EA)
                                )
                              ]
                          ),
                          child:index==6?GestureDetector(onTap: (){
                            openCreateNewPlan(context);
                          },
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [ Icon(size: 4.h,
                              Icons.add,
                              color: AppColors.mainColor,
                            ),
                              Text('Create new',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor,
                              fontSize: 12.px),)
                            ],),
                          ): Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 3.2.h,
                                  child: const Image(image: AssetImage('assets/pngs/coinicon.png')))
                              ,Text('1200',style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff4D4F53)
                              ),),
                              getVerticalSpace(1.2.h),
                              Container(  padding: EdgeInsets.symmetric(horizontal: .5.h,vertical: .5.h),
                                decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(5.h)

                                ),child: Text('\$12.80',style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'bold',
                                    fontSize: 12.px,
                                    color:AppColors.whiteColor

                                ),),
                              )
                            ],
                          ),
                        );

                  },),
              ):
              ListView.builder(padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: versions.length,
                itemBuilder: (context, index) {
                return GestureDetector(onTap: (){
                  openSubscription(context);

                },
                  child: Container(alignment: Alignment.topCenter,
                    padding:  EdgeInsets.symmetric(vertical: 1.2.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 3.5.h,vertical: 1.6.h),
                    decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(2.h),

                  ),child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                    Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                    Text(versions[index],style: TextStyle(
                      fontSize: 14.px,
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold'
                    ),),
                    getVerticalSpace(.8.h),
                    Text(price[index],style: TextStyle(
                        fontSize: 16.px,
                        color:const Color(0xff191918),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold'
                    ),),
                    getVerticalSpace(.8.h),
                    Text(description[index],style: TextStyle(
                        fontSize: 12.px,
                        color:const Color(0xff444545),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold'
                    ),),


                               ],),    const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 2.h
                       ),
                        child: Text('Edit',style: TextStyle(
                            fontSize: 10.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff007AFF)
                        ),),
                      )
                              ],),),
                );
              },),
            ],
          ),
        ),
      ),
    );
  }
}
