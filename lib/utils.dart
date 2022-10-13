String getInitials(String name) {
  List<String> nameList = name.split(" ");

  return (nameList[0][0] + nameList[nameList.length - 1][0]).toUpperCase();
}
