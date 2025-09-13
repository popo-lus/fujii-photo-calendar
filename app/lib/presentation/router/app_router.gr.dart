// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

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
