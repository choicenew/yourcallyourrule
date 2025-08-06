import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/core_security_message_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/security_message_provider.dart';

/// A widget that displays a horizontally scrolling security message
class ScrollingSecurityMessage extends ConsumerStatefulWidget {
  final bool isDraggable;

  const ScrollingSecurityMessage({
    super.key,
    this.isDraggable = true,
  });

  @override
  ConsumerState<ScrollingSecurityMessage> createState() => _ScrollingSecurityMessageState();
}

class _ScrollingSecurityMessageState extends ConsumerState<ScrollingSecurityMessage> {
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Start scrolling after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the default message from localizations if message is empty
      final securityMessageState = ref.read(coreSecurityMessageProvider);
      if (securityMessageState.message.isEmpty) {
        securityMessageState.setMessage(securityMessageState.getDefaultMessage(context));
      }
      _startScrolling();
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    final securityMessageState = ref.read(coreSecurityMessageProvider);
    
    // If the message is not enabled, don't start scrolling
    if (!securityMessageState.isEnabled) return;
    
    // Calculate the total width of the text
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: securityMessageState.message,
        style: TextStyle(
          fontSize: securityMessageState.fontSize,
          color: securityMessageState.textColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    
    final textWidth = textPainter.width;
    final containerWidth = securityMessageState.containerWidth;
    
    // Only scroll if the text is wider than the container
    if (textWidth <= containerWidth) return;
    
    // Calculate scroll duration based on text width and scroll speed
    final scrollDuration = Duration(
      milliseconds: ((textWidth / securityMessageState.scrollSpeed) * 1000).toInt(),
    );
    
    // Start scrolling animation
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_scrollController.hasClients) {
        final currentPosition = _scrollController.position.pixels;
        
        // If we've scrolled to the end, jump back to the beginning
        if (currentPosition >= textWidth) {
          _scrollController.jumpTo(0);
        } else {
          // Otherwise, continue scrolling
          _scrollController.animateTo(
            currentPosition + 1,
            duration: const Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final securityMessageState = ref.watch(coreSecurityMessageProvider);
    
    // If the message is not enabled, return an empty widget
    if (!securityMessageState.isEnabled) {
      return const SizedBox.shrink();
    }
    
    return Positioned(
      left: securityMessageState.position.dx,
      top: securityMessageState.position.dy,
      child: widget.isDraggable
          ? GestureDetector(
              onPanUpdate: (details) {
                ref.read(coreSecurityMessageProvider).updatePosition(
                      securityMessageState.position + details.delta,
                    );
              },
              child: _buildSecurityMessageContainer(securityMessageState),
            )
          : _buildSecurityMessageContainer(securityMessageState),
    );
  }

  Widget _buildSecurityMessageContainer(SecurityMessageProvider securityMessageState) {
    return Container(
      width: securityMessageState.containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            securityMessageState.message,
            style: TextStyle(
              color: securityMessageState.textColor,
              fontSize: securityMessageState.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}