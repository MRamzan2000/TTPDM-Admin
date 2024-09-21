import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm_admin/controller/apis_services/poster_apis.dart';
import 'package:ttpdm_admin/models/getdesigns_model.dart';


class PosterController extends GetxController {
  final BuildContext context;
  PosterController({required this.context});
  //fetch All Designs

  Rxn<GetAllDesignsModel?> allPosters = Rxn<GetAllDesignsModel>();
  RxBool isLoading = true.obs;
  Future<void> fetchPosters({
    required BuildContext context,
    required bool loading,
  }) async {
    try {
      isLoading.value = loading;
      final data = await PosterApis(context: context).getAllDesigns();
      if (data != null) {
        allPosters.value = data;
      } else {
        allPosters.value = GetAllDesignsModel(designs: []);
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Unexpected error occurred: ${e.toString()}")));
      }
    } finally {
      isLoading.value = false;
    }
  }

}
