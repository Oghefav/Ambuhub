import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AmbuhubCache {
  static final cacheManager = CacheManager(
    Config(
      'ambuhub',
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: 'ambuhub'),
    ),
  );
}