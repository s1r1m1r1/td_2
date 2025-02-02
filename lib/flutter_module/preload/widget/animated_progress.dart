import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedProgress extends StatelessWidget {
  const AnimatedProgress({
    super.key,
    required this.progress,
  });

//min 0, max 1
  final double progress;

  /// The duration of the animation on [AnimatedProgressBar]
  static const Duration intrinsicAnimationDuration =
      Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final anim = lerpDouble(0, 10, progress)!;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            10,
            (i) => Container(
              margin: const EdgeInsets.only(right: 8),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: anim >= i ? Colors.green : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
