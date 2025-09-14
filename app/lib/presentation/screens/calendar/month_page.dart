// (T020) 月ページスクリーン: ViewModel を監視し状態に応じてウィジェット切替

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/viewmodels/calendar/month_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'widgets/photo_slideshow.dart';
import 'widgets/error_view.dart';
// import 'widgets/month_nav_bar.dart';
import 'widgets/photo_calendar_card.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fujii_photo_calendar/presentation/widgets/glass_circle_button.dart';
import 'package:fujii_photo_calendar/presentation/screens/requests/widgets/request_dialog.dart';

enum MonthMenuAction {
  readOnlyInfo,
  addPhoto,
  reload,
  logout,
  annivPromo,
  startSlideshow,
  endSlideshow,
  inviteCreate,
  photoRequests,
}

@RoutePage()
class MonthCalendarPage extends ConsumerStatefulWidget {
  const MonthCalendarPage({super.key});

  @override
  ConsumerState<MonthCalendarPage> createState() => _MonthCalendarPageState();
}

class _MonthCalendarPageState extends ConsumerState<MonthCalendarPage> {
  Future<void> _onMenuSelected(MonthMenuAction action) async {
    final notifier = ref.read(monthViewModelProvider.notifier);
    switch (action) {
      case MonthMenuAction.readOnlyInfo:
        break;
      case MonthMenuAction.addPhoto:
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked == null) return;
        try {
          final file = File(picked.path);
          await notifier.onAddPhotoFile(file);
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('写真をアップロードしました')));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('アップロードに失敗しました: $e')));
          }
        }
        break;
      case MonthMenuAction.reload:
        notifier.reload();
        break;
      case MonthMenuAction.logout:
        await ref.read(monthViewModelProvider.notifier).logout();
        if (context.mounted) {
          context.router.replaceAll([const LoginRoute()]);
        }
        break;
      case MonthMenuAction.annivPromo:
        if (context.mounted) {
          context.router.push(const AnnivPromoTestRoute());
        }
        break;
      case MonthMenuAction.startSlideshow:
        notifier.startSlideshow();
        break;
      case MonthMenuAction.endSlideshow:
        notifier.endSlideshow();
        break;
      case MonthMenuAction.inviteCreate:
        if (context.mounted) {
          context.router.push(const InviteCreateRoute());
        }
        break;
      case MonthMenuAction.photoRequests:
        try {
          final data = ref.read(monthViewModelProvider).value;
          if (data == null) return;
          final ownerUid = data.uid; // 匿名閲覧時も ownerUid が入る
          if (data.isReadOnly) {
            // ビューアは送信ダイアログのみ
            if (!context.mounted) return;
            // 遅延インポートせず直接ダイアログを使用
            // ignore: use_build_context_synchronously
            await showDialog<bool>(
              context: context,
              builder: (_) => RequestDialog(ownerUid: ownerUid),
            );
          } else {
            if (context.mounted) {
              context.router.push(RequestsListRoute(ownerUid: ownerUid));
            }
          }
        } catch (_) {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(monthViewModelProvider);
    final notifier = ref.read(monthViewModelProvider.notifier);

    Widget buildTopRightButtons() {
      return SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: GlassCirclePopupMenuButton<MonthMenuAction>(
              tooltip: 'メニュー',
              itemBuilder: (BuildContext context) {
                return asyncData.when(
                  loading: () => <PopupMenuEntry<MonthMenuAction>>[
                    PopupMenuItem<MonthMenuAction>(
                      enabled: false,
                      value: MonthMenuAction.readOnlyInfo,
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
                      <PopupMenuEntry<MonthMenuAction>>[
                        PopupMenuItem<MonthMenuAction>(
                          enabled: false,
                          value: MonthMenuAction.readOnlyInfo,
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('エラーが発生しました'),
                            ],
                          ),
                        ),
                        PopupMenuItem<MonthMenuAction>(
                          value: MonthMenuAction.reload,
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('更新'),
                            ],
                          ),
                        ),
                      ],
                  data: (MonthState data) {
                    final List<PopupMenuEntry<MonthMenuAction>> items = [];
                    if (data.isReadOnly) {
                      items.add(
                        PopupMenuItem<MonthMenuAction>(
                          enabled: false,
                          value: MonthMenuAction.readOnlyInfo,
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('閲覧モード (編集不可)'),
                            ],
                          ),
                        ),
                      );
                    }
                    // 写真追加を一番上に
                    if (!data.isReadOnly) {
                      items.add(
                        PopupMenuItem<MonthMenuAction>(
                          value: MonthMenuAction.addPhoto,
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('写真を追加'),
                            ],
                          ),
                        ),
                      );
                      items.add(
                        PopupMenuItem<MonthMenuAction>(
                          value: MonthMenuAction.inviteCreate,
                          child: Row(
                            children: [
                              Icon(
                                Icons.qr_code_2,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('共有コードを作成'),
                            ],
                          ),
                        ),
                      );
                    }
                    // 更新
                    items.add(
                      PopupMenuItem<MonthMenuAction>(
                        value: MonthMenuAction.reload,
                        child: Row(
                          children: [
                            Icon(
                              Icons.refresh,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text('更新'),
                          ],
                        ),
                      ),
                    );
                    // Anniv Promo はそのまま
                    items.add(
                      PopupMenuItem<MonthMenuAction>(
                        value: MonthMenuAction.annivPromo,
                        child: Row(
                          children: [
                            Icon(
                              Icons.bug_report_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text('Anniv Promo Test'),
                          ],
                        ),
                      ),
                    );
                    // スライドショー関連
                    if (data.inSlideshow) {
                      items.add(
                        PopupMenuItem<MonthMenuAction>(
                          value: MonthMenuAction.endSlideshow,
                          child: Row(
                            children: [
                              Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('スライドショーを終了'),
                            ],
                          ),
                        ),
                      );
                    } else if (data.photos.isNotEmpty) {
                      items.add(
                        PopupMenuItem<MonthMenuAction>(
                          value: MonthMenuAction.startSlideshow,
                          child: Row(
                            children: [
                              Icon(
                                Icons.slideshow,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              const Text('スライドショー'),
                            ],
                          ),
                        ),
                      );
                    }
                    // フォトリクエストをログアウトの直前に配置
                    items.add(
                      PopupMenuItem<MonthMenuAction>(
                        value: MonthMenuAction.photoRequests,
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text('フォトリクエスト'),
                          ],
                        ),
                      ),
                    );
                    items.add(
                      PopupMenuItem<MonthMenuAction>(
                        value: MonthMenuAction.logout,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text('ログアウト'),
                          ],
                        ),
                      ),
                    );
                    return items;
                  },
                );
              },
              onSelected: (action) {
                _onMenuSelected(action);
              },
            ),
          ),
        ),
      );
    }

    Widget buildBody() {
      return asyncData.when(
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
          final photo = data.photos.isNotEmpty ? data.photos.first : null;
          final nowYear = DateTime.now().year;
          final monthDate = DateTime(nowYear, data.month, 1);

          final controller = PageController(initialPage: 1, keepPage: false);
          Widget buildCard(DateTime m, String? url) => SizedBox.expand(
            child: PhotoCalendarCard(
              month: m,
              imageUrl: url,
              imageUrls: data.photos.map((p) => p.url).toList(),
              onTapImageWhenEmpty: () async {
                final data = ref.read(monthViewModelProvider).value;
                if (data == null || data.isReadOnly) {
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
                  await notifier.onAddPhotoFile(File(picked.path));
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
              onTapImageWhenExists: () {
                context.router.push(const MonthPhotoListRoute());
              },
            ),
          );
          return PageView(
            controller: controller,
            onPageChanged: (index) {
              if (index == 0) {
                notifier.prevMonth();
                controller.jumpToPage(1);
              } else if (index == 2) {
                notifier.nextMonth();
                controller.jumpToPage(1);
              }
            },
            children: [
              buildCard(monthDate, photo?.url),
              buildCard(monthDate, photo?.url),
              buildCard(monthDate, photo?.url),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Stack(children: [buildBody(), buildTopRightButtons()]),
    );
  }
}
