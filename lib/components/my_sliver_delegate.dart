import 'package:flutter/material.dart';

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  @override
  final double minExtent;
  @override
  final double maxExtent;

  MySliverDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant MySliverDelegate oldDelegate) {
    return true;
  }
}
