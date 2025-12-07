import 'dart:math';

import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Function(bool isStick)? onStick;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.onStick,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  bool isTabBarSticky = false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Detect if the tab bar has become sticky (shrinkOffset > 0)
    final bool isSticky = (shrinkOffset >= 0);

    // Update only if the state has changed (to avoid unnecessary calls)
    if (isTabBarSticky != isSticky) {
      isTabBarSticky = isSticky;

      if (onStick != null) {
        onStick!(isTabBarSticky);
      }
    }

    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) => maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
}
