import 'package:flutter/material.dart';

class AnimatedCalendar extends StatefulWidget {
  final Function(int)? onDaySelected;
  final int initialSelectedDay;
  final Color progressColor;

  const AnimatedCalendar({
    Key? key,
    this.onDaySelected,
    this.initialSelectedDay = 23,
    this.progressColor = Colors.blue,
  }) : super(key: key);

  @override
  State<AnimatedCalendar> createState() => _AnimatedCalendarState();
}

class _AnimatedCalendarState extends State<AnimatedCalendar>
    with SingleTickerProviderStateMixin {
  late int selectedDay;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double value = 0.75; // Default progress value (75%)

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialSelectedDay;

    // Setup animation controller for loading circle
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDayColumn('Su', 19),
            _buildDayColumn('Mo', 20),
            _buildDayColumn('Tu', 21),
            _buildDayColumn('We', 22),
            _buildDayColumn('Th', 23),
            _buildDayColumn('Fr', 24),
            _buildDayColumn('Sa', 25),
          ],
        ),
      ],
    );
  }

  Widget _buildDayColumn(String day, int dayNumber) {
    bool isSelected = selectedDay == dayNumber;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = dayNumber;
        });
        if (widget.onDaySelected != null) {
          widget.onDaySelected!(dayNumber);
        }
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: isSelected ? 20 : 0,
                  end: isSelected ? 40 : 0,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                builder: (context, double size, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: size,
                    height: 74,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: isSelected ? Colors.black : Colors.transparent,
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 4),
                child: Column(
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Color(0xffF7ECE0) : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!isSelected)
                          SizedBox(
                            width: 34,
                            height: 34,
                            child: CircularProgressIndicator(
                              value: value,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.progressColor,
                              ),
                              strokeWidth: 4,
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF7ECE0),
                          ),
                          child: Center(
                            child: Text(
                              dayNumber.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
