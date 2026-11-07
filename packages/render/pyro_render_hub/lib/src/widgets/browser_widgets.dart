import 'dart:ui';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_action_hub/pyro_action_hub.dart';
import 'package:pyro_action_protocol/pyro_action_protocol.dart';
import '../l10n/generated/app_localizations.dart';

/// 浏览器划词划线悬浮条
class BrowserSelectionOverlay extends StatelessWidget {
  final String selectedText;
  final VoidCallback onLookup;
  final VoidCallback onTranslate;
  final VoidCallback onClose;

  const BrowserSelectionOverlay({
    super.key,
    required this.selectedText,
    required this.onLookup,
    required this.onTranslate,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (selectedText.trim().isEmpty) return const SizedBox.shrink();

    return Positioned(
      bottom: 80,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.auto_awesome, color: theme.colorScheme.primary, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Selected: "$selectedText"',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onLookup,
              child: Text(
                AppLocalizations.of(context)?.lookupWordAction ?? 'Lookup',
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: onTranslate,
              child: Text(
                AppLocalizations.of(context)?.translateAction ?? 'Translate',
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white70, size: 16),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}

/// 浏览器底部浮动交互工具栏
class BrowserBottomActionBar extends StatelessWidget {
  final Stream<List<UserAction>> actionStream;
  final VoidCallback onClose;

  const BrowserBottomActionBar({
    super.key,
    required this.actionStream,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<UserAction>>(
      stream: actionStream,
      builder: (context, snapshot) {
        final actions = snapshot.data ?? [];
        if (actions.isEmpty) return const SizedBox.shrink();

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...actions.map((action) {
                                return InkWell(
                                  onTap: () {
                                    if (action.intent != null) {
                                      ActionHub.instance.dispatchIntent(MediaTypeToken.browser, action.intent!);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(action.icon, size: 20, color: theme.colorScheme.primary),
                                        const SizedBox(height: 3),
                                        Text(
                                          action.localizedLabel(context),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              InkWell(
                                onTap: onClose,
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.close_rounded, size: 20, color: theme.colorScheme.error),
                                      const SizedBox(height: 3),
                                      Text(
                                        AppLocalizations.of(context)?.cancel ?? 'Cancel',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 浏览器 Popup 菜单组件
class BrowserPopupMenu extends StatelessWidget {
  final PopupMenuItemSelected<String> onSelected;

  const BrowserPopupMenu({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded, size: 22),
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'copy',
          child: Row(
            children: [
              const Icon(Icons.copy_rounded, size: 18),
              const SizedBox(width: 10),
              Text(AppLocalizations.of(context)?.copyLink ?? 'Copy Link'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'external',
          child: Row(
            children: [
              const Icon(Icons.open_in_browser_rounded, size: 18),
              const SizedBox(width: 10),
              Text(AppLocalizations.of(context)?.openInSystemBrowser ?? 'Open in Browser'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: 'translate_dom',
          child: Row(
            children: [
              const Icon(Icons.g_translate_rounded, size: 18, color: Color(0xFF1DA1F2)),
              const SizedBox(width: 10),
              Text(ActionId.browserTranslateDom.name),
            ],
          ),
        ),
      ],
    );
  }
}
