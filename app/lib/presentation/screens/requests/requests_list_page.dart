import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/entities/request_entity.dart';
import 'package:fujii_photo_calendar/data/repositories/request_repository_impl.dart';
import 'package:fujii_photo_calendar/domain/usecases/delete_request_usecase.dart';

@RoutePage()
class RequestsListPage extends ConsumerWidget {
  const RequestsListPage({super.key, required this.ownerUid});
  final String ownerUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(recentRequestsStreamProvider(ownerUid));
    return Scaffold(
      appBar: AppBar(title: const Text('受信リクエスト')),
      body: asyncList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('読み込みに失敗しました: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('新しいリクエストはありません'));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final r = list[index];
              return _RequestTile(ownerUid: ownerUid, request: r);
            },
          );
        },
      ),
    );
  }
}

class _RequestTile extends ConsumerWidget {
  const _RequestTile({required this.ownerUid, required this.request});
  final String ownerUid;
  final RequestEntity request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(request.comment),
      subtitle: Text(
        request.createdAt?.toLocal().toString() ?? '-',
        maxLines: 1,
      ),
      trailing: IconButton(
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
    );
  }
}
