import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final Color iconBackgroundColor;
  final int currentValue;
  final int maxValue;
  final Color progressColor;
  final bool isProgressCircle;
  final Widget contentChild;
  final VoidCallback? onTap;

  const StatusCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.iconBackgroundColor,
    this.currentValue = 0,
    this.contentChild = const SizedBox(),
    this.maxValue = 2,
    this.isProgressCircle = true,
    this.progressColor = Colors.transparent,
    this.onTap,
  });

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.95),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.95, end: 1.0),
        weight: 1.0,
      ),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }

  void _handleTap() {
    _bounceController.forward(from: 0.0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: TweenAnimationBuilder(
          tween: Tween<double>(
              begin: 0, end: widget.currentValue / widget.maxValue),
          duration: Duration(milliseconds: 1500),
          builder: (context, double value, child) {
            return Container(
              padding: EdgeInsets.all(12).copyWith(bottom: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: widget.iconBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(14),
                        child: widget.icon,
                      ),
                      SizedBox(width: 12),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    widget.subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0,
                      height: 1,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  if (widget.isProgressCircle)
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: CircularProgressIndicator(
                              value: value,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(widget.progressColor),
                              strokeWidth: 6,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Text(
                            "${(value * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.isProgressCircle == false) widget.contentChild,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
