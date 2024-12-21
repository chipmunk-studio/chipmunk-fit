import 'dart:convert';

import 'package:chipfit/component/image/fit_cached_network_Image.dart';
import 'package:chipfit/component/image/fit_image_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class FitDeltaViewer extends StatefulWidget {
  const FitDeltaViewer({
    super.key,
    required this.deltaJson,
    this.isReadOnly = true,
    this.scrollable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.autoFocus = false,
    this.enableSelectionToolbar = false,
    this.expands = true,
    this.maxContentWidth = 800,
  });

  final String deltaJson;
  final bool isReadOnly;
  final bool scrollable;
  final EdgeInsets padding;
  final bool autoFocus;
  final bool enableSelectionToolbar;
  final bool expands;
  final double maxContentWidth;

  @override
  State<FitDeltaViewer> createState() => _FitDeltaViewerState();
}

class _FitDeltaViewerState extends State<FitDeltaViewer> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
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
      // Delta JSON 파싱
      final List<dynamic> deltaOps = jsonDecode(widget.deltaJson)['ops'];
      final document = Document.fromJson(deltaOps);

      // QuillController 생성 (고유 인스턴스)
      _controller = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: widget.isReadOnly,
      );
      setState(() {}); // 상태 업데이트
    } catch (e) {
      debugPrint('DeltaViewer: Error initializing controller - $e');
      _controller = QuillController.basic();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QuillEditor.basic(
      controller: _controller,
      focusNode: FocusNode(),
      scrollController: ScrollController(),
      configurations: QuillEditorConfigurations(
        scrollable: widget.scrollable,
        padding: widget.padding,
        autoFocus: widget.autoFocus,
        enableSelectionToolbar: widget.enableSelectionToolbar,
        expands: widget.expands,
        maxContentWidth: widget.maxContentWidth,
        embedBuilders: [_ImageEmbedBuilder(widget.maxContentWidth)],
      ),
    );
  }
}

class _ImageEmbedBuilder extends EmbedBuilder {
  _ImageEmbedBuilder(this.maxContentWidth);

  final double? maxContentWidth;

  @override
  String get key => BlockEmbed.imageType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final url = node.value.data as String;
    final image = buildFitImage(
      url: url,
      fit: BoxFit.scaleDown,
      imageShape: FitImageShape.RECTANGLE,
    );

    final alignment = node.parent?.style.attributes['align'];
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxContentWidth ?? double.infinity),
      child: Align(
        alignment: alignment?.value == 'right'
            ? Alignment.topRight
            : alignment?.value == 'center'
                ? Alignment.topCenter
                : Alignment.topLeft,
        child: image,
      ),
    );
  }
}
