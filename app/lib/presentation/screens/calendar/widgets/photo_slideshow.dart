// (T022) スライドショー (簡易版)
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

// Hooks でインデックス管理に変更

class PhotoSlideshow extends HookConsumerWidget {
  const PhotoSlideshow({super.key, required this.all, required this.batch});
  final List<PhotoEntity> all;
  final List<PhotoEntity> batch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (batch.isEmpty) {
      return const Center(child: Text('No slideshow photos'));
    }
    final index = useState<int>(0);

    // バッチが変わった/短くなった時に index をリセット
    useEffect(() {
      if (index.value >= batch.length) {
        index.value = 0;
      }
      return null;
    }, [batch.length]);

    final current = batch[index.value % batch.length];
    void next() => index.value = (index.value + 1) % batch.length;
    return GestureDetector(
      onTap: next,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            child: CachedNetworkImage(imageUrl: current.url),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.45),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                '${index.value + 1}/${batch.length}',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.85),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
