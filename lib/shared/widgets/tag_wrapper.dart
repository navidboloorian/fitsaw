import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/tag.dart';
import 'package:flutter/material.dart';

class TagWrapper extends StatelessWidget {
  final List<String> tags;
  final Function(String)? onTap;
  final bool isDismissible;

  TagWrapper({
    required this.tags,
    super.key,
    this.onTap,
    this.isDismissible = false,
  });

  final List<Color> _colors = [
    Palette.fitsawBlue,
    Palette.fitsawPurple,
    Palette.fitsawRed,
    Palette.fitsawOrange,
    Palette.fitsawGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 3,
        spacing: 3,
        children: [
          for (int i = 0; i < tags.length; i++)
            Tag(
              name: tags[i],
              color: _colors[i % _colors.length],
              isDismissible: isDismissible,
              onTap: onTap,
            )
        ],
      ),
    );
  }
}
