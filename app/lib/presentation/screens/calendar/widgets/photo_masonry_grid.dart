import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoMasonryGrid extends StatelessWidget {
  const PhotoMasonryGrid({super.key, required this.urls, this.onTap});

  final List<String> urls;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final base = width < 480
        ? 2
        : width < 800
        ? 3
        : 4;
    final crossAxisCount = urls.length <= 1
        ? 1
        : (urls.length < base ? urls.length : base);

    return MasonryGridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: urls.length,
      itemBuilder: (context, index) {
        final url = urls[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onTap != null ? () => onTap!(index) : null,
            child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
