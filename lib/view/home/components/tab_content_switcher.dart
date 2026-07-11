import 'package:flutter/material.dart';

class TabContentSwitcher extends StatefulWidget {
  final TabController controller;
  final Widget about;
  final Widget gallery;
  final Widget review;

  const TabContentSwitcher({
    required this.controller,
    required this.about,
    required this.gallery,
    required this.review,
  });

  @override
  State<TabContentSwitcher> createState() => _TabContentSwitcherState();
}

class _TabContentSwitcherState extends State<TabContentSwitcher> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.index;
    widget.controller.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(covariant TabContentSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleTabChange);
      widget.controller.addListener(_handleTabChange);
      _currentIndex = widget.controller.index;
    }
  }

  void _handleTabChange() {
    if (!mounted) return;
    final newIndex = widget.controller.index;
    if (newIndex != _currentIndex) setState(() => _currentIndex = newIndex);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return widget.about;
      case 1:
        return widget.gallery;
      case 2:
        return widget.review;
      default:
        return widget.about;
    }
  }
}
