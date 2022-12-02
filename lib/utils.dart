// Project imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'constants.dart' as constants;

String getInitials(String name) {
  List<String> nameList = name.split(" ");

  // This usually happens when censorizing a name in view profile details
  if (nameList.length < 2) {
    return name[0].toUpperCase() + name[name.length - 1].toUpperCase();
  }

  return (nameList[0][0] + nameList[nameList.length - 1][0]).toUpperCase();
}

String censorizeName(String name) {
  return name.replaceRange(1, name.length - 1, "*" * (name.length - 2));
}

String getStoreNamePath(String storeName) {
  return "${constants.logoPath}/${storeName.replaceAll(" ", '_').toLowerCase()}.png";
}

String formatDate(Timestamp date) {
  return DateFormat("MMMM dd, yyyy").format(date.toDate());
}
