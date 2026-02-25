import 'dart:io';

import 'package:fact_flow/models/ai_response_model.dart';
import 'package:fact_flow/services/api_client.dart';
import 'package:fact_flow/utils/images_utils.dart';
import 'package:fact_flow/views/base/custom_snackbar.dart';
import 'package:fact_flow/views/screen/Home/AllSubScreen/ai_result_screen.dart';
import 'package:fact_flow/views/screen/Home/AllSubScreen/processing_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var aiResponseResult = AiResponseModel().obs;

  RxString pdfName = ''.obs;
  RxString pdfPath = "".obs;

  Rx<File?> pickImage = Rx<File?>(null);

  Future<void> pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        pdfName.value = result.files.single.name;
        pdfPath.value = result.files.single.path ?? "";
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick PDF file: $e');
    }
  }

  void clearPdf() {
    pdfName.value = '';
  }

  Future<void> pickImageGellary({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      pickImage.value = pickedFile;
    }
  }

  Future<void> submitText({required String text}) async {
    isLoading(true);

    Get.to(() => ProcessingScreen());

    final body = {"text": text};

    final response = await ApiClient.postDataAi("check-text", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      aiResponseResult.value = AiResponseModel.fromJson(response.body);

      // Debug print
      debugPrint("Parsed AI Response: ${aiResponseResult.value.toJson()}");
      if (Get.isOverlaysOpen) Get.back();

      Get.to(() => AiResultScreen());
    } else {
      if (Get.isOverlaysOpen) Get.back();
      debugPrint("Something we want wrong ===========> ${response.body}");
    }
    isLoading(false);
  }

  Future<void> submitUrl({required String url}) async {
    isLoading(true);
    Get.to(() => ProcessingScreen());

    final body = {"url": url};

    final response = await ApiClient.postDataAi("check-url", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      aiResponseResult.value = AiResponseModel.fromJson(response.body);

      // Debug print
      debugPrint("Parsed AI Response: ${aiResponseResult.value.toJson()}");
      if (Get.isOverlaysOpen) Get.back();

      Get.to(() => AiResultScreen());
    } else {
      if (Get.isOverlaysOpen) Get.back();
      debugPrint("Something we want wrong ===========> ${response.body}");
    }
    isLoading(false);
  }

  Future<void> uploadImage() async {
    if (pickImage.value == null) {
      Get.snackbar("Error", "Please select an image first");
      return;
    }

    isLoading(true);
    Get.to(() => ProcessingScreen());

    final file = pickImage.value!;
    final mimeType = lookupMimeType(file.path);

    // Check valid file type
    if (mimeType == null ||
        !(mimeType == 'image/jpeg' ||
            mimeType == 'image/png' ||
            mimeType == 'image/gif' ||
            mimeType == 'image/webp' ||
            mimeType == 'image/jpg')) {
      Get.snackbar("Error", "Invalid file type. Allowed: jpeg, png, gif, webp");
      isLoading(false);
      return;
    }

    List<MultipartBody> multipartBody = [MultipartBody('file', file)];

    final response = await ApiClient.postMultipartDataAi(
      "check-image",
      {},
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      aiResponseResult.value = AiResponseModel.fromJson(response.body);

      debugPrint("Parsed AI Response: ${aiResponseResult.value.toJson()}");
      if (Get.isOverlaysOpen) Get.back();

      Get.to(() => AiResultScreen());
    } else {
      if (Get.isOverlaysOpen) Get.back();
      debugPrint("Something went wrong ===========> ${response.body}");
    }

    isLoading(false);
  }

  Future<void> uploadPdf({required String pdf}) async {
    isLoading(true);
    Get.to(() => ProcessingScreen());

    try {
      List<MultipartBody> multipartBody = [];

      if (pdf.isNotEmpty) {
        multipartBody.add(MultipartBody('file', File(pdf)));
      }

      final response = await ApiClient.postMultipartDataAiPDF(
        "check-pdf",
        {},
        multipartBody: multipartBody,
      );

      debugPrint("🔍 FINAL RESPONSE :: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        aiResponseResult.value = AiResponseModel.fromJson(response.body ?? {});

        debugPrint("✔ Parsed AI Response: ${aiResponseResult.value.toJson()}");

        if (Get.isOverlaysOpen) Get.back();

        Get.to(() => AiResultScreen());
      } else {
        if (Get.isOverlaysOpen) Get.back();
        debugPrint("❌ Something went wrong: ${response.body}");
      }
    } catch (e) {
      if (Get.isOverlaysOpen) Get.back();
      debugPrint("❌ UploadPdf Error: $e");
    }

    isLoading(false);
  }

  Future<void> saveData() async {
    isLoading(true);

    final data = aiResponseResult.value;

    final body = {
      "verdict": data.verdict,
      "confidence": data.confidence,
      "claim": data.claim,
      "conclusion": data.conclusion,
      "evidence": {
        "additionalProp1": data.evidence!.supporting,
        "additionalProp2": data.evidence!.counter,
        "additionalProp3": [],
      },
      "sources": data.sources!
          .map((item) => {"title": item.title, "url": item.url})
          .toList(),
      "timestamp": data.timestamp,

      "user_id": data.userId,
    };

    final response = await ApiClient.postDataAi("save-factcheck", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      showCustomSnackBar(response.body['message'], isError: true);
    }

    isLoading(false);
  }
}
