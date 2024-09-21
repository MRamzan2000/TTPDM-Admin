import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ttpdm_admin/controller/apis_services/admin_apis.dart';
import 'package:ttpdm_admin/models/get_all_mid_admins_model.dart';
import 'package:ttpdm_admin/models/get_new_admin_code_model.dart';

class AdminController extends GetxController {
  final BuildContext context;
  AdminController({required this.context});
  //Get All Mid Admins
  RxList<GetAllMidAdminsModel?> allMidAdmins = <GetAllMidAdminsModel?>[].obs;

  final RxBool isLoading = true.obs;
  Future<void> fetchAllMidAdmins({required bool loading}) async {
    try {
      isLoading.value = loading;
      final data = await AdminApis(context: context).getAllMidAdminsApiMethod();

      if (data != null) {
        // Ensure data is not null and filter out any null values
        allMidAdmins.value = data;
      } else {
        allMidAdmins.value = [];
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred ${e.toString()}")));
      }
      allMidAdmins.value = [];
    } finally {
      isLoading.value = false;
    }
  }

//Get Admin Code
  Rxn<GetNewAdminCodeModel?> adminCode = Rxn<GetNewAdminCodeModel>();
  RxBool adminCodeLoading = true.obs;
  Future<void> fetchAdminCode(
      {required String token, required bool loading}) async {
    try {
      adminCodeLoading.value = loading;

      final data = await AdminApis(context: context)
          .getNewAdminCodeApiMethod(token: token);
      adminCodeLoading.value = false;

      if (data != null) {
        log("Data is not null");
        adminCode.value = data;
      } else {
        adminCode.value = null;
        log("Data is null");
      }
    } catch (e) {
      if (context.mounted) {
        log("catch");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred ${e.toString()}")));
      }
      adminCode.value = null;
      adminCodeLoading.value = false;
    }
  }

  //Get update MidAdminRights
  RxBool updateLoading = false.obs;

  Future<void> updateMidAdminRights({
    required String adminId,
    required bool campaignPermission,
    required bool designAdPermission,
    required bool businessesPermission,
  }) async {
    try {
      updateLoading.value = true;
      AdminApis(context: context)
          .updateRightsMidAdminApiMethod(
              adminId: adminId,
              campaignPermission: campaignPermission,
              designAdPermission: designAdPermission,
              businessesPermission: businessesPermission)
          .then(
        (value) {
          updateLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred ${e.toString()}")));
      }
      updateLoading.value = false;
    }
  }

  //Share outSide App
  void shareApp({required String adminCode}) {
    // Replace with your app's link

    Share.share('Admin Code:$adminCode');
  }

  //Delete Mid Admin
  Future<void> deleteMidAdmin({required String id}) async {
    try {
      AdminApis(context: context)
          .deleteMidAdminMethodApi(id: id, context: context);
    } catch (e) {
      log("unexpected error occurred :${e.toString()}");
    }
  }

  //handle Business Manage Request
  final RxBool updateBusinessManageLoading = false.obs;
  final RxBool updateBusinessManageLoading1 = false.obs;
  Future<void> updateBusinessManageRequest({
    required String requestId,
    required String status,
  }) async {
    try {
      if(status=="approve"){
        updateBusinessManageLoading.value = true;

      }else{
        updateBusinessManageLoading1.value = true;

      }
      AdminApis(context: context)
          .handleBusinessManageRequest(requestId: requestId, status: status)
          .then(
        (value) {
          updateBusinessManageLoading.value = false;
          updateBusinessManageLoading1.value = false;
        },
      );
    } catch (e) {
      updateBusinessManageLoading.value = false;
      updateBusinessManageLoading1.value = false;
      log("unexpected error occurred :${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("unexpected error occurred :${e.toString()}")));
    }
  }
}
