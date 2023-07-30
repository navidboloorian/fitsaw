import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentScreen = ref.watch(navScreenProvider);

    const Map<String, Map> icons = <String, Map>{
      'exercises': {
        'icon': FitsawIcons.exercises,
        'color': Palette.fitsawBlue,
      },
      'routines': {
        'icon': FitsawIcons.routines,
        'color': Palette.fitsawRed,
      },
      'market': {
        'icon': FitsawIcons.market,
        'color': Palette.fitsawGreen,
      },
    };

    List<GestureDetector> barItems = <GestureDetector>[];

    // Creates list of navigation bar buttons.
    for (int i = 0; i < icons.length; i++) {
      String screen = icons.keys.elementAt(i);
      Color iconColor = icons[screen]!['color'];
      Color iconBackgroundColor = Palette.canvas;

      if (currentScreen == screen) {
        iconColor = Palette.canvas;
        iconBackgroundColor = icons[screen]!['color'];
      }

      barItems.add(
        // Attatch a separate gesture detector for each tab button.
        GestureDetector(
          onTap: () {
            ref.read(navScreenProvider.notifier).state = screen;
            Navigator.pushReplacementNamed(context, screen);
          },
          child: Container(
            width: 60,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(3)),
            ),
            child: Icon(
              icons[screen]!['icon'],
              color: iconColor,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 70,
      // Used Row instead of BottomNavBar because it was really annoying to
      // adjust the height of the BottomNavBar.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: barItems,
      ),
    );
  }
}
