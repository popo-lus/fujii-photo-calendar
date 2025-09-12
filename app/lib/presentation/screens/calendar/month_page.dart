// (T020) 月ページスクリーン: ViewModel を監視し状態に応じてウィジェット切替

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/calendar/month_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'widgets/month_grid.dart';
import 'widgets/photo_slideshow.dart';
import 'widgets/empty_month_placeholder.dart';
import 'widgets/error_view.dart';
import 'widgets/month_nav_bar.dart';

@RoutePage()
class MonthCalendarPage extends ConsumerWidget {
  const MonthCalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(monthViewModelProvider);
    final notifier = ref.read(monthViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: asyncData.isLoading ? null : () => notifier.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(monthViewModelProvider.notifier).logout();
              if (context.mounted) {
                context.router.replaceAll([const LoginRoute()]);
              }
            },
          ),
          asyncData.maybeWhen(
            data: (MonthState data) {
              if (data.inSlideshow) {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => notifier.endSlideshow(),
                );
              }
              if (data.photos.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.slideshow),
                  onPressed: () => notifier.startSlideshow(),
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object e, StackTrace st) =>
            ErrorView(message: e.toString(), onRetry: () => notifier.reload()),
        data: (MonthState data) {
          if (data.inSlideshow) {
            return PhotoSlideshow(
              all: data.photos,
              batch: data.slideshowBatch ?? data.photos,
            );
          }
          if (data.isEmpty) return const EmptyMonthPlaceholder();
          return MonthGrid(photos: data.photos);
        },
      ),
      bottomNavigationBar: MonthNavBar(
        onPrev: () => notifier.prevMonth(),
        onNext: () => notifier.nextMonth(),
      ),
    );
  }
}
