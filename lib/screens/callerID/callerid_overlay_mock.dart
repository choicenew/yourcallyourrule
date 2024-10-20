import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/caller_id_monitor_service.dart';
import '../../services/caller_id_service.dart';
import 'callerid_configuration.dart';
import 'callerid_overlay.dart';

import 'callerid_style_provider.dart';

class CallerIdSample extends StatefulWidget {
  const CallerIdSample({super.key});

  @override
  CallerIdSampleState createState() => CallerIdSampleState();
}

class CallerIdSampleState extends State<CallerIdSample> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final styleProvider =
          Provider.of<CallerIdStyleProvider>(context, listen: false);
      try {
        ConfigurationManager.loadConfiguration(styleProvider);
      } catch (e) {
        print('Error loading configuration: $e');
        // Create and save a default configuration
        ConfigurationManager.saveConfiguration(styleProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CallerIdStyleProvider>(
      create: (context) => CallerIdStyleProvider(),
      child: Builder(builder: (context) {
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

            return SizedBox(
              width: overlayWidth,
              height: overlayHeight,
              child: CallerIdOverlay(
                callerIdData: _mockCallerIdData(),
                simInfo: _mockSimInfoData(),
                stirInfo: _mockStirInfoData(),
                onDismiss: () {},
                isDismissible: false,
               // styleProvider: Provider.of<CallerIdStyleProvider>(context),
              ),
            );
          },
        );
      }),
    );
  }

  CallerIdData _mockCallerIdData() {
    return CallerIdData(
      phoneNumber: '+1 234 567 8900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.fixedLineOrMobile,
      labels: [Label(label: 'Other')],
      name: 'Exampe Name',
      avatar: 'assets/avatars/Other.png', // Replace with your asset path
      count: 5,
    );
  }

  StirInfo _mockStirInfoData() {
    CallerIdData callerIdData = _mockCallerIdData();
    String phoneNumber = callerIdData.phoneNumber;

    return StirInfo(
      isVerified: true,
      isNotVerified: false,
      isFailed: false,
      phoneNumber: phoneNumber,
    );
  }

  SimInfo _mockSimInfoData() {
    return SimInfo(
      carrierName: 'Example Carrier',
      displayName: 'SIM 1',
      iccId: '8901234567890123456',
      countryIso: 'US',
      phoneNumber: '+1 234 567 8900',
      simSlotIndex: 0,
      subscriptionId: 1,
      mccString: '310',
      mncString: '410',
      simPhoneNumber: '+1 123 456 7890',
      callType: "audio",
    );
  }
}
