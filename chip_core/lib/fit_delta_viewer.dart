import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// Quill Delta JSON을 읽기 전용으로 표시하는 뷰어 위젯
///
/// - deltaJson: Quill Delta JSON 문자열 ({"ops": [...]})
/// - 파싱 실패 시 빈 문서 표시
/// - 읽기 전용, 커서 숨김, 선택 툴바 비활성화가 기본값
class FitDeltaViewer extends StatefulWidget {
  /// Delta JSON 문자열 (Quill 형식)
  final String deltaJson;

  /// 읽기 전용 여부 (기본: true)
  final bool isReadOnly;

  /// 커서 표시 여부 (기본: false)
  final bool showCursor;

  /// 스크롤 가능 여부 (기본: true)
  final bool scrollable;

  /// 에디터 패딩 (기본: EdgeInsets.zero)
  final EdgeInsets padding;

  /// 자동 포커스 여부 (기본: false)
  final bool autoFocus;

  /// 선택 툴바 표시 여부 (기본: false)
  final bool enableSelectionToolbar;

  /// 부모 위젯의 높이에 맞춰 확장 여부 (기본: true)
  final bool expands;

  /// 최대 컨텐츠 너비 (기본: 800)
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

    // deltaJson이 변경되면 컨트롤러 재생성
    if (widget.deltaJson != oldWidget.deltaJson) {
      _controller.dispose();
      _initializeController();
    }
  }

  /// Delta JSON 파싱 후 QuillController 생성
  void _initializeController() {
    try {
      final json = jsonDecode(widget.deltaJson);
      final deltaOps = json['ops'] as List<dynamic>;
      final document = Document.fromJson(deltaOps);

      _controller = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: widget.isReadOnly,
      );
    } catch (e) {
      // 파싱 실패 시 빈 문서 생성
      debugPrint('FitDeltaViewer: Delta JSON 파싱 실패 - $e');
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
