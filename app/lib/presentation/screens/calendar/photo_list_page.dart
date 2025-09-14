import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/calendar/month_view_model.dart';
import 'widgets/photo_masonry_grid.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fujii_photo_calendar/presentation/widgets/glass_circle_button.dart';

@RoutePage()
class MonthPhotoListPage extends ConsumerWidget {
  const MonthPhotoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(monthViewModelProvider);
    final notifier = ref.read(monthViewModelProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          asyncData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (Object e, StackTrace st) =>
                Center(child: Text('Error: $e')),
            data: (MonthState data) => PhotoMasonryGrid(
              urls: data.photos.map((p) => p.url).toList(),
              onTap: (index) async {
                if (data.isReadOnly) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('閲覧モードでは追加できません')),
                    );
                  }
                  return;
                }
                final picker = ImagePicker();
                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (picked == null) return;
                try {
                  final file = File(picked.path);
                  await notifier.onAddPhotoFile(file);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(child: Text('写真をアップロードしました')),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        showCloseIcon: true,
                        closeIconColor: Colors.white,
                        duration: const Duration(seconds: 2),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    final onErr = Theme.of(
                      context,
                    ).colorScheme.onErrorContainer;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: onErr),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'アップロードに失敗しました: $e',
                                style: TextStyle(color: onErr),
                              ),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.errorContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        showCloseIcon: true,
                        closeIconColor: onErr,
                        duration: const Duration(seconds: 3),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: GlassCirclePopupMenuButton<_PhotoListMenuAction>(
                  tooltip: 'メニュー',
                  itemBuilder: (BuildContext context) {
                    return asyncData.when(
                      loading: () => <PopupMenuEntry<_PhotoListMenuAction>>[
                        PopupMenuItem<_PhotoListMenuAction>(
                          enabled: false,
                          value: _PhotoListMenuAction.loading,
                          child: Row(
                            children: [
                              Icon(
                                Icons.hourglass_empty,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('読み込み中'),
                            ],
                          ),
                        ),
                      ],
                      error: (Object e, StackTrace st) =>
                          <PopupMenuEntry<_PhotoListMenuAction>>[
                            PopupMenuItem<_PhotoListMenuAction>(
                              enabled: false,
                              value: _PhotoListMenuAction.error,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('エラーが発生しました'),
                                ],
                              ),
                            ),
                          ],
                      data: (MonthState data) {
                        final List<PopupMenuEntry<_PhotoListMenuAction>> items =
                            [];
                        if (!data.isReadOnly) {
                          items.add(
                            PopupMenuItem<_PhotoListMenuAction>(
                              value: _PhotoListMenuAction.addPhoto,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('写真を追加'),
                                ],
                              ),
                            ),
                          );
                        }
                        return items;
                      },
                    );
                  },
                  onSelected: (action) async {
                    switch (action) {
                      case _PhotoListMenuAction.addPhoto:
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (picked == null) return;
                        try {
                          final file = File(picked.path);
                          await notifier.onAddPhotoFile(file);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text('写真をアップロードしました'),
                                    ),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                showCloseIcon: true,
                                closeIconColor: Colors.white,
                                duration: const Duration(seconds: 2),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            final onErr = Theme.of(
                              context,
                            ).colorScheme.onErrorContainer;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: onErr),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'アップロードに失敗しました: $e',
                                        style: TextStyle(color: onErr),
                                      ),
                                    ),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                showCloseIcon: true,
                                closeIconColor: onErr,
                                duration: const Duration(seconds: 3),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          }
                        }
                        break;
                      case _PhotoListMenuAction.loading:
                      case _PhotoListMenuAction.error:
                        break;
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _PhotoListMenuAction { addPhoto, loading, error }
