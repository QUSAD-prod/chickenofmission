import 'package:chickenofmission/core/components/grand_animated_inkwell.dart';
import 'package:chickenofmission/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../core/components/empy_board.dart';
import '../../core/components/score_board.dart';
import '../../core/components/tile_board.dart';
import '../../core/const/colors.dart';
import '../../core/managers/board.dart';

class Game extends ConsumerStatefulWidget {
  const Game({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameState();
}

class _GameState extends ConsumerState<Game> with TickerProviderStateMixin, WidgetsBindingObserver {
  bool onPause = false;

  final _settingsBox = GetIt.I<Box<int>>();
  final _audioSource = GetIt.I<AudioSource>();
  final _soLoud = SoLoud.instance;
  late final _soundEnabled = _settingsBox.get('sound', defaultValue: 1) == 1;

  //The contoller used to move the the tiles
  late final AnimationController _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  )..addStatusListener(
      (status) async {
        //When the movement finishes merge the tiles and start the scale animation which gives the pop effect.
        if ((status == AnimationStatus.forward || status == AnimationStatus.reverse) && _soundEnabled) {
          await _soLoud.play(_audioSource);
        }
        if (status == AnimationStatus.completed) {
          ref.read(boardManager.notifier).merge();
          _scaleController.forward(from: 0.0);
        }
      },
    );

  //The curve animation for the move animation controller.
  late final CurvedAnimation _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  );

  //The contoller used to show a popup effect when the tiles get merged
  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..addStatusListener(
      (status) {
        //When the scale animation finishes end the round and if there is a queued movement start the move controller again for the next direction.
        if (status == AnimationStatus.completed) {
          if (ref.read(boardManager.notifier).endRound()) {
            _moveController.forward(from: 0.0);
          }
        }
      },
    );

  //The curve animation for the scale animation controller.
  late final CurvedAnimation _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    //Add an Observer for the Lifecycles of the App
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        //Move the tile with the arrows on the keyboard on Desktop
        if (ref.read(boardManager.notifier).onKey(event)) {
          _moveController.forward(from: 0.0);
        }
      },
      child: SwipeDetector(
        onSwipe: (direction, offset) {
          if (ref.read(boardManager.notifier).move(direction)) {
            _moveController.forward(from: 0.0);
          }
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  width: 100.w,
                  'assets/images/background.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Spacer(),
                        GrandAnimatedInkWell(
                          child: Image.asset(
                            'assets/images/game/close.png',
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.fill,
                          ),
                          onTap: () => GetIt.I<AppRouter>().pop(),
                        ),
                        Spacer(flex: 5),
                        GrandAnimatedInkWell(
                          child: Image.asset(
                            'assets/images/game/pause.png',
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.fill,
                          ),
                          onTap: () => setState(() => onPause = true),
                        ),
                        Spacer(flex: 5),
                        GrandAnimatedInkWell(
                          child: Image.asset(
                            'assets/images/game/restart.png',
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.fill,
                          ),
                          onTap: () => ref.read(boardManager.notifier).newGame(),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/images/welcome/logo.png',
                      width: 60.w,
                      fit: BoxFit.fitWidth,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const ScoreBoard(),
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        const EmptyBoardWidget(),
                        TileBoardWidget(moveAnimation: _moveAnimation, scaleAnimation: _scaleAnimation),
                      ],
                    ),
                    Spacer(flex: 5),
                  ],
                ),
              ),
              onPause
                  ? Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: backgroundColor.withAlpha(240),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 3),
                          Image.asset(
                            'assets/images/game/pause_logo.png',
                            width: 40.w,
                            fit: BoxFit.fitWidth,
                          ),
                          Spacer(flex: 2),
                          GrandAnimatedInkWell(
                            child: Image.asset(
                              'assets/images/game/play.png',
                              width: 15.w,
                              height: 15.w,
                              fit: BoxFit.fill,
                            ),
                            onTap: () => setState(() => onPause = false),
                          ),
                          Spacer(flex: 5),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Save current state when the app becomes inactive
    if (state == AppLifecycleState.inactive) {
      ref.read(boardManager.notifier).save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    //Remove the Observer for the Lifecycles of the App
    WidgetsBinding.instance.removeObserver(this);

    //Dispose the animations.
    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
