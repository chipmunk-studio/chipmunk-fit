import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Quill Delta JSON 뷰어 위젯
class FitDeltaViewer extends StatefulWidget {
  final String deltaJson;
  final bool isReadOnly;
  final bool showCursor;
  final bool scrollable;
  final EdgeInsets padding;
  final bool autoFocus;
  final bool enableSelectionToolbar;
  final bool expands;
  final double maxContentWidth;

  const FitDeltaViewer({
    super.key,
    required this.deltaJson,
    this.isReadOnly = true,
    this.showCursor = false,
    this.scrollable = true,
    this.padding = EdgeInsets.zero,
    this.autoFocus = false,
    this.enableSelectionToolbar = false,
    this.expands = true,
    this.maxContentWidth = 800,
  });

  @override
  State<FitDeltaViewer> createState() => _FitDeltaViewerState();
}

class _FitDeltaViewerState extends State<FitDeltaViewer> {
  late QuillController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _initializeController();
  }

  @override
  void didUpdateWidget(covariant FitDeltaViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.deltaJson != oldWidget.deltaJson) {
      _initializeController();
    }
  }

  void _initializeController() {
    try {
      final deltaOps = jsonDecode(widget.deltaJson)['ops'] as List<dynamic>;
      final document = Document.fromJson(deltaOps);

      _controller = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: widget.isReadOnly,
      );

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('FitDeltaViewer: Delta 파싱 실패 - $e');
      _controller = QuillController.basic();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QuillEditor.basic(
      controller: _controller,
      focusNode: _focusNode,
      scrollController: _scrollController,
      config: QuillEditorConfig(
        scrollable: widget.scrollable,
        padding: widget.padding,
        autoFocus: widget.autoFocus,
        enableSelectionToolbar: widget.enableSelectionToolbar,
        expands: widget.expands,
        maxContentWidth: widget.maxContentWidth,
        showCursor: widget.showCursor,
      ),
    );
  }
}
