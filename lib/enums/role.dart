enum Role {
  client,
  inquirer
}

extension ParseToString on Role {
  String toValue() {
    return toString().split('.').last;
  }
}

Role getRoleFromString(String role) {
  for (Role element in Role.values) {
    if (element.toString() == role) {
      return element;
    }
  }

  return Role.client;
}
