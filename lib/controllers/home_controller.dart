import 'dart:io';

import 'package:fact_flow/utils/images_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxString pdfName = ''.obs;
    Rx<File?> pickImage = Rx<File?>(null);

  Future<void> pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        pdfName.value = result.files.single.name;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick PDF file: $e');
    }
  }

  void clearPdf() {
    pdfName.value = '';
  }

    Future<void> pickImageGellary({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      pickImage.value = pickedFile;
    }

  }

}