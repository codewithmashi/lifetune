import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AnimatedAppbar extends StatefulWidget {
  const AnimatedAppbar({super.key});

  @override
  State<AnimatedAppbar> createState() => _AnimatedAppbarState();
}

class _AnimatedAppbarState extends State<AnimatedAppbar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.4, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    // Start the animation when the widget is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      flexibleSpace: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage("https://i.pravatar.cc/150?img=2"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back,",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Andrew Hawkins",
                    style: TextStyle(
                      fontSize: 18,
                      height: 0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(FluentIcons.alert_12_regular),
            ],
          ),
        ),
      ),
    );
  }
}