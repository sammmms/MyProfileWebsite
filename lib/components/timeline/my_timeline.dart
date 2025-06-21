import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:website/components/timeline/my_timeline_child.dart';

class TimelineItem {
  final HeroIcons icon;
  final DateTime date;
  final Widget content;

  TimelineItem(this.icon, {required this.date, required this.content});
}

class MyTimeline extends StatelessWidget {
  final List<TimelineItem> items;

  const MyTimeline({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 720;
    if (isSmall) {
      return _buildSmallTimeline();
    } else {
      return _buildLargeTimeline();
    }
  }

  Widget _buildSmallTimeline() {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 2,
                  height: 25,
                  color: Colors.grey,
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: HeroIcon(
                    item.icon,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 2,
                  height: 25,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(child: MyTimelineChild(item: item)),
          ],
        );
      },
    );
  }

  Widget _buildLargeTimeline() {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = items[index];

        bool isEven = index % 2 == 0;
        return SizedBox(
          height: 150,
          child: Row(
            children: [
              if (!isEven)
                Expanded(
                  child: MyTimelineChild(item: item),
                )
              else
                const Spacer(),
              LayoutBuilder(builder: (context, constraints) {
                double lineHeight = constraints.maxHeight;
                return Column(
                  children: [
                    Container(
                      width: 2,
                      height: lineHeight / 2 - 6,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: HeroIcon(
                        item.icon,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: lineHeight / 2 - 6,
                      color: Colors.grey,
                    ),
                  ],
                );
              }),
              const SizedBox(width: 16),
              if (isEven)
                Expanded(
                  child: MyTimelineChild(item: item),
                )
              else
                const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
