

import 'package:intl/intl.dart';

String formatDate(String timestamp) {
  try {
    final dateTime = DateTime.parse(timestamp);
    return DateFormat("MMM dd, yyyy").format(dateTime);  
  } catch (e) {
    return timestamp; // fallback
  }
}