enum Endpoints {
  userInternetInfo;

  String get path {
    switch (this) {
      case Endpoints.userInternetInfo:
        return "https://ipapi.co/json/";
    }
  }
}
