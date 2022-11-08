enum HiringRequestStatus { pending, accepted, rejected }

extension ParseToString on HiringRequestStatus {
  String toValue() {
    return toString().split('.').last;
  }
}

HiringRequestStatus getHiringRequestStatusFromString(String role) {
  for (HiringRequestStatus element in HiringRequestStatus.values) {
    if (element.toValue() == role) {
      return element;
    }
  }
  return HiringRequestStatus.pending;
}
