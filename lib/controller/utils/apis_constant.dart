import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';

const baseUrl='https://advyro-efeje5atfcd3hrbq.canadacentral-01.azurewebsites.net/';
const signUpEndP="user/register";
const signInEndP="user/login";
const verifyOtpEp="user/verify-otp";
const forgetPasswordEp="user/forgot-password";
const resetPasswordEp="user/reset-password";
const getBusinessByStatusEp="midAdmin/businesses";
const getDesignRequestEP="midAdmin/design-requests";
const getAllBusinessEp="midAdmin/allBusinessesandCampaigns";
const getCampaignByStatusEp="midAdmin/campaigns";
const getUsersEmailEp="superAdmin/users/subscriptions";
const getAllCoinsPlanEP="superAdmin/allCoins";


final spinkit = Container(
  alignment: Alignment.centerLeft,
  height: 3.h,

  child: SpinKitThreeBounce(
    size: 3.h,

    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:  AppColors.whiteColor
        ),
      );
    },
  ),
);

 final spinkit1 =  Center(
  child: SpinKitWaveSpinner(
    color: AppColors.mainColor,
    size: 30.h,
  )
  ,
);