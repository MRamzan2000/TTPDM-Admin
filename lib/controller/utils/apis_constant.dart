import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm_admin/controller/custom_widgets/app_colors.dart';

const baseUrl='https://advyro-efeje5atfcd3hrbq.canadacentral-01.azurewebsites.net/';
const getAllDesignsEP="campaign/allDesigns";
const signUpEndP="user/register";
const signInEndP="user/login";
const midAdminSignUpEndP="user/midAdmin-signup";
const verifyOtpEp="user/verify-otp";
const forgetPasswordEp="user/forgot-password";
const resetPasswordEp="user/reset-password";
const getBusinessByStatusEp="midAdmin/businesses";
const getDesignRequestEP="midAdmin/design-requests";
const uploadEP="midAdmin/upload-design";
const getAllBusinessEp="midAdmin/allBusinessesandCampaigns";
const changeBusinessStatusEp="midAdmin/change-business-status";
const getCampaignByStatusEp="midAdmin/campaigns";
const getUsersEmailEp="superAdmin/users/subscriptions";
const getAllCoinsPlanEP="superAdmin/allCoins";
const addNewCoinsPlanEP="superAdmin/addCoin";
const updateCoinsPlanEP="superAdmin/updateCoin";
const deleteCoinsPlanEP="superAdmin/delete";
const getAllSubPlanEP="superAdmin/allPlans";
const addNewSubPlanEP="superAdmin/addSubs";
const updateSubPlanEP="superAdmin/updateSubs";
const deleteSubPlanEP="superAdmin/deleteSubs";
const newAdminCodeEp="superAdmin/adminCode";
const getAllMidAdminEp="superAdmin/midAdmins";
const changeRightsMidAdminEp="superAdmin/permissions";
const businessManageRequestEP="midAdmin/requestManagement";
const businessManageRequestAdminEP="superAdmin/management-requests";
const getStatisticsEp="superAdmin/subscriptions/counts";
const getUserProfileEp="user";
const updateUserProfileEp="user/profile-pic";
const deleteMidAdminEp="superAdmin/delmidAdmin";
const getFcmTokenEP="fcm-token";
const midAdminRequestHandleEP="superAdmin/handle-request";
const getRecentBusinessEp="midAdmin/recent-businesses";
const changeCampaignStatus="midAdmin/campaign/status";
const addAnalysisEp="midAdmin/campaigns/";
const businessManageRequest="midAdmin/requestManagement";
const sendNotificationEp="user/send-notification";
const monthlyStatesEp="superAdmin/monthly-stats";
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