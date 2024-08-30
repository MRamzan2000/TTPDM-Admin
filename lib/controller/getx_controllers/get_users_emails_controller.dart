import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/get_users_emails_model.dart';
import '../apis_services/get_emails_apis.dart';

class GetUserEmailController extends GetxController {
  final BuildContext context;
  GetUserEmailController(
    this.context,
  );
  //getUsersEmail
  final RxList<GetUsersModel?> getAllEmail = RxList<GetUsersModel>();
  final RxBool isLoading = true.obs;

  Future<void> fetchUserEmail({required bool loading}) async {
    try {
      isLoading.value = loading;
      final api = UsersApis(context: Get.context!);
      final data = await api.userEmail();

      if (data != null) {
        getAllEmail.value = data;
        log("when data not null:$getAllEmail");
      } else {
        getAllEmail.value = []; // Handle case when data is null
        log("when data empty:$getAllEmail");

      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      getAllEmail.value = []; // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
}
