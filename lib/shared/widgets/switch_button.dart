import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchButton extends ConsumerWidget {
  // left = false, right = true
  final String left;
  final String right;
  final String providerName;
  final Color backgroundColor;

  const SwitchButton({
    Key? key,
    required this.left,
    required this.right,
    required this.providerName,
    this.backgroundColor = Palette.container1Background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // read state
    final switchButtonState = ref.watch(switchButtonProvider(providerName));

    return CustomContainer(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => ref
                  .read(switchButtonProvider(providerName).notifier)
                  .state = false,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color:
                      switchButtonState ? backgroundColor : Palette.fitsawGreen,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
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
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => ref
                  .read(switchButtonProvider(providerName).notifier)
                  .state = true,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color:
                      switchButtonState ? Palette.fitsawGreen : backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
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
          ),
        ],
      ),
    );
  }
}
