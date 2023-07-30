import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;

  const CustomContainer({
    super.key,
    this.color = Palette.container1Background,
    this.padding = Constants.containerPadding,
    this.margin = Constants.containerMargin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Palette.canvas,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Palette.containerBorder,
              width: 1,
            ),
            borderRadius: Constants.containerBorderRadius,
          ),
          child: Align(alignment: Alignment.centerLeft, child: child),
        ),
      ),
    );
  }
}
