import 'dart:math';
import 'package:flutter/material.dart';

class SleepAnalysisChart extends StatefulWidget {
  const SleepAnalysisChart({super.key});

  @override
  State<SleepAnalysisChart> createState() => _SleepAnalysisChartState();
}

class _SleepAnalysisChartState extends State<SleepAnalysisChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _heights;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _generateHeights();
    _controller.forward();
  }

  void _generateHeights() {
    _heights = List.generate(48, (index) {
      double baseHeight;
      // First 18 bars remain the same
      if (index < 18) {
        if (index < 2) {
          baseHeight = 25.0 + _random.nextDouble() * 8;
        } else if (index < 4) {
          baseHeight = 45.0 + _random.nextDouble() * 10;
        } else if (index < 8) {
          baseHeight = 28.0 + _random.nextDouble() * 8;
        } else if (index < 12) {
          baseHeight = 48.0 + _random.nextDouble() * 8;
        } else if (index < 14) {
          baseHeight = 25.0 + _random.nextDouble() * 10;
        } else if (index < 15) {
          baseHeight = 35.0 + _random.nextDouble() * 8;
        } else {
          baseHeight = 45.0 + _random.nextDouble() * 12;
        }
      }
      // New random patterns after index 18
      else if (index < 24) {
        baseHeight = 30.0 + _random.nextDouble() * 15;
      } else if (index < 28) {
        baseHeight = 45.0 + _random.nextDouble() * 8;
      } else if (index < 32) {
        baseHeight = 25.0 + _random.nextDouble() * 12;
      } else if (index < 38) {
        baseHeight = 40.0 + _random.nextDouble() * 10;
      } else if (index < 42) {
        baseHeight = 28.0 + _random.nextDouble() * 8;
      } else {
        baseHeight = 35.0 + _random.nextDouble() * 12;
      }
      return baseHeight;
    });
  }

  Color _getColor(int index) {
    if (index < 18) {
      // First 18 bars keep their original colors
      if (index < 2) return Color(0xFFAAD7FC);
      if (index < 4) return Color(0xFF5E6AA5);
      if (index < 8) return Color(0xFFAAD7FC);
      if (index < 12) return Color(0xFF5E6AA5);
      if (index < 14) return Color(0xFFAAD7FC);
      if (index < 15) return Color(0xFFFFE972);
      return Color(0xFF5E6AA5);
    }
    // New color patterns
    if (index < 24) return Color(0xFFAAD7FC);
    if (index < 28) return Color(0xFF5E6AA5);
    if (index < 32) return Color(0xFFAAD7FC);
    if (index < 38) return Color(0xFF5E6AA5);
    if (index < 42) return Color(0xFFAAD7FC);
    return Color(0xFF5E6AA5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(48, (index) {
                return Expanded(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.2),
                        decoration: BoxDecoration(
                          color: _getColor(index),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                        ),
                        height: _heights[index] * _controller.value,
                      );
                    },
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('11:55 PM',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('07:40 AM',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }


}
