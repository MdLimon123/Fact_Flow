
import 'package:fact_flow/models/ai_history_response_model.dart';
import 'package:fact_flow/services/api_client.dart';
import 'package:fact_flow/views/base/custom_snackbar.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var tabIndex = 0.obs;

  var isLoading = false.obs;


  RxList<AiHistoryItem> trueList = <AiHistoryItem>[].obs;
  RxList<AiHistoryItem> falseList = <AiHistoryItem>[].obs;
  RxList<AiHistoryItem> mixList = <AiHistoryItem>[].obs;

  List<String> tabList = [
    'True', 'False', 'Mix',
    //'Calendar'
  ];

  bool isTabSelected(int index) {
    return tabIndex.value == index;
  }

  Future<void> fetchTrueList() async {
    isLoading(true);


    final response = await ApiClient.getDataAi(
      "get-factchecks?limit=3&verdict=TRUE",
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;

      if (body is List) {
        final parsed = AiHistoryResponseModel.fromJson(body);
        trueList.assignAll(parsed.items);
      } else {
        print("ERROR: API did NOT return a list.");
      }
    } else {
      print("Something we want wrong ====> ${response.body}");
    }
    isLoading(false);
  }

  Future<void> fetchFalseList() async {
    isLoading(true);
 

    final response = await ApiClient.getDataAi(
      "get-factchecks?limit=3&verdict=FALSE",
   
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;

      if (body is List) {
        final parsed = AiHistoryResponseModel.fromJson(body);
        falseList.assignAll(parsed.items);
      } else {
        print("ERROR: API did NOT return a list.");
      }
    } else {
      print("Something we want wrong ====> ${response.body}");
    }
    isLoading(false);
  }

  Future<void> fetchMixList() async {
    isLoading(true);



    final response = await ApiClient.getDataAi(
      "get-factchecks",

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;

      if (body is List) {
        final parsed = AiHistoryResponseModel.fromJson(body);
        mixList.assignAll(parsed.items);
      } else {
        print("ERROR: API did NOT return a list.");
      }
    } else {
      print("Something wrong ====> ${response.body}");
    }

    isLoading(false);
  }

  Future<void> deleteItem({required String uuid}) async {


    final response = await ApiClient.deleteData(
      "delete-factcheck?uid=$uuid",
    
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      trueList.removeWhere((item) => item.uid == uuid);
      falseList.removeWhere((item) => item.uid == uuid);
      mixList.removeWhere((item) => item.uid == uuid);

      showCustomSnackBar("Delete Success", isError: false);
    } else {
      showCustomSnackBar("Something went wrong", isError: true);
    }
  }
}
