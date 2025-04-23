import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifetune/common/animated_container.dart';
import 'package:lifetune/common/animated_line_graph.dart';
import 'package:lifetune/common/animated_status_card.dart';
import 'package:lifetune/common/animated_text.dart';
import 'package:lifetune/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideContainer(
                beginOffset: Offset(1, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 40),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image:
                                NetworkImage("https://i.pravatar.cc/150?img=2"),
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
              SizedBox(height: 24),
              EmotionWidget(
                text: 'How do you feel today?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              SlideContainer(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 14, 8, 8),
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Color(0xffFFF7DF),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Insight",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.close, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "It looks like you're stressed yesterday.\nIs everything ok?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 160,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Text(
                            "Let's check in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              SlideContainer(
                margin: EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Today's status",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatusCard(
                            title: "Sleep",
                            subTitle: "420 of 540 cals\nconsumed",
                            icon:
                                FaIcon(FluentIcons.sleep_24_regular, size: 20),
                            iconBackgroundColor: Color(0xffE0D5FF),
                            currentValue: 420,
                            maxValue: 540,
                            progressColor: Colors.purple,
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: StatusCard(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => Detail(),
                                settings: RouteSettings(
                                  arguments: {
                                    "title": "Water Level",
                                    "subTitle": "You drank 4 out of 6\nglasses of water",
                                    "currentValue": "1185",
                                    "maxValue": "2400",
                                  },
                                ),
                              ),
                            ),
                            title: "Water",
                            subTitle: "You drank 4 out of 6\nglasses of water",
                            icon: FaIcon(FontAwesomeIcons.glassWater, size: 20),
                            iconBackgroundColor: Color(0xffD5FFE0),
                            currentValue: 1185,
                            maxValue: 2400,
                            progressColor: Colors.green,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    StatusCard(
                      title: 'Overnight Sleep analysis',
                      subTitle: 'The total duration of sleep is 7h 45m',
                      icon: Icon(FluentIcons.sleep_20_regular),
                      isProgressCircle: false,
                      iconBackgroundColor: Color(0xffE0D5FF),
                      contentChild: SleepAnalysisChart(),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: StatusCard(
                            title: "Mind",
                            subTitle: "You have completed\n3 out of 4 tasks",
                            icon:
                                Icon(Icons.self_improvement_outlined, size: 20),
                            iconBackgroundColor:
                                Color.fromARGB(255, 248, 246, 179),
                            currentValue: 420,
                            maxValue: 540,
                            progressColor: Colors.yellow,
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: StatusCard(
                            title: "Activity",
                            subTitle: "Total training time\n1h 15m",
                            icon: Icon(
                                FluentIcons.broad_activity_feed_20_regular,
                                size: 20),
                            iconBackgroundColor:
                                const Color.fromARGB(107, 255, 86, 34),
                            currentValue: 1185,
                            maxValue: 2400,
                            progressColor: Colors.deepOrange,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
