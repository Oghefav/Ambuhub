import 'package:flutter/material.dart';

/// Splits [text] into centered upside-down pyramid lines: widest on top,
/// then fewer words per row (e.g. 3 words, then 2, then 1).
/// Each line is checked against [maxWidth] using [style].
List<String> pyramidLinesFromText(
  String text, {
  required double maxWidth,
  required TextStyle style,
  TextDirection textDirection = TextDirection.ltr,
}) {
  final words = text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  if (words.isEmpty) return [];

  final lines = <String>[];
  var wordIndex = 0;
  var wordsForLine = words.length;

  while (wordIndex < words.length) {
    var count = wordsForLine.clamp(1, words.length - wordIndex);
    var added = false;

    while (count >= 1) {
      final end = wordIndex + count;
      final candidate = words.sublist(wordIndex, end).join(' ');

      if (_lineFitsWidth(
        candidate,
        maxWidth: maxWidth,
        style: style,
        textDirection: textDirection,
      )) {
        lines.add(candidate);
        wordIndex = end;
        wordsForLine = count - 1;
        added = true;
        break;
      }
      count--;
    }

    if (!added) {
      lines.add(words[wordIndex]);
      wordIndex++;
      wordsForLine = wordsForLine > 1 ? wordsForLine - 1 : 1;
    }
  }

  return lines;
}

bool _lineFitsWidth(
  String line, {
  required double maxWidth,
  required TextStyle style,
  required TextDirection textDirection,
}) {
  final painter = TextPainter(
    text: TextSpan(text: line, style: style),
    textDirection: textDirection,
    maxLines: 1,
  )..layout(maxWidth: maxWidth);

  return !painter.didExceedMaxLines && painter.width <= maxWidth;
}

extension PyramidTextExtension on Text {
  /// Builds a centered upside-down pyramid: top line is widest, each row below
  /// has fewer words, respecting this widget's [style] and [width].
  Widget toPyramid({required double width}) {
    final plainText = data ?? textSpan?.toPlainText() ?? '';
    final effectiveStyle = style ?? const TextStyle();
    final lines = pyramidLinesFromText(
      plainText,
      maxWidth: width,
      style: effectiveStyle,
      textDirection: textDirection ?? TextDirection.ltr,
    );

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final line in lines)
            Text(
              line,
              style: effectiveStyle,
              textAlign: TextAlign.center,
              textDirection: textDirection,
              locale: locale,
              softWrap: softWrap,
              overflow: overflow,
              textScaler: textScaler,
              maxLines: maxLines,
              semanticsLabel: semanticsLabel,
              textWidthBasis: textWidthBasis,
              textHeightBehavior: textHeightBehavior,
              selectionColor: selectionColor,
            ),
        ],
      ),
    );
  }
}

extension PyramidStringExtension on String {
  List<String> toPyramidLines({
    required double maxWidth,
    required TextStyle style,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    return pyramidLinesFromText(
      this,
      maxWidth: maxWidth,
      style: style,
      textDirection: textDirection,
    );
  }

  Widget toPyramidText({
    required double width,
    required TextStyle style,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    final lines = toPyramidLines(
      maxWidth: width,
      style: style,
      textDirection: textDirection,
    );

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final line in lines)
            Text(
              line,
              style: style,
              textAlign: TextAlign.center,
              textDirection: textDirection,
            ),
        ],
      ),
    );
  }
}
