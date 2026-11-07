import 'dart:async';

import 'package:pyro_fetch_protocol/pyro_fetch_protocol.dart';
import 'package:pyro_media_models/pyro_media_models.dart';
import 'package:pyro_worker_protocol/pyro_worker_protocol.dart';

import '../engine/metadata_identifier_parser.dart';
import '../engine/metadata_matcher.dart';
import '../engine/metadata_merger.dart';
import '../interfaces/metadata_storage_adapter.dart';
import '../worker/metadata_cleaner_task.dart';

class ScraperHandle {
  final SourceExecutor executor;
  final PyroSource source;
  final int priority;

  ScraperHandle({
    required this.executor,
    required this.source,
    this.priority = 0,
  });
}

typedef ScraperResolver = Future<List<ScraperHandle>> Function(
  String contentType,
);

class MetadataOrchestrator {
  final MetadataStorageAdapter storage;
  final ScraperResolver scraperResolver;
  final WorkerDispatcher workerDispatcher;

  bool _isProcessing = false;

  MetadataOrchestrator({
    required this.storage,
    required this.scraperResolver,
    WorkerDispatcher? workerDispatcher,
  }) : workerDispatcher = workerDispatcher ?? WorkerDispatcher.instance;

  Future<void> runAutoScrape() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final items = await storage.getItemsPendingEnrichment();
      for (final item in items) {
        await _processItem(item);
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _processItem(MediaEntity item) async {
    final parsedInfo = MetadataIdentifierParser.parseFilename(item.title);
    final localTitle = parsedInfo['title'] ?? item.title;
    final localAuthors = item.creators.isNotEmpty
        ? item.creators.values.map((e) => e.toString()).toList()
        : (parsedInfo['author'] != null ? [parsedInfo['author']!] : <String>[]);
    final localYear = parsedInfo['year'];

    final handles = await scraperResolver(item.type.name);
    handles.sort((a, b) => b.priority.compareTo(a.priority));

    bool matched = false;
    for (final handle in handles) {
      try {
        String query = localTitle;
        if (localAuthors.isNotEmpty) {
          query += ' ${localAuthors.first}';
        }

        // 升维重构：直接拿到强类型 MediaEntity 列表！
        final results = await handle.executor.search(handle.source, query, 1);
        if (results.isEmpty) continue;

        MediaEntity? bestResult;
        double highestScore = -1.0;

        for (final res in results.take(10)) {
          final resAuthors = res.creators.values.map((e) => e.toString()).toList();
          final resIds = Map<String, String>.from(res.externalIds);
          if (res.doi != null && res.doi!.isNotEmpty) resIds['doi'] = res.doi!;

          final score = MetadataMatcher.calculateMatchScore(
            localTitle: localTitle,
            localAuthors: localAuthors,
            localYear: localYear,
            localIds: {
              'isbn': item.externalIds['isbn'] ?? '',
              'doi': item.doi ?? '',
            },
            remoteTitle: res.title,
            remoteAuthors: resAuthors,
            remoteYear: res.publishDate,
            remoteIds: resIds,
          );

          if (score > highestScore) {
            highestScore = score;
            bestResult = res;
          }
        }

        if (bestResult == null || highestScore < 0.4) continue;

        final detailEntity = await handle.executor.getDetail(
          handle.source,
          bestResult.id,
        );

        final finalEntity = detailEntity ?? bestResult;
        final rawData = finalEntity.toMap();

        rawData[ScrapeMetadataKey.scrapeConfidence] = highestScore;
        rawData[ScrapeMetadataKey.needsManualReview] = highestScore < 0.85;

        final cleanedData = await workerDispatcher.execute(
          const MetadataCleanerTask(),
          rawData,
        );

        final mergedMetadata = MetadataMerger.merge(
          item.customMetadata,
          cleanedData,
        );

        await storage.updateMetadata(item.id, mergedMetadata);
        matched = true;
        break;
      } catch (e) {
        continue;
      }
    }

    if (!matched) {
      await storage.markAsFailed(item.id);
    }
  }
}
