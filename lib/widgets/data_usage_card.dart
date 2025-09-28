import 'package:flutter/material.dart';

class DataUsageCard extends StatelessWidget {
  final String title;
  final double usedData;
  final double totalData;
  final Color color;

  const DataUsageCard({
    super.key,
    required this.title,
    required this.usedData,
    required this.totalData,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalData > 0 ? (usedData / totalData) * 100 : 0;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              color: percentage > 80 ? Colors.red : color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${usedData.toStringAsFixed(2)} GB',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${totalData.toStringAsFixed(2)} GB',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${percentage.toStringAsFixed(1)}% utilisé',
              style: TextStyle(
                color: percentage > 80 ? Colors.red : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}