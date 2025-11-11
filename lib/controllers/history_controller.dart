import 'package:get/get.dart';

class HistoryController extends GetxController {

 var tabIndex = 0.obs;

  List<String> tabList = ['True', 'False', 'Mix', 'Calendar'];

  bool isTabSelected(int index) {
    return tabIndex.value == index;
  }
}
