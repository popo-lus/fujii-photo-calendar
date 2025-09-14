// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AnnivPromoTestPage]
class AnnivPromoTestRoute extends PageRouteInfo<void> {
  const AnnivPromoTestRoute({List<PageRouteInfo>? children})
    : super(AnnivPromoTestRoute.name, initialChildren: children);

  static const String name = 'AnnivPromoTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnnivPromoTestPage();
    },
  );
}

/// generated route for
/// [InviteCodePage]
class InviteCodeRoute extends PageRouteInfo<InviteCodeRouteArgs> {
  InviteCodeRoute({
    Key? key,
    String? initialCode,
    String? initialError,
    bool autoSubmit = true,
    List<PageRouteInfo>? children,
  }) : super(
         InviteCodeRoute.name,
         args: InviteCodeRouteArgs(
           key: key,
           initialCode: initialCode,
           initialError: initialError,
           autoSubmit: autoSubmit,
         ),
         initialChildren: children,
       );

  static const String name = 'InviteCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InviteCodeRouteArgs>(
        orElse: () => const InviteCodeRouteArgs(),
      );
      return InviteCodePage(
        key: args.key,
        initialCode: args.initialCode,
        initialError: args.initialError,
        autoSubmit: args.autoSubmit,
      );
    },
  );
}

class InviteCodeRouteArgs {
  const InviteCodeRouteArgs({
    this.key,
    this.initialCode,
    this.initialError,
    this.autoSubmit = true,
  });

  final Key? key;

  final String? initialCode;

  final String? initialError;

  final bool autoSubmit;

  @override
  String toString() {
    return 'InviteCodeRouteArgs{key: $key, initialCode: $initialCode, initialError: $initialError, autoSubmit: $autoSubmit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InviteCodeRouteArgs) return false;
    return key == other.key &&
        initialCode == other.initialCode &&
        initialError == other.initialError &&
        autoSubmit == other.autoSubmit;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialCode.hashCode ^
      initialError.hashCode ^
      autoSubmit.hashCode;
}

/// generated route for
/// [InviteCreatePage]
class InviteCreateRoute extends PageRouteInfo<void> {
  const InviteCreateRoute({List<PageRouteInfo>? children})
    : super(InviteCreateRoute.name, initialChildren: children);

  static const String name = 'InviteCreateRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InviteCreatePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MonthCalendarPage]
class MonthCalendarRoute extends PageRouteInfo<void> {
  const MonthCalendarRoute({List<PageRouteInfo>? children})
    : super(MonthCalendarRoute.name, initialChildren: children);

  static const String name = 'MonthCalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MonthCalendarPage();
    },
  );
}

/// generated route for
/// [MonthPhotoListPage]
class MonthPhotoListRoute extends PageRouteInfo<void> {
  const MonthPhotoListRoute({List<PageRouteInfo>? children})
    : super(MonthPhotoListRoute.name, initialChildren: children);

  static const String name = 'MonthPhotoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MonthPhotoListPage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [RequestsListPage]
class RequestsListRoute extends PageRouteInfo<RequestsListRouteArgs> {
  RequestsListRoute({
    Key? key,
    required String ownerUid,
    List<PageRouteInfo>? children,
  }) : super(
         RequestsListRoute.name,
         args: RequestsListRouteArgs(key: key, ownerUid: ownerUid),
         initialChildren: children,
       );

  static const String name = 'RequestsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestsListRouteArgs>();
      return RequestsListPage(key: args.key, ownerUid: args.ownerUid);
    },
  );
}

class RequestsListRouteArgs {
  const RequestsListRouteArgs({this.key, required this.ownerUid});

  final Key? key;

  final String ownerUid;

  @override
  String toString() {
    return 'RequestsListRouteArgs{key: $key, ownerUid: $ownerUid}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RequestsListRouteArgs) return false;
    return key == other.key && ownerUid == other.ownerUid;
  }

  @override
  int get hashCode => key.hashCode ^ ownerUid.hashCode;
}
