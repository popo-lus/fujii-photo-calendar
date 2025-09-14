import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Pinterest風の背景モザイク画像を敷いた上に子ウィジェットを重ねる
class PinterestBackground extends StatelessWidget {
  const PinterestBackground({super.key, required this.child, this.imageUrls});

  final Widget child;
  final List<String>? imageUrls;

  static const List<String> _defaultImages = [
    // Unsplash (サンプル)。必要に応じて差し替え可。
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d',
    'https://images.unsplash.com/photo-1499084732479-de2c02d45fc4',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1495567720989-cebdbdd97913',
    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
    'https://images.unsplash.com/photo-1495562569060-2eec283d3391',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a',
    'https://images.unsplash.com/photo-1432139555190-58524dae6a55',
    'https://images.unsplash.com/photo-1494526585095-c41746248156',
    'https://images.unsplash.com/photo-1499364615650-ec38552f4f34',
    'https://images.unsplash.com/photo-1490111718993-d98654ce6cf7',
    'https://images.unsplash.com/photo-1473172707857-f9e276582ab6',
    'https://images.unsplash.com/photo-1521335629791-ce4aec67dd53',
    'https://images.unsplash.com/photo-1504196606672-aef5c9cefc92',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
    'https://images.unsplash.com/photo-1504198458663-46f6b0bca3e8',
    'https://images.unsplash.com/photo-1482192505345-5655af888cc4',
  ];

  @override
  Widget build(BuildContext context) {
    final urls = imageUrls ?? _defaultImages;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 背景モザイク
        _BlurredMasonry(urls: urls),
        // うっすら暗くして前景を見やすく
        Container(color: Colors.black.withOpacity(0.35)),
        // 前景
        child,
      ],
    );
  }
}

class _BlurredMasonry extends StatelessWidget {
  const _BlurredMasonry({required this.urls});

  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width < 480
        ? 2
        : width < 800
        ? 3
        : 4;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(12),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: urls.length,
        itemBuilder: (context, index) {
          final url = urls[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
