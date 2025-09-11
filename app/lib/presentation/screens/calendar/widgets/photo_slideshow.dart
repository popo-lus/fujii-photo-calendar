// (T022) スライドショー (簡易版)
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

// インデックスを保持する StateProvider (Widget 単位)
final slideshowIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class PhotoSlideshow extends ConsumerWidget {
  const PhotoSlideshow({super.key, required this.all, required this.batch});
  final List<PhotoEntity> all;
  final List<PhotoEntity> batch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (batch.isEmpty) {
      return const Center(child: Text('No slideshow photos'));
    }
    final index = ref.watch(slideshowIndexProvider);
    final current = batch[index % batch.length];
    void next() => ref
        .read(slideshowIndexProvider.notifier)
        .update((i) => (i + 1) % batch.length);
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
            child: Text(
              '${index + 1}/${batch.length}',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
