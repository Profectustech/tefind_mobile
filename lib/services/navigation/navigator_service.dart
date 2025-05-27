import 'package:flutter/material.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigationKey_ =
      GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => navigationKey_;

  navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  pop(value) {
    return navigationKey_.currentState!.pop(value);
  }

  goBack() {
    return navigationKey_.currentState!.pop();
  }

  popUntil(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .popUntil(ModalRoute.withName(routeName));
  }

  pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return navigationKey_.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(String newRoute) {
    return navigationKey_.currentState!
        .pushNamedAndRemoveUntil(newRoute, (Route<dynamic> route) => false);
  }
}
