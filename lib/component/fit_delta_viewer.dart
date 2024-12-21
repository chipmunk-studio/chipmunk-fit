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
  });

  final String deltaJson;
  final bool isReadOnly;

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
        scrollable: true,
        // 스크롤 가능하도록 설정
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).padding.bottom),
        autoFocus: false,
        enableSelectionToolbar: false,
        expands: true,
        // 가용 공간을 모두 차지하도록 설정
        maxContentWidth: 800,
        embedBuilders: [
          ImageEmbedBuilder(800),
        ],
      ),
    );
  }
}

class ImageEmbedBuilder extends EmbedBuilder {
  ImageEmbedBuilder(this.maxContentWidth);

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
