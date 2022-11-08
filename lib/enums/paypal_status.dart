enum PayPalStatus { completed, failed }

extension ParseToString on PayPalStatus {
  String toValue() {
    return toString().split('.').last;
  }
}

PayPalStatus? getPayPalStatusFromString(String? status) {
  for (PayPalStatus element in PayPalStatus.values) {
    if (element.toValue() == status) {
      return element;
    }
  }

  return null;
}
