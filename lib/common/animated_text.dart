import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lifetune/common/animated_container.dart';

class EmotionWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const EmotionWidget({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<EmotionWidget> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<EmotionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Changed to start from bottom (0.0, 1.0)
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.text,
              style: widget.style,
            ),
          ),
        ),
        SizedBox(height: 14),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            padding: EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              return AnimatedEmoji(
                delay: Duration(milliseconds: 200 * index),
                emojis: [
                  FluentIcons.emoji_angry_20_regular,
                  FluentIcons.emoji_sad_20_regular,
                  FluentIcons.emoji_meh_20_regular,
                  FluentIcons.emoji_20_regular,
                  FluentIcons.emoji_laugh_20_regular,
                ][index],
                text: [
                  'Terrible',
                  'Bad',
                  'Neutral',
                  'Good',
                  'Awesome'
                ][index],
                iconColor: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.green,
                ][index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnimatedEmoji extends StatefulWidget {
  final Duration delay;
  final Color iconColor;
  final IconData emojis;
  final String text;

  const AnimatedEmoji({
    super.key,
    required this.delay,
    required this.emojis,
    required this.text,
    required this.iconColor,
  });

  @override
  State<AnimatedEmoji> createState() => _AnimatedEmojiState();
}

class _AnimatedEmojiState extends State<AnimatedEmoji>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    // Start emoji animation with delay
    Future.delayed(widget.delay, () {
      _controller.forward();
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(
              widget.emojis,
              size: 28,
              color: widget.iconColor,
            ),
          ),
        ),
        SizedBox(height: 8),
        SlideContainer(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 14,
              height: 0,
              letterSpacing: 0,
              fontWeight: FontWeight.w500
            ),
          ),
        )
      ],
    );
  }
}
