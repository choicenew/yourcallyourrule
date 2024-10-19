import 'package:flutter/material.dart';

// 自定义 ReorderableWrap 小部件
class ReorderableWrap extends StatefulWidget {
  final List<Widget> children;
  final Function(int oldIndex, int newIndex) onReorder;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;

  const ReorderableWrap({
    super.key,
    required this.children,
    required this.onReorder,
    this.spacing = 0,
    this.runSpacing = 0,
    this.padding = EdgeInsets.zero,
  });

  @override
  ReorderableWrapState createState() => ReorderableWrapState();
}

class ReorderableWrapState extends State<ReorderableWrap> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.from(widget.children);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: _children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        return LongPressDraggable<int>(
          data: index,
          feedback: Material(
            elevation: 4.0,
            child: child,
          ),
          childWhenDragging: Opacity(
            opacity: 0.5,
            child: child,
          ),
          child: DragTarget<int>(
            builder: (context, candidateData, rejectedData) {
              return ConstrainedBox(
                // Use ConstrainedBox here
                constraints: BoxConstraints(
                  minWidth: 0, // 设置最小宽度为 0
                  minHeight: 0, // 设置最小高度为 0
                  maxWidth: (child as SizedBox).width ?? 0, // 如果宽度为 null，则使用 0
                  maxHeight: (child).height ?? 0, // 如果高度为 null，则使用 0
                ),
                child: child,
              );
            },
            onWillAcceptWithDetails: (details) {
              return details.data != index;
            },
            onAcceptWithDetails: (details) {
              final oldIndex = details.data;
              final newIndex = index;
              widget.onReorder(oldIndex, newIndex);
              setState(() {
                final movedChild = _children.removeAt(oldIndex);
                _children.insert(newIndex, movedChild);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
