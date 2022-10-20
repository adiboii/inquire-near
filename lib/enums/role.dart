enum Role {
  Client,
  Inquirer,
}

Role getRoleFromString(String role) {
  for (Role element in Role.values) {
    if (element.toString() == role) {
      return element;
    }
  }

  return Role.Client;
}
