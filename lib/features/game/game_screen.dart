import 'package:auto_route/auto_route.dart';
import 'package:chickenofmission/features/game/game.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Game();
  }
}
