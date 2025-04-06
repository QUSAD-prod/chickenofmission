import 'package:auto_route/auto_route.dart';
import 'package:chickenofmission/core/components/grand_animated_inkwell.dart';
import 'package:chickenofmission/core/const/about.dart';
import 'package:chickenofmission/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GrandAnimatedInkWell(
                    child: Image.asset(
                      'assets/images/game/close.png',
                      width: 10.w,
                      height: 10.w,
                      fit: BoxFit.fill,
                    ),
                    onTap: () => GetIt.I<AppRouter>().pop(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'INFO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
            Container(
              width: 100.w,
              height: 1.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(127),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Text(
                    aboutText,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
