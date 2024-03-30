import 'package:auto_route/auto_route.dart';
import 'package:{{project_name}}/app/routes/app_router.gr.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(
        page: MainRoute.page,
        children: [
          AutoRoute(page: CounterRoute.page),
          AutoRoute(page: SettingsRoute.page),
        ],
      ),
    ];
  }
}
