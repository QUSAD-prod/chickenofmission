import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:chickenofmission/core/components/grand_animated_inkwell.dart';
import 'package:chickenofmission/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 2.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GrandAnimatedInkWell(
                        child: Image.asset('assets/images/welcome/info.png'),
                        onTap: () => {},
                      ),
                      Spacer(),
                      GrandAnimatedInkWell(
                        child: Image.asset('assets/images/welcome/volume.png'),
                        onTap: () => {},
                      ),
                    ],
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/images/welcome/logo.png',
                    width: 90.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Spacer(),
                  GrandAnimatedInkWell(
                    child: Image.asset('assets/images/welcome/new_game.png'),
                    onTap: () async => await GetIt.I<AppRouter>().push(const GameRoute()),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GrandAnimatedInkWell(
                    child: Image.asset('assets/images/welcome/exit.png'),
                    onTap: () => exit(0),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
