import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ScrollingSecurityMessage extends StatefulWidget {
  final CallerIdConfig config;
  final bool isDraggable;
  final Function(Offset)? onPositionChanged;
  final String? overrideMessage; // 用于强制显示特定消息，如诈骗警告
  final Color? overrideColor;     // 用于强制使用特定颜色

  const ScrollingSecurityMessage({
    super.key,
    required this.config,
    this.isDraggable = true,
    this.onPositionChanged,
    this.overrideMessage,
    this.overrideColor,
  });

  @override
  State<ScrollingSecurityMessage> createState() => _ScrollingSecurityMessageState();
}

class _ScrollingSecurityMessageState extends State<ScrollingSecurityMessage> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }
  
  @override
  void didUpdateWidget(covariant ScrollingSecurityMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If config changes, restart scrolling logic
    if (oldWidget.config != widget.config || oldWidget.overrideMessage != widget.overrideMessage) {
      _scrollTimer?.cancel();
      _scrollController.jumpTo(0);
      _startScrolling();
    }
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    final config = widget.config;
    if (!config.securityMessageEnabled) return;

    final message = widget.overrideMessage ?? AppLocalizations.of(context)!.securityMessage;
    final color = widget.overrideColor ?? config.securityMessageTextColor;

    final textPainter = TextPainter(
      text: TextSpan(
        text: message,
        style: TextStyle(fontSize: config.securityMessageFontSize, color: color),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;
    final containerWidth = config.securityMessageContainerWidth;

    if (textWidth <= containerWidth) return;

    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.position.pixels;
        
        if (currentPosition >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
           _scrollController.animateTo(
            currentPosition + (config.securityMessageScrollSpeed / 20), // speed adjustment
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    if (!config.securityMessageEnabled && widget.overrideMessage == null) {
      return const SizedBox.shrink();
    }
    
    final content = _buildSecurityMessageContainer(config);

    return Positioned(
      left: config.securityMessagePosition.dx,
      top: config.securityMessagePosition.dy,
      child: widget.isDraggable && widget.onPositionChanged != null
          ? GestureDetector(
              onPanUpdate: (details) {
                widget.onPositionChanged!(config.securityMessagePosition + details.delta);
              },
              child: content,
            )
          : content,
    );
  }

  Widget _buildSecurityMessageContainer(CallerIdConfig config) {
    final message = widget.overrideMessage ?? AppLocalizations.of(context)!.securityMessage;
    final textColor = widget.overrideColor ?? config.securityMessageTextColor;
    
    return Container(
      width: config.securityMessageContainerWidth,
      height: config.securityMessageHeight,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: config.securityMessageBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            message,
            style: TextStyle(
              color: textColor,
              fontSize: config.securityMessageFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}