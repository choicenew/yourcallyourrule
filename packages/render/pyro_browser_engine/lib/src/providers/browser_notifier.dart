import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 浏览器引擎的 Headless 状态模型
class BrowserEngineState {
  final String selectedText;
  final String extractedArticleText;
  final bool isExtracting;
  final String? translationResult;
  final String error;
  final bool useCustomSelectionMenu;

  BrowserEngineState({
    this.selectedText = '',
    this.extractedArticleText = '',
    this.isExtracting = false,
    this.translationResult,
    this.error = '',
    this.useCustomSelectionMenu = true,
  });

  BrowserEngineState copyWith({
    String? selectedText,
    String? extractedArticleText,
    bool? isExtracting,
    String? translationResult,
    String? error,
    bool? useCustomSelectionMenu,
  }) {
    return BrowserEngineState(
      selectedText: selectedText ?? this.selectedText,
      extractedArticleText: extractedArticleText ?? this.extractedArticleText,
      isExtracting: isExtracting ?? this.isExtracting,
      translationResult: translationResult ?? this.translationResult,
      error: error ?? this.error,
      useCustomSelectionMenu: useCustomSelectionMenu ?? this.useCustomSelectionMenu,
    );
  }
}

/// Headless Notifier，纯状态机，无任何 UI 耦合
class BrowserEngineNotifier extends Notifier<BrowserEngineState> {
  @override
  BrowserEngineState build() {
    return BrowserEngineState();
  }

  void toggleSelectionMenuMode() {
    state = state.copyWith(useCustomSelectionMenu: !state.useCustomSelectionMenu);
  }

  void updateSelectedText(String text) {
    state = state.copyWith(selectedText: text);
  }

  void clearSelection() {
    state = state.copyWith(selectedText: '');
  }

  void startExtraction() {
    state = state.copyWith(isExtracting: true, error: '');
  }

  void completeExtraction(String articleText) {
    state = state.copyWith(isExtracting: false, extractedArticleText: articleText);
  }

  void extractionFailed(String errorMsg) {
    state = state.copyWith(isExtracting: false, error: errorMsg);
  }

  void setTranslationResult(String result) {
    state = state.copyWith(translationResult: result);
  }

  void clearTranslationResult() {
    state = state.copyWith(translationResult: null);
  }
}

final browserEngineProvider = NotifierProvider<BrowserEngineNotifier, BrowserEngineState>(
  () => BrowserEngineNotifier(),
);
