import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/auth_apis.dart';

class CreateNewPasswordController extends GetxController {
  final BuildContext context;
  CreateNewPasswordController(this.context);
  //create New Password
  final RxBool isLoading = false.obs;
  Future<void> createNewPassword(
      {required String newPassword,
      required String confirmPassword,
      required String token,
      required String userId}) async {
    try {
      isLoading.value = true;
      AuthApis(context: context)
          .resetPassword(
              newPassword: newPassword,
              confirmPassword: confirmPassword,
              token: token)
          .then(
            (value) => isLoading.value = false,
          );
    } catch (e) {
      log("unexpected error occurred :${e.toString()}");
    }
  }
}
