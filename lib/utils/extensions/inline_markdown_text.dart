import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../exports.dart';

/// A lightweight Markdown-like inline text renderer.
///
/// Supports:
/// - `**bold**`
/// - `_italic_` or `*italic*`
/// - `__underline__`
/// - `~~strikethrough~~`
/// - `` `inline code` ``
/// - `[label](https://url)` (with tap + long press support)
///
/// Example:
/// ```dart
/// InlineMarkdownText(
///   text: "Hello **World**, visit [HappyPet](https://happypet.care)",
///   textAlign: TextAlign.center,
///   onTapLink: (url) => print("Tapped $url"),
///   onLongPressLink: (url) => print("Long pressed $url"),
/// )
/// ```
class InlineMarkdownText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextStyle? codeStyle;
  final void Function(String url)? onTapLink;
  final void Function(String url)? onLongPressLink;

  /// Align text like in normal [Text] widget
  final TextAlign textAlign;

  /// When true (default), links use WidgetSpan with GestureDetector so tap+longPress both work.
  final bool autoLaunchLinks;

  const InlineMarkdownText({
    super.key,
    required this.text,
    this.style,
    this.linkStyle,
    this.codeStyle,
    this.onTapLink,
    this.onLongPressLink,
    this.autoLaunchLinks = true,
    this.textAlign = TextAlign.start,
  });

  TextStyle _baseStyle(BuildContext context) => style ?? DefaultTextStyle.of(context).style;

  // Default handlers if user didn't provide any
  void _defaultTap(BuildContext context, String url) {
    if (onTapLink != null) {
      onTapLink!(url);
      return;
    }
    if (autoLaunchLinks) {
      launchUrlFunction(url);
    } else {
      debugPrint('Link tapped: $url');
    }
  }

  void _defaultLongPress(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    UiUtils.toast("Link copied: $url");
  }

  List<InlineSpan> _buildSpans(BuildContext context) {
    final baseStyle = _baseStyle(context);
    final linkStyleFinal = linkStyle ?? baseStyle.copyWith(color: Colors.blue, decoration: TextDecoration.underline);
    final codeStyleFinal = codeStyle ?? baseStyle.copyWith(fontFamily: 'monospace', backgroundColor: Colors.grey.shade200);

    // Combined regex: groups order same as earlier code
    final regex = RegExp(
      r'`([^`]+?)`' // inline code -> group(1)
      r'|\[([^\]]+?)\]\((https?:\/\/[^\s)]+)\)' // link -> group(2)=label group(3)=url
      r'|\*\*(.+?)\*\*' // bold -> group(4)
      r'|__(.+?)__' // underline -> group(5)
      r'|~~(.+?)~~' // strikethrough -> group(6)
      r'|_(.+?)_' // italic underscore -> group(7)
      r'|\*(.+?)\*', // italic star -> group(8)
      dotAll: true,
    );

    final spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final m in regex.allMatches(text)) {
      if (m.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, m.start), style: baseStyle));
      }

      if (m.group(1) != null) {
        // code
        spans.add(TextSpan(text: m.group(1), style: codeStyleFinal));
      } else if (m.group(2) != null && m.group(3) != null) {
        final label = m.group(2)!;
        final url = m.group(3)!;

        void handleTap() {
          final cb = onTapLink ?? (String u) => _defaultTap(context, u);
          cb(url);
        }

        void handleLong() {
          final cb = onLongPressLink ?? (String u) => _defaultLongPress(context, u);
          cb(url);
        }

        if (autoLaunchLinks) {
          // Use WidgetSpan with GestureDetector to support tap + long press
          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: handleTap,
                onLongPress: handleLong,
                child: Text(label, style: linkStyleFinal),
              ),
            ),
          );
        } else {
          // Traditional TextSpan with TapGestureRecognizer (only supports tap reliably)
          final recognizer = TapGestureRecognizer()..onTap = handleTap;
          spans.add(TextSpan(text: label, style: linkStyleFinal, recognizer: recognizer));
          // Note: if you use this path and recreate widgets frequently, retain/dispose recognizers properly.
        }
      } else if (m.group(4) != null) {
        spans.add(
          TextSpan(
            text: m.group(4),
            style: baseStyle.copyWith(fontWeight: FontWeight.w500),
          ),
        );
      } else if (m.group(5) != null) {
        spans.add(
          TextSpan(
            text: m.group(5),
            style: baseStyle.copyWith(decoration: TextDecoration.underline),
          ),
        );
      } else if (m.group(6) != null) {
        spans.add(
          TextSpan(
            text: m.group(6),
            style: baseStyle.copyWith(decoration: TextDecoration.lineThrough),
          ),
        );
      } else if (m.group(7) != null) {
        spans.add(
          TextSpan(
            text: m.group(7),
            style: baseStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        );
      } else if (m.group(8) != null) {
        spans.add(
          TextSpan(
            text: m.group(8),
            style: baseStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        );
      }

      lastEnd = m.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: baseStyle));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final children = _buildSpans(context);
    // Text.rich handles InlineSpan (TextSpan + WidgetSpan) mixtures
    return Text.rich(
      TextSpan(children: children),
      textAlign: textAlign,
    );
  }
}
