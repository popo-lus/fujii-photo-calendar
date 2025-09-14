// (T019) Router 設定: 単一画面 (MonthCalendarRoute) のみ初期実装
// 将来: 設定画面や詳細画面を追加予定

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fujii_photo_calendar/presentation/screens/calendar/month_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/login_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/register_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/invite_code_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/auth/invite_create_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/dev/anniv_promo_test_page.dart';
import 'package:fujii_photo_calendar/presentation/screens/requests/requests_list_page.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey}) : _authGuard = AuthGuard();
  final AuthGuard _authGuard;
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: InviteCodeRoute.page),
    AutoRoute(page: InviteCreateRoute.page),
    AutoRoute(page: AnnivPromoTestRoute.page),
    AutoRoute(page: RequestsListRoute.page),
    AutoRoute(
      page: MonthCalendarRoute.page,
      guards: [_authGuard],
      initial: true,
    ),
  ];
}
