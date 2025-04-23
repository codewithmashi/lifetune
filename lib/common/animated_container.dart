import 'package:flutter/material.dart';

class SlideContainer extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final EdgeInsets? margin;
  final Offset? beginOffset;

  const SlideContainer({
    super.key,
    required this.child,
    this.duration,
    this.margin,
    this.beginOffset,
  });

  @override
  State<SlideContainer> createState() => _SlideContainerState();
}

class _SlideContainerState extends State<SlideContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset ?? const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: widget.margin ?? EdgeInsets.zero,
          child: widget.child,
        ),
      ),
    );
  }
}
