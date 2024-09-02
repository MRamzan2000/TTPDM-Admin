import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/user_profile_api.dart';
import 'package:ttpdm_admin/models/get_user_profile_model.dart';

class UserProfileController extends GetxController {
  final BuildContext context;
  UserProfileController({required this.context});
  //fetch User Profile Data
  Rxn<GetUserProfileModel?> userProfile = Rxn<GetUserProfileModel>();

  final RxBool isLoading = true.obs;
  Future<void> fetchUserProfile({
    required bool loading,
    required String id,
  }) async {
    try {
      isLoading.value = loading;
      final data =
          await UserProfileApi(context: context).getUserProfile(id: id);

      if (data != null) {
        // Ensure data is not null and filter out any null values
        userProfile.value = data;
        log("user data :${userProfile.value}");
      } else {
        userProfile.value = null;
        log("user data is null:${userProfile.value}");

      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred ${e.toString()}")));
      }
      userProfile.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
