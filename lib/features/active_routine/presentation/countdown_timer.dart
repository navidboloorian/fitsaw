import 'package:fitsaw/shared/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class CountdownTimer extends ConsumerStatefulWidget {
  final int duration;

  const CountdownTimer({super.key, required this.duration});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  String get timerString {
    Duration duration = _controller.duration! * _controller.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duration));

    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
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
      builder: (context, child) => Stack(
        children: [
          Center(
            child: CustomPaint(
              size: const Size.square(100),
              painter: CustomTimerPainter(
                animation: _controller,
                backgroundColor: Colors.white,
                color: Colors.red,
              ),
            ),
          ),
          Center(
            child: Text(
              timerString,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ],
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
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width),
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
