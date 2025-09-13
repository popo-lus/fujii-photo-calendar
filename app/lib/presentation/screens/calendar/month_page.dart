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
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
          // 閲覧モードインジケータ（匿名ユーザー時は編集不可）
          asyncData.maybeWhen(
            data: (MonthState data) {
              if (data.isReadOnly) {
                return const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.lock_outline),
                  tooltip: '閲覧モード (編集不可)',
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
          // 被撮影者のみ: 写真追加ボタン
          asyncData.maybeWhen(
            data: (MonthState data) {
              if (!data.isReadOnly) {
                return IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  tooltip: '写真を追加',
                  onPressed: () async {
                    // ギャラリーから画像選択
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked == null) return; // キャンセル
                    try {
                      final file = File(picked.path);
                      await notifier.onAddPhotoFile(file);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('写真をアップロードしました')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('アップロードに失敗しました: $e')),
                        );
                      }
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          ),
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
          // 開発用: 記念日×生成AI テストページ
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Anniv Promo Test',
            onPressed: () => context.router.push(const AnnivPromoTestRoute()),
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
          return MonthGrid(photos: data.photos, readOnly: data.isReadOnly);
        },
      ),
      bottomNavigationBar: MonthNavBar(
        onPrev: () => notifier.prevMonth(),
        onNext: () => notifier.nextMonth(),
      ),
    );
  }
}
