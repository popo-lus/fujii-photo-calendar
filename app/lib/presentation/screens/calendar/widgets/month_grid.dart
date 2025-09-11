// (T021) カレンダーグリッド (簡易版プレースホルダー)
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fujii_photo_calendar/domain/entities/photo_entity.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.photos});
  final List<PhotoEntity> photos;
  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const Center(child: Text('No photos'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (c, i) {
        final p = photos[i];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey.shade200,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(imageUrl: p.url),
              ),
              if (p.type.isAdmin)
                const Positioned(
                  top: 4,
                  right: 4,
                  child: Icon(Icons.star, size: 14, color: Colors.amber),
                ),
            ],
          ),
        );
      },
    );
  }
}
