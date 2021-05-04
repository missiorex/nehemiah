import 'package:flutter/material.dart';

class ChatAnimation extends StatelessWidget {
  ChatAnimation({Key key, this.controller, this.chatOption, this.isSmallScreen})
      :

        // Each animation defined here transforms its value during the subset
        // of the controller's duration defined by the animation's interval.
        // For example the opacity animation transforms its value during
        // the first 10% of the controller's duration.

        opacity = Tween<double>(
          begin: 0.5,
          end: 0.9,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.9,
              curve: Curves.linear,
            ),
          ),
        ),
//        width = Tween<double>(
//          begin: 50.0,
//          end: 150.0,
//        ).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.125,
//              0.250,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
//        height = Tween<double>(begin: 50.0, end: 150.0).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.250,
//              0.375,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
//        padding = EdgeInsetsTween(
//          begin: const EdgeInsets.only(bottom: 16.0),
//          end: const EdgeInsets.only(bottom: 75.0),
//        ).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.250,
//              0.375,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
//        borderRadius = BorderRadiusTween(
//          begin: BorderRadius.circular(4.0),
//          end: BorderRadius.circular(75.0),
//        ).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.375,
//              0.500,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
//        color = ColorTween(
//          begin: Color.fromRGBO(38, 51, 70, 1),
//          end: Color.fromRGBO(203, 14, 19, 1),
//        ).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.100,
//              0.950,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final String chatOption;
  final bool isSmallScreen;
//  final Animation<double> width;
//  final Animation<double> height;
//  final Animation<EdgeInsets> padding;
//  final Animation<BorderRadius> borderRadius;
//  final Animation<Color> color;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      alignment: Alignment.bottomCenter,
      child: Opacity(
          opacity: opacity.value,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor.withBlue(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: 40.0, bottom: 20.0, left: 10.0, right: 20.0),
                padding: EdgeInsets.all(20.0),
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text(
                  chatOption,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white, fontSize: 14.0),
                )),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
