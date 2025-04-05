import 'dart:math';
import 'package:chickenofmission/core/components/grand_animated_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../const/colors.dart';
import '../managers/board.dart';

import 'animated_tile.dart';

class TileBoardWidget extends ConsumerWidget {
  const TileBoardWidget({super.key, required this.moveAnimation, required this.scaleAnimation});

  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardManager);

    //Decides the maximum size the Board can be based on the shortest size of the screen.
    final size = max(290.0, min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(), 460.0));

    //Decide the size of the tile based on the size of the board minus the space between each tile.
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: Stack(
        children: [
          ...List.generate(
            board.tiles.length,
            (i) {
              var tile = board.tiles[i];

              return AnimatedTile(
                key: ValueKey(tile.id),
                tile: tile,
                moveAnimation: moveAnimation,
                scaleAnimation: scaleAnimation,
                size: tileSize,
                //In order to optimize performances and prevent unneeded re-rendering the actual tile is passed as child to the AnimatedTile
                //as the tile won't change for the duration of the movement (apart from it's position)
                child: Container(
                  width: tileSize,
                  height: tileSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset('assets/images/game/chiken.png').image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        tileColors[tile.value]!,
                        BlendMode.color,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: tileSize * 0.55),
                      child: Text(
                        '${tile.value}',
                        style: TextStyle(
                          fontSize: tileSize * 0.4,
                          color: backgroundColor.withAlpha(180),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (board.over)
            Positioned.fill(
              child: Container(
                color: backgroundColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          board.won ? 'assets/images/game/you_win.png' : 'assets/images/game/game_over.png',
                          width: board.won ? 50.w : 60.w,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      GrandAnimatedInkWell(
                        child: Image.asset(
                          'assets/images/welcome/new_game.png',
                          width: 60.w,
                          fit: BoxFit.fitWidth,
                        ),
                        onTap: () => ref.read(boardManager.notifier).newGame(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
