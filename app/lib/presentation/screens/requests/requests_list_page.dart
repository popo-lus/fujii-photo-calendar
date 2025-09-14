import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';
import 'package:fujii_photo_calendar/data/repositories/request_repository_impl.dart';
import 'package:fujii_photo_calendar/domain/usecases/delete_request_usecase.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fujii_photo_calendar/presentation/widgets/glass_containers.dart';

@RoutePage()
class RequestsListPage extends ConsumerWidget {
  const RequestsListPage({super.key, required this.ownerUid});
  final String ownerUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(recentRequestsStreamProvider(ownerUid));
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('受信リクエスト'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer.withOpacity(0.35),
                  colorScheme.surface.withOpacity(0.2),
                ],
              ),
            ),
          ),
          asyncList.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('読み込みに失敗しました: $e')),
            data: (list) {
              if (list.isEmpty) {
                return const Center(child: Text('新しいリクエストはありません'));
              }
              // Pinterest風マソンリ配置
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final r = list[index];
                      // テキスト長により高さが異なるカード
                      return _RequestCard(ownerUid: ownerUid, request: r);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends ConsumerWidget {
  const _RequestCard({required this.ownerUid, required this.request});
  final String ownerUid;
  final RequestEntity request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(request.comment, style: text.bodyLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: Colors.black.withOpacity(0.5),
              ),
              const SizedBox(width: 6),
              Text(
                request.createdAt?.toLocal().toString() ?? '-',
                style: text.bodySmall?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const Spacer(),
              IconButton(
                tooltip: '既読として削除',
                icon: const Icon(Icons.done_all),
                onPressed: () async {
                  final ok =
                      await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('既読にしますか？'),
                          content: const Text('このリクエストは一覧から削除されます。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('キャンセル'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('削除'),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                  if (!ok) return;
                  try {
                    await ref
                        .read(deleteRequestUsecaseProvider)
                        .call(ownerUid: ownerUid, requestId: request.id);
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('削除しました')));
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('削除に失敗しました: $e')));
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
