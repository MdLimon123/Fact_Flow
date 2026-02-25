import 'dart:io';
import 'package:fact_flow/models/about_us_model.dart';
import 'package:fact_flow/models/privacy_police_model.dart';
import 'package:fact_flow/models/terms_of_service_model.dart';
import 'package:fact_flow/models/user_info_model.dart';
import 'package:fact_flow/services/api_client.dart';
import 'package:fact_flow/utils/images_utils.dart';
import 'package:fact_flow/views/base/custom_snackbar.dart';
import 'package:fact_flow/views/screen/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLaoding = false.obs;
  var userInfo = UserInfoModel().obs;

  var aboutUsData = AboutUsModel().obs;

  var privacyPoliceData = PrivacyPolicyModel().obs;
  var termsOfServiceData = TermsOfServiceModel().obs;

  var changePasswordLoading = false.obs;

  var uploadProfileLoading = false.obs;

  Rx<File?> userProfileImage = Rx<File?>(null);

  Future<void> pickUserProfileImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );

    if (pickedFile != null) {
      userProfileImage.value = pickedFile;
    }
  }

  Future<void> fetchUserInfo() async {
    isLaoding(true);

    final response = await ApiClient.getData("/profile");

    if (response.statusCode == 200) {
      userInfo.value = UserInfoModel.fromJson(response.body);
    } else {
      debugPrint("body ===============> ${response.body}");
    }
    isLaoding(false);
  }

  Future<void> updateProfile({
    required String imagePath,
    required String name,
  }) async {
    uploadProfileLoading(true);
    List<MultipartBody> multipartBody = [];

    if (imagePath.isNotEmpty) {
      multipartBody.add(MultipartBody('avatar', File(imagePath)));
    }

    Map<String, String> fromData = {"name": name};

    final response = await ApiClient.patchMultipartData(
      "/profile/edit",
      fromData,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      fetchUserInfo();
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    uploadProfileLoading(false);
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    changePasswordLoading(true);

    final body = {"oldPassword": oldPassword, "newPassword": newPassword};

    final response = await ApiClient.postData("/profile/change-password", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    changePasswordLoading(false);
  }

  Future<void> deleteAccount() async {
    isLaoding(true);
    final response = await ApiClient.deleteData("/profile/delete");
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => LoginScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLaoding(false);
  }

  Future<void> fetchAboutUs() async {
    isLaoding(true);

    final response = await ApiClient.getData('/context-pages/about-us');
    if (response.statusCode == 200 || response.statusCode == 201) {
      aboutUsData.value = AboutUsModel.fromJson(response.body);
    } else {
      debugPrint(response.body);
    }
    isLaoding(false);
  }

  Future<void> fetchPrivacyPolice() async {
    isLaoding(true);

    final response = await ApiClient.getData('/context-pages/privacy-policy');
    if (response.statusCode == 200 || response.statusCode == 201) {
      privacyPoliceData.value = PrivacyPolicyModel.fromJson(response.body);
    } else {
      debugPrint(response.body);
    }
    isLaoding(false);
  }

  Future<void> fetchTermsOfService() async {
    isLaoding(true);
    final response = await ApiClient.getData("/context-pages/terms");

    if (response.statusCode == 200 || response.statusCode == 201) {
      termsOfServiceData.value = TermsOfServiceModel.fromJson(response.body);
    } else {
      debugPrint(response.body);
    }
    isLaoding(false);
  }

  Future<void> submitComment({
    required String name,
    required String email,
    required String commnet,
  }) async {
    isLaoding(true);

    final body = {"name": name, "email": email, "message": commnet};

    final response = await ApiClient.postData("/mails", body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLaoding(false);
  }
}
