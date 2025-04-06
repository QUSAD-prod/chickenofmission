import 'package:auto_route/auto_route.dart';
import 'package:chickenofmission/features/about/about_screen.dart';
import 'package:chickenofmission/features/game/game_screen.dart';
import 'package:chickenofmission/features/welcome/welcome_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen|Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WelcomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: GameRoute.page,
        ),
        AutoRoute(
          page: AboutRoute.page,
        ),
      ];
}
