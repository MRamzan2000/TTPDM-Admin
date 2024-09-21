import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ttpdm_admin/controller/utils/apis_constant.dart';
import 'package:ttpdm_admin/controller/utils/my_sharedpreference.dart';
import 'package:ttpdm_admin/controller/utils/preference_keys.dart';
import 'package:ttpdm_admin/views/bottom_navigation_bar.dart';
import 'package:ttpdm_admin/views/screens/auth_section/create_new_password.dart';
import 'package:ttpdm_admin/views/screens/auth_section/login_screen.dart';
import 'package:ttpdm_admin/views/screens/auth_section/otp_verification.dart';
import 'package:ttpdm_admin/views/screens/super_admin/bottom_bar.dart';

class AuthApis {
  final BuildContext context;
  AuthApis({required this.context});
  final MySharedPreferences preferencesService = MySharedPreferences();
//Mid Admin SignUp
  Future<void> midAdminSignUPApis({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String adminCode,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    final url = Uri.parse("$baseUrl/$midAdminSignUpEndP");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "fullname": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "Code": adminCode,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": role,
    });

    try {
      Response response = await post(url, body: body, headers: headers);

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered successfully')),
          );
        }

        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return OtpVerification(
                email: email,
                title: 'signUp',
              );
            },
          ));
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('errors')) {
          if (context.mounted) {
            String errorMessage = responseBody['errors'].isNotEmpty
                ? responseBody['errors'].first['msg']
                : 'An error occurred';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
            log('errorMessage : $errorMessage');
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('An unexpected error occurred: ${response.body}')),
            );
            log('errorMessage : ${response.body}');
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: ${response.body}')),
          );
          log('errorMessage : ${response.body}');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        log('catch error : ${e.toString()}');
      }
    }
  }

  //Login Api hit
  Future<void> loginApis({
    required email,
    required password,
    required fcmToken,
  }) async {
    final url = Uri.parse("$baseUrl/$signInEndP");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "password": password,
      "fcmToken": fcmToken,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      log("response body :$responseBody");
      MySharedPreferences.setString(authToken, responseBody["token"]);
      MySharedPreferences.setString(userId, responseBody["user"]["_id"]);
      MySharedPreferences.setString(userName, responseBody["user"]["fullname"]);
      if (context.mounted) {
        MySharedPreferences.setBool(isLoggedInKey, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
      }
      if (context.mounted) {

        if (responseBody["user"]["role"] == "mid admin") {
          MySharedPreferences.setString(role, "mid admin");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const CustomBottomNavigationBar();
            },
          ));
        } else {
          MySharedPreferences.setString(role, "super admin");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const BottomNavigationBarAdmin();
            },
          ));
        }
      }
    } else  {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody["message"])),
        );
      }
    }

  }

//OtpVerify Api
  Future<void> forgetPassword({
    required String email,
  }) async {
    final url = Uri.parse("$baseUrl/$forgetPasswordEp");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
    });

    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Change to the success status code
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP sent to email')),
        );
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return OtpVerification(
              title: 'resetpassword',
              email: email,
            );
          },
        ));
      }
    }
    else if (response.statusCode == 404) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
    }
  }

//OtpVerify Api
  Future<void> verifyOtp({
    required email,
    required otp,
    required title,
  }) async {
    final url = Uri.parse("$baseUrl/$verifyOtpEp");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "otp": otp,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log("Token is That :${responseBody["token"]}");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully')),
        );
      }
      if (context.mounted) {
        if (title == "signUp") {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ));
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const CreateNewPassword();
            },
          ));
        }
      }
    } else if (response.statusCode == 400) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid or expired OTP')),
        );
      }
    }
  }

  //Reset Your Password Api
  Future<void> resetPassword(
      {required String newPassword,
      required String confirmPassword,
      required String token}) async {
    final url = Uri.parse("$baseUrl/$resetPasswordEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final body = jsonEncode({
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
    Response response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully')),
        );
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody["message"])),
        );
      }
    }
  }
}
