// ignore_for_file: constant_identifier_names

enum AppRoutes {
  splash,
  settings,
  profile,
  login,
  register,
  home;

  String get path {
    switch (this) {
      case AppRoutes.splash:
        return "/splash";
      case AppRoutes.settings:
        return "/settings";
      case AppRoutes.profile:
        return "/profile";
      case AppRoutes.login:
        return "/login";
      case AppRoutes.register:
        return "/register";
      case AppRoutes.home:
        return "/home";
      default:
        return "/login";
    }
  }
}
