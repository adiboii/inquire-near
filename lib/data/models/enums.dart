enum Role {
  client,
  inquirer,
}

enum Store {
  casaVerde,
  blackbeardSeafoodIsland,
  yakima,
  smBowlingCenter,
  iceSkatingRink,
  colorMuseum,
  centerStage,
  directorsClub,
  smCinema,
  dataBlitz,
  octagon,
  iStore,
  bancoDeOro,
  brunosBarbers,
  pldt,
  smApplianceCenter,
  watsons,
  hnm,
}

enum ReportType {
  monetary,
  rating,
}

enum HiringRequestStatus {
  pending,
  accepted,
  rejected
}

extension ParseToString on HiringRequestStatus {
  String toValue() {
    return toString().split('.').last;
  }
}