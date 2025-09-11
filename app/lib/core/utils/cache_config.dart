// (T025) 画像キャッシュ設定: cached_network_image カスタム CacheManager
// 目的: 将来サイズ/有効期限を集中管理 & 差し替え容易にする

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/widgets.dart';

class AppImageCache {
  static const key = 'appImageCache';
  static CacheManager create({
    Duration maxAge = const Duration(days: 7),
    int maxNrOfCacheObjects = 300,
  }) {
    return CacheManager(
      Config(
        key,
        stalePeriod: maxAge,
        maxNrOfCacheObjects: maxNrOfCacheObjects,
        repo: JsonCacheInfoRepository(databaseName: key),
        fileService: HttpFileService(),
      ),
    );
  }

  static PlaceholderWidgetBuilder placeholderBuilder() =>
      (context, url) => const SizedBox();
}
