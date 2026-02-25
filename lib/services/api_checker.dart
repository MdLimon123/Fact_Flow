
import 'package:fact_flow/helpers/prefs_helper.dart';
import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_constants.dart';
import 'package:fact_flow/views/base/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false})async{

    if(response.statusCode != 200){
      if(response.statusCode == 401) {
        await PrefsHelper.remove(AppConstants.bearerToken);
        Get.offAllNamed(AppRoutes.splashScreen);
      }else {
        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);

      }

    }


  }
}