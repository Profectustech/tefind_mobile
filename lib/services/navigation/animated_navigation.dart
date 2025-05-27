import 'package:flutter/material.dart';

class AnimatedNavigation {
  navigateTo({
    required BuildContext context,
    required Widget destinationScreen,
    int animationDuration = 1000,
    bool slideFromLeft = false,
    bool slideFromBottom = false,
  }) {
    return slideFromLeft
        ? Navigator.of(context).push(
      slideFromleftAnimatedTransition(
        time: animationDuration,
        screen: destinationScreen,
      ),
    )
        : slideFromBottom
        ? Navigator.of(context).push(
      slideFromBottomAnimatedTransition(
        time: animationDuration,
        screen: destinationScreen,
      ),
    )
        : Navigator.of(context).push(
      animatedTransition(
        time: animationDuration,
        screen: destinationScreen,
      ),
    );
  }
}

Route animatedTransition({
  required Widget screen,
  required int time,
}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: time),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route slideFromleftAnimatedTransition({
  required Widget screen,
  required int time,
}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: time),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route slideFromBottomAnimatedTransition({
  required Widget screen,
  required int time,
}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: time),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
