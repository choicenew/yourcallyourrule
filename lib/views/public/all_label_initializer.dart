
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../screens/appstate_provider.dart';


void initializeAllLabels(BuildContext context) async {
  final appState = Provider.of<AppState>(context, listen: false);

  // 依次对所有 xxxService 使用 ListServiceInitializer 进行初始化
  await ListServiceInitializer(appState.labelService).initialize();
  await ListServiceInitializer(appState.whitelistService).initialize();
  await ListServiceInitializer(appState.allowedService).initialize();
  await ListServiceInitializer(appState.blockedService).initialize();
  await ListServiceInitializer(appState.blacklistService).initialize();

  print("All labels initialized via ListServiceInitializer.");
}


class ListServiceInitializer {
  final dynamic listService;

  ListServiceInitializer(this.listService);

  Future<void> initialize() async {
    print("Initializing labels for: ${listService.runtimeType}");
    final labels = await listService.getAllLabels();
    if (labels.isEmpty) {
      await listService.insertPredefinedLabelsIfNotExists(listService.database);
      print("Predefined labels inserted for: ${listService.runtimeType}");
    }
  }
}