// (T019) Router 設定: 単一画面 (MonthCalendarRoute) のみ初期実装
// 将来: 設定画面や詳細画面を追加予定

import 'package:auto_route/auto_route.dart';
import 'package:fujii_photo_calendar/presentation/screens/calendar/month_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MonthCalendarRoute.page, initial: true),
  ];

  @override
  List<AutoRouteGuard> get guards => const [];
}
