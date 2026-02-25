import 'dart:async';

import 'package:fact_flow/controllers/data_controller.dart';
import 'package:fact_flow/helpers/prefs_helper.dart';
import 'package:fact_flow/services/api_client.dart';
import 'package:fact_flow/utils/app_constants.dart';
import 'package:fact_flow/views/base/custom_snackbar.dart';
import 'package:fact_flow/views/screen/Auth/email_verification_screen.dart';
import 'package:fact_flow/views/screen/Auth/login_screen.dart';
import 'package:fact_flow/views/screen/Auth/otp_verification_screen.dart';
import 'package:fact_flow/views/screen/Auth/reset_password_screen.dart';
import 'package:fact_flow/views/screen/Home/home_screen.dart';
import 'package:fact_flow/views/screen/subscription/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isResetLoading = false.obs;
  var otp = "".obs;
  var isForgetOtp = "".obs;
  var isLoading = false.obs;
  var isVerifyLoading = false.obs;

  var isVerify = false.obs;

  var isForgetLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  RxBool isGoogleLoading = false.obs;

  var isAgree = false.obs;

  final _dataController = Get.put(DataController());

  var secondsRemainigInForget = 60.obs;
  var showForgetButton = false.obs;
  var secondsRemaining = 60.obs;
  var showResendButton = false.obs;
  Timer? timer;
  Timer? forgetTime;

  void startTimer() {
    showResendButton.value = false;
    secondsRemaining.value = 60;

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        showResendButton.value = true;
        timer?.cancel();
      }
    });
  }

  void startTimerInForget() {
    showForgetButton.value = false;
    secondsRemainigInForget.value = 60;

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemainigInForget.value > 0) {
        secondsRemainigInForget.value--;
      } else {
        showForgetButton.value = true;
        forgetTime?.cancel();
      }
    });
  }

  void resendCode({required String email}) {
    resendOtpVerify(email: email);
    startTimer();
  }

  void resendCodeInForget({required String email}) {
    forgetPassword(email: email);
    startTimerInForget();
  }

  @override
  void onClose() {
    timer?.cancel();
    forgetTime?.cancel();
    super.onClose();
  }

  Future<void> login({required String email, required String password}) async {
    isLoading(true);

    final body = {"email": email, "password": password};

    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/login",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body['access_token'],
      );
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => HomeScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  Future<void> signup({required String email, required String password}) async {
    isLoading(true);

    final body = {"email": email, "password": password};
    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/register",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => EmailVerificationScreen(email: email));
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  Future<void> accountVeryfy({required String email}) async {
    isVerifyLoading(true);

    final body = {"email": email, "otp": otp.value};
    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/account-verify",
      body,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body['access_token'],
      );

      _dataController.saveUserData(response.body['user']);
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => SubscriptionScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isVerifyLoading(false);
  }

  Future<void> resendOtpVerify({required String email}) async {
    final body = {"email": email};
    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/account-verify/otp-send",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
  }

  Future<void> forgetPassword({required String email}) async {
    isForgetLoading(true);

    final body = {"email": email};

    var headers = {'Content-Type': 'application/json'};

    final resposne = await ApiClient.postData(
      "/auth/forgot-password",
      body,
      headers: headers,
    );

    if (resposne.statusCode == 200 || resposne.statusCode == 201) {
      showCustomSnackBar(resposne.statusText, isError: false);

      Get.to(() => OtpVerificationScreen(email: email));
    } else {
      showCustomSnackBar(resposne.statusText, isError: true);
    }
    isForgetLoading(false);
  }

  Future<void> otpForgetVerify({required String email}) async {
    isVerify(true);
    final body = {"email": email, "otp": isForgetOtp.value};

    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/forgot-password/otp-verify",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body['reset_token'],
      );
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => ResetPasswordScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isVerify(false);
  }

  Future<void> resetPassword({required String passwordText}) async {
    isResetLoading(true);

    final body = {"password": passwordText};

    final response = await ApiClient.postData("/auth/reset-password", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => LoginScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isResetLoading(false);
  }

  Future<void> googleLogin() async {
    isGoogleLoading(true);

    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        isGoogleLoading(false);
        return;
      }

      final auth = await account.authentication;
      final accessToken = auth.accessToken;

      if (accessToken == null) {
        isGoogleLoading(false);
        return;
      }

      final body = {"access_token": accessToken};

      final response = await ApiClient.postData('/auth/google-login', body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.setString(
          AppConstants.bearerToken,
          response.body['access_token'],
        );
        showCustomSnackBar(response.statusText, isError: false);
        Get.to(() => HomeScreen());
      } else {
        showCustomSnackBar(response.statusText, isError: true);
      }
    } catch (e) {
      debugPrint("Google Loing Fail : $e");
    }
    isGoogleLoading(false);
  }


}
