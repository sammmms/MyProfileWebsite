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
    return SizedBox(
      height: maxExtent,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - value)),
            child: Center(child: child),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant MySliverDelegate oldDelegate) {
    return true;
  }
}
