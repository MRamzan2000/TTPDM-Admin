import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/models/get_all_design_request_model.dart';
import 'package:http/http.dart'as http;
class GetAllDesignApi{
  final BuildContext context;
  GetAllDesignApi({required this.context});
  //GetBusiness Profile
  Future<List<GetAllDesignRequestModel>?> getAllDesignRequest(
      {required BuildContext context, }) async {
    final url = Uri.parse("$baseUrl/$getDesignRequestEP");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      log("before jsonBody:${response.body}");
      log("before jsonBody:${response.statusCode}");

      if (response.statusCode == 200) {
        log("jsonBody:${jsonDecode(response.body)}");
        return getAllDesignRequestModelFromJson(response.body);
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }
  //Upload Design
  Future<void> uploadDesign({
    required String token,
    required File design, // Expecting a File object for image
    required BuildContext context,
  }) async {
    final url = Uri.parse('$baseUrl/$uploadEP');

    // Prepare multipart request
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
      });

    // Add image to request
    if (design.existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'designs', // Ensure this matches the expected field name on the server
          design.path,
          contentType: MediaType('image', 'jpeg'), // Adjust if using other image formats
        ),
      );
    } else {
      log('File does not exist or is invalid.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid file or file does not exist.')),
      );
      return;
    }

    try {
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Design uploaded successfully')),
          );
        }
      } else {
        log('Failed to upload design. Status code: ${response.statusCode}, Response body: $responseBody');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload design.')),
          );
        }
      }
    } catch (e) {
      log('Exception: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred while uploading the design.')),
        );
      }
    }
  }
}