import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../const/colors.dart';
import '../managers/board.dart';

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(boardManager.select((board) => board.score));
    final best = ref.watch(boardManager.select((board) => board.best));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Score(label: 'Score', score: '$score'),
        Score(label: 'Best', score: '$best'),
      ],
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    super.key,
    required this.label,
    required this.score,
  });

  final String label;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.25.h),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Image.asset(
              'assets/images/game/egg.png',
              height: 18,
              fit: BoxFit.fitHeight,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 1.w),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 2.w),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                textColor,
                textColorWhite,
              ],
              stops: [0.0, 0.6],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              score,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
