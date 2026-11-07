import 'dart:io';
import 'package:flutter/services.dart';

/// Service for dynamic .ttf/.otf custom font validation and Flutter Engine registration.
class AtmosphereFontService {
  static final AtmosphereFontService instance = AtmosphereFontService._();
  AtmosphereFontService._();

  final Map<String, String> _registeredFonts = {};

  Map<String, String> get registeredFonts => Map.unmodifiable(_registeredFonts);

  /// Dynamically loads and registers a custom TTF/OTF font file into Flutter Engine.
  Future<bool> registerCustomFont(String fontFamily, String fontFilePath) async {
    final file = File(fontFilePath);
    if (!await file.exists()) {
      return false;
    }

    try {
      final bytes = await file.readAsBytes();
      final fontLoader = FontLoader(fontFamily);
      fontLoader.addFont(Future.value(ByteData.sublistView(bytes)));
      await fontLoader.load();
      _registeredFonts[fontFamily] = fontFilePath;
      return true;
    } catch (e) {
      return false;
    }
  }
}
