import 'package:get/get.dart';

class AiChatResultController extends GetxController{
   List<bool> isExpanded = [false, false, false, false,false].obs;

 void toggleExpansion(int index) {
  isExpanded[index] = !isExpanded[index];
 }
}