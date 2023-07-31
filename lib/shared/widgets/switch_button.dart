import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchButton extends ConsumerWidget {
  // left = false, right = true
  final String left;
  final String right;
  final dynamic provider;

  const SwitchButton({
    Key? key,
    required this.left,
    required this.right,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read state
    final bool switchButtonState = ref.watch(provider);

    return CustomContainer(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(provider.notifier).state = false,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: switchButtonState
                    ? Palette.container1Background
                    : Palette.fitsawGreen,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.45 - 1,
              child: Center(
                child: Text(
                  left,
                  style: TextStyle(
                    color: switchButtonState
                        ? Palette.primaryText
                        : Palette.darkText,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(provider.notifier).state = true,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: switchButtonState
                    ? Palette.fitsawGreen
                    : Palette.container1Background,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.45 - 1,
              child: Center(
                child: Text(
                  right,
                  style: TextStyle(
                    color: switchButtonState
                        ? Palette.darkText
                        : Palette.primaryText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
