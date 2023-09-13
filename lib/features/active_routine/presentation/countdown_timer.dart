import 'package:fitsaw/features/active_routine/services/services.dart';
import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class CountdownTimer extends ConsumerStatefulWidget {
  final int duration;
  final int? set;
  final int? exerciseIndex;
  final Function? setControllers;

  const CountdownTimer({
    super.key,
    required this.duration,
    this.set,
    this.exerciseIndex,
    this.setControllers,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer>
    with TickerProviderStateMixin {
  late bool _isStopped;
  late AnimationController _controller;

  String get timerString {
    Duration duration = _controller.duration! * _controller.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _goToNextExercise() {
    if (_controller.value == 0) {
      int currentSet = ref.watch(currentSetProvider);
      int currentExerciseIndex = ref.watch(currentExerciseIndexProvider);
      bool isResting = ref.watch(isRestProvider);
      RoutineExerciseWrapper? currentExerciseWrapper =
          ref.watch(currentExerciseProvider);

      bool isLastExercise = currentExerciseIndex ==
              ref.watch(activeRoutineProvider)!.exercises.length - 1 &&
          currentSet ==
              ref
                      .watch(activeRoutineProvider)!
                      .exercises[currentExerciseIndex]
                      .sets! -
                  1;

      if (isResting) {
        ref.read(isRestProvider.notifier).state = false;

        if (currentSet < currentExerciseWrapper!.sets! - 1) {
          ref.read(currentSetProvider.notifier).state++;
        } else if (currentExerciseIndex <
            ref.watch(activeRoutineProvider)!.exercises.length - 1) {
          ref.read(currentSetProvider.notifier).state = 0;
          ref.read(currentExerciseIndexProvider.notifier).state++;
        } else {
          ref.read(isRoutineCompletedProvider.notifier).state = true;
        }
      } else {
        if (currentExerciseWrapper!.rest! > 0 && !isLastExercise) {
          ref.read(isRestProvider.notifier).state = true;
        } else {
          if (currentSet < currentExerciseWrapper.sets! - 1) {
            ref.read(currentSetProvider.notifier).state++;
          } else if (currentExerciseIndex <
              ref.watch(activeRoutineProvider)!.exercises.length - 1) {
            ref.read(currentSetProvider.notifier).state = 0;
            ref.read(currentExerciseIndexProvider.notifier).state++;
          } else {
            ref.read(isRoutineCompletedProvider.notifier).state = true;
          }
        }
      }

      if (widget.setControllers != null) {
        widget.setControllers!();
      }
    }
  }

  void _startStop() {
    if (_controller.isAnimating) {
      _controller.stop(canceled: false);
      setState(() => _isStopped = true);
    } else {
      _controller.reverse();
      setState(() => _isStopped = false);
    }
  }

  void _reset() {
    _controller.value = widget.duration.toDouble();
    _controller.duration = Duration(seconds: widget.duration);

    if (!_isStopped) {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    super.initState();

    _isStopped = false;

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duration));
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _controller.addListener(_goToNextExercise);
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (ref.watch(isRestProvider)) {
      if (oldWidget != widget) {
        _isStopped = false;

        _controller.duration = Duration(seconds: widget.duration);
        _controller.reverse();

        _reset();
      }
    } else {
      if (oldWidget.exerciseIndex != widget.exerciseIndex ||
          oldWidget.set != widget.set) {
        _isStopped = false;

        _controller.duration = Duration(seconds: widget.duration);
        _controller.reverse();

        _reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SizedBox(
        height: 250,
        child: Stack(
          children: [
            Column(
              children: [
                Center(
                  child: CustomPaint(
                    size: const Size.square(200),
                    painter: CustomTimerPainter(
                      animation: _controller,
                      backgroundColor: Colors.white,
                      color: Colors.red,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerButton(
                      color: Palette.fitsawGreen,
                      onTap: _startStop,
                      icon: _isStopped ? Icons.play_arrow : Icons.stop,
                    ),
                    const SizedBox(width: 10),
                    TimerButton(
                      color: Palette.fitsawGreen,
                      onTap: _reset,
                      icon: Icons.refresh,
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    timerString,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..shader = const SweepGradient(
        colors: [
          Palette.fitsawGreen,
          Palette.fitsawOrange,
          Palette.fitsawRed,
          Palette.fitsawPurple,
          Palette.fitsawBlue,
        ],
        transform: GradientRotation(3 / 2 * math.pi),
      ).createShader(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width,
        ),
      );

    canvas.drawArc(
      Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width * 2 / 5),
      -math.pi / 2,
      animation.value * 2 * math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value;
  }
}

class TimerButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  const TimerButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Icon(icon, color: Palette.darkText)),
      ),
    );
  }
}
