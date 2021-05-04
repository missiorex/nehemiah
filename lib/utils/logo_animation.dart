import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class LogoAnimation extends StatelessWidget {
  bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    return PlayAnimation<double>(
      tween: isLargeScreen
          ? (100.0).tweenTo(280.0)
          : (30.0).tweenTo(100.0), // <-- specify tween (from 50.0 to 200.0)
      duration: 5.seconds, // <-- set a duration
      builder: (context, child, value) {
        // <-- use builder function
//        return Container(
//          width: value, // <-- apply animated value obtained from builder function parameter
//          height: value, // <-- apply animated value obtained from builder function parameter
//          color: Colors.green,
//        );

        return isLargeScreen
            ? Container(
                width:
                    value, // <-- apply animated value obtained from builder function parameter
                height: value, // <-
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/logo_title.png"),
                  fit: BoxFit.contain,
                )))
            : Container(
                width:
                    value, // <-- apply animated value obtained from builder function parameter
                height: value,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/jmsh.png"),
                  fit: BoxFit.contain,
                )));
      },
    );
  }
}
