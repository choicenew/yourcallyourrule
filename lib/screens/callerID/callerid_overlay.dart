

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../services/caller_id_monitor_service.dart';

import '../../services/caller_id_service.dart';

import 'callerid_style_provider.dart';
import 'number_type_extension.dart';


class CallerIdOverlay extends StatefulWidget {
  final CallerIdData callerIdData;
  final SimInfo? simInfo;  
  final StirInfo? stirInfo;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const CallerIdOverlay({
    super.key,
    required this.callerIdData,
    this.simInfo,
    this.stirInfo,
    required this.onDismiss,
    required this.isDismissible,  
  });

  @override
  CallerIdOverlayState createState() => CallerIdOverlayState();
}

class CallerIdOverlayState extends State<CallerIdOverlay> {


  final double _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return widget.isDismissible
        ? Dismissible(
            key: Key(widget.callerIdData.phoneNumber),
            direction: DismissDirection.horizontal,
            onDismissed: (_) => widget.onDismiss(),
            child: _buildOverlayContent(context), 
          )
        : _buildOverlayContent(context);
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Consumer<CallerIdStyleProvider>(
        builder: (context, styleProvider, child) {
          return Container(
            width: styleProvider.windowWidth,
            height: styleProvider.windowHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(6.0, 1),
                end: const Alignment(-1, 6.0),
                colors: [
                  styleProvider.backgroundColorStart,
                  styleProvider.backgroundColorEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildCallerIdContent(context, styleProvider),
          );
        },
      ),
    );
  }

  Widget _buildCallerIdContent(BuildContext context, CallerIdStyleProvider styleProvider) {
    return Stack(
      children: <Widget>[
        //头像
        _buildDraggableElement(
          child: CircleAvatar(
                radius: styleProvider.avatarBorderSize / 2,
                backgroundColor: styleProvider.avatarBorderColor,
             child: CircleAvatar(
            radius: styleProvider.avatarSize / 2,
            backgroundImage: widget.callerIdData.avatarImage,
              ),
          ),
          onPositionChanged: styleProvider.updateAvatarPosition,
          position: styleProvider.avatarPosition,
        ),
        //运营商
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.carrier ?? S.of(context).unknown,
            style: TextStyle(
              fontSize: styleProvider.carrierFontSize,
              color: styleProvider.textCarrierColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCarrierPosition,
          position: styleProvider.carrierPosition,
        ),
        //name
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.name,
            style: TextStyle(
              fontSize: styleProvider.nameFontSize,
              color: styleProvider.textNameColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNamePosition,
          position: styleProvider.namePosition,
        ),
        //countryName
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.countryName,
            style: TextStyle(
              fontSize: styleProvider.countryNameFontSize,
              color: styleProvider.textCountryNameColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCountryNamePosition,
          position: styleProvider.countryNamePosition,
        ),
        //label
        _buildDraggableElement(
          child: Row(
            children: [
              Icon(Icons.policy_outlined,
                  color: styleProvider.textIconLabelColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                widget.callerIdData.labels
                    .map((label) => label.label)
                    .join(', '),
                style: TextStyle(
                  fontSize: styleProvider.labelsFontSize,
                  color: styleProvider.textLabelsColor,
                ),
              ),
            ],
          ),
          onPositionChanged: styleProvider.updateLabelsPosition,
          position: styleProvider.labelsPosition,
        ),
        //count
        _buildDraggableElement(
          child: Text(
            //widget.callerIdData.count?.toString() ?? 'Unknown',
            '${S.of(context).markedBy} ${widget.callerIdData.count?.toString() ?? {S.of(context).unknown}}', // 翻译 "Marked by"
            style: TextStyle(
              fontSize: styleProvider.countFontSize,
              color: styleProvider.textCountColor,
            ),
          ),
          onPositionChanged: styleProvider.updateCountPosition,
          position: styleProvider.countPosition,
        ),
        //numberType
        _buildDraggableElement(
          child: Text(
           // widget.callerIdData.numberType?.toString() ?? S.of(context).unknown,
            widget.callerIdData.numberType?.translated(context) ?? S.of(context).unknown,
            style: TextStyle(
              fontSize: styleProvider.numberTypeFontSize,
              color: styleProvider.textNumberTypeColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNumberTypePosition,
          position: styleProvider.numberTypePosition,
        ),
        //电话号码
        _buildDraggableElement(
          child: Text(
            widget.callerIdData.phoneNumber,
            style: TextStyle(
              fontSize: styleProvider.numberFontSize,
              color: styleProvider.textNumberColor,
            ),
          ),
          onPositionChanged: styleProvider.updateNumberPosition,
          position: styleProvider.numberPosition,
        ),
        //地理位置
        _buildDraggableElement(
          child: Row(
            children: [
              Icon(Icons.location_on,
                  color: styleProvider.textIconLocationColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                widget.callerIdData.region ?? S.of(context).unknown,
                style: TextStyle(
                  fontSize: styleProvider.locationFontSize,
                  color: styleProvider.textLocationColor,
                ),
              ),
            ],
          ),
          onPositionChanged: styleProvider.updateLocationPosition,
          position: styleProvider.locationPosition,
        ),
        // Add more elements as needed
        //stir位置
        _buildDraggableElement(
          child: Text(
            // 直接使用 if-else if-else 语句
            widget.stirInfo!.isVerified
                ? S.of(context).verified
                : (widget.stirInfo!.isNotVerified ? S.of(context).notVerified : S.of(context).failed),
            style: TextStyle(
              fontSize: styleProvider.stirFontSize,
              color: styleProvider.textStirColor,
            ),
          ),
          onPositionChanged: styleProvider.updateStirPosition,
          position: styleProvider.stirPosition,
        ),

        //CallType位置
        _buildDraggableElement(
          child: Row(
            children: [
              Icon(
                widget.simInfo?.callType == "incoming"
                    ? Icons.call_received
                    : Icons.call_made,
                color: styleProvider.textIconCallTypeColor,
                size: styleProvider.iconSize,
              ),
              const SizedBox(width: 5),
              // ... other children ...
            ],
          ),
          onPositionChanged: styleProvider.updateCallTypePosition,
          position: styleProvider.callTypePosition,
        ),

        //SIM卡位置

        _buildDraggableElement(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5), // 半透明白色
              borderRadius: BorderRadius.circular(8.0), // 圆角
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0), // 内边距
            child: Row(
              children: [
                Text(
                  widget.simInfo?.simSlotIndex == 0
                      ? "SIM 1,-${widget.simInfo?.countryIso}"
                      : (widget.simInfo?.simSlotIndex != null
                          ? "SIM 2,-${widget.simInfo?.countryIso}"
                          : S.of(context).unknown),
                  style: TextStyle(
                    fontSize: styleProvider.simCardFontSize,
                    color: styleProvider.textSimCardColor,
                  ),
                ),
              ],
            ),
          ),
          onPositionChanged: styleProvider.updateSimCardPosition,
          position: styleProvider.simCardPosition,
        ),


        // Add more elements as needed
      ],
    );
  }

  Widget _buildDraggableElement({
    required Widget child,
    required Function(Offset) onPositionChanged,
    required Offset position,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          onPositionChanged(position + details.delta);
        },
        child: child,
      ),
    );
  }
}
