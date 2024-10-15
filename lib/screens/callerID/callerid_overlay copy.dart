import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../services/caller_id_service.dart';

import 'callerid_style_provider.dart';



class CallerIdOverlay extends StatefulWidget {
  final CallerIdData callerIdData;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const CallerIdOverlay({
    super.key,
    required this.callerIdData,
    required this.onDismiss,
    required this.isDismissible,
  });

  @override
  CallerIdOverlayState createState() => CallerIdOverlayState();
}

class CallerIdOverlayState extends State<CallerIdOverlay> {
  Offset _offset = const Offset(20, 20);
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _offset += details.delta;
              // 确保 overlay 不会移出屏幕
              _offset = Offset(
                _offset.dx.clamp(0, MediaQuery.of(context).size.width - 300),
                _offset.dy.clamp(0, MediaQuery.of(context).size.height - 150),
              );
            });
          },
          child: widget.isDismissible
              ? Dismissible(
                  key: Key(widget.callerIdData.phoneNumber),
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) => widget.onDismiss(),
                  onUpdate: (details) {
                    setState(() {
                      _opacity = 1.0 - details.progress;
                    });
                  },
                  child: _buildOverlayContent(),
                )
              : _buildOverlayContent(),
        ));
  }

  Widget _buildOverlayContent() {
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
            child: _buildCallerIdContent(styleProvider),
          );
        },
      ),
    );
  }

  Widget _buildCallerIdContent(CallerIdStyleProvider styleProvider) {
    return Stack(
      children: <Widget>[
        //头像
        _buildDraggableElement(
          child: CircleAvatar(
            radius: styleProvider.avatarSize / 2,
            backgroundImage: widget.callerIdData.avatarImage,
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
            widget.callerIdData.count?.toString() ?? 'Unknown',
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
            widget.callerIdData.numberType?.toString() ?? 'Unknown',
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
                widget.callerIdData.region ?? 'Unknown',
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
