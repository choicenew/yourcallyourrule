//import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';

import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/core_security_message_provider.dart';






class CallerIdSample extends ConsumerStatefulWidget {
  const CallerIdSample({super.key});

  @override
  CallerIdSampleState createState() => CallerIdSampleState();
}

class CallerIdSampleState extends ConsumerState<CallerIdSample> {
  late final ConfigRepository _configRepository;
  
  @override
  void initState() {
    super.initState();
    // 初始化配置仓库
    _configRepository = SharedPreferencesConfigRepository();
    final configurationManager = ConfigurationManager(_configRepository);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final styleProvider = ref.read(callerIdStyleProvider);
      final securityProvider = ref.read(coreSecurityMessageProvider);
      try {
        configurationManager.loadFromRepository(styleProvider, securityProvider);
      } catch (e) {
        // Create and save a default configuration
        configurationManager.saveToRepository(styleProvider, securityProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final mediaQuery = MediaQuery.of(context);

        // Calculate width and height based on screen orientation and size
        final overlayWidth = (orientation == Orientation.portrait
            ? (mediaQuery.size.width < 600
                ? mediaQuery.size.width * 0.95
                : mediaQuery.size.width < 1000
                    ? mediaQuery.size.width * 0.7
                    : mediaQuery.size.width * 0.5)
            : (mediaQuery.size.width < 900
                ? mediaQuery.size.width * 0.6
                : mediaQuery.size.width * 0.4));
        final overlayHeight = overlayWidth *
            (mediaQuery.size.width < 600
                ? 0.4
                : 0.3); // Adjust height ratio as needed // Adjust height ratio as needed

        final styleProvider = ref.watch(callerIdStyleProvider);
        return SizedBox(
          width: overlayWidth,
          height: overlayHeight,
          child: CallerIdContentBuilder.buildOverlayContainer(
            styleProvider: styleProvider,
            child: CallerIdContentBuilder.buildCallerIdContent(
              context: context,
              callerIdData: _mockCallerIdData(),
              styleProvider: styleProvider,
              simInfo: _mockSimInfoData(),
              stirInfo: _mockStirInfoData(),
              isDraggable: false,
            ),
          ),
        );
          },
        );
      }
    
  

  CallerIdData _mockCallerIdData() => CallerIdMockData.mockCallerIdData();
  StirInfo _mockStirInfoData() => CallerIdMockData.mockStirInfoData();
  SimInfo _mockSimInfoData() => CallerIdMockData.mockSimInfoData();
}
