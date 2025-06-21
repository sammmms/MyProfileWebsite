import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:website/components/timeline/my_timeline.dart';

class MyTimelineChild extends StatelessWidget {
  final TimelineItem item;
  const MyTimelineChild({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = MediaQuery.of(context).size.width < 720;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2,
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSmallScreen)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    DateFormat('dd MMM yyyy').format(item.date),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              item.content,
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
