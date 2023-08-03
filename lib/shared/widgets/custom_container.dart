import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Alignment alignment;
  final BoxConstraints boxConstraints;
  final Widget child;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.color = Palette.container1Background,
    this.padding = const EdgeInsets.fromLTRB(10, 5, 10, 5),
    this.margin = const EdgeInsets.fromLTRB(0, 0, 0, 10),
    this.alignment = Alignment.topCenter,
    this.boxConstraints = const BoxConstraints(minHeight: 30),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double containerWidth;

    if (width == null) {
      containerWidth = MediaQuery.of(context).size.width * 0.9;
    } else {
      containerWidth = width!;
    }

    return Align(
      alignment: alignment,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: height,
          constraints: boxConstraints,
          width: containerWidth,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Palette.containerBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(alignment: Alignment.centerLeft, child: child),
        ),
      ),
    );
  }
}
