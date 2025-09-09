import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// Security message provider for caller ID overlay
/// Manages the security message content and scrolling state
class SecurityMessageProvider extends ChangeNotifier {
  // Default security message - will be set by getDefaultMessage method
  String _message = "";
  
  // Get default message from localizations
  String getDefaultMessage(BuildContext context) {
    return AppLocalizations.of(context)!.securityMessage;
   
  }
  
  // Scrolling speed (pixels per second)
  double _scrollSpeed = 30.0;
  
  // Text style properties
  Color _textColor = const Color.fromARGB(255, 255, 0, 0); // Red color for security message
  double _fontSize = 14.0;
  
  // Position of the security message
  Offset _position = const Offset(10, 190); // Default position near the bottom
  
  // Width of the security message container
  double _containerWidth = 310.0;
  
  // Height of the security message container
  double _height = 30.0;
  
  // Background color of the security message container
  Color _backgroundColor = const Color(0xB0515151); // Semi-transparent black
  
  // Whether the security message is enabled
  bool _isEnabled = true;
  
  // Getters
  String get message => _message;
  double get scrollSpeed => _scrollSpeed;
  Color get textColor => _textColor;
  double get fontSize => _fontSize;
  Offset get position => _position;
  double get containerWidth => _containerWidth;
  double get height => _height;
  Color get backgroundColor => _backgroundColor;
  bool get isEnabled => _isEnabled;
  
  // Setters with notifyListeners
  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }
  
  void setScrollSpeed(double speed) {
    _scrollSpeed = speed;
    notifyListeners();
  }
  
  void setTextColor(Color color) {
    _textColor = color;
    notifyListeners();
  }
  
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }
  
  void updatePosition(Offset newPosition) {
    _position = newPosition;
    notifyListeners();
  }
  
  void setContainerWidth(double width) {
    _containerWidth = width;
    notifyListeners();
  }
  
  void setHeight(double height) {
    _height = height;
    notifyListeners();
  }
  
  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
  
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    notifyListeners();
  }
}

// Provider is moved to core/provider/providers/security_message_provider.dart