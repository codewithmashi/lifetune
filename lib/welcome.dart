import 'package:flutter/material.dart';
import 'package:lifetune/common/animated_button.dart';
import 'package:lifetune/home.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/welcome.png"),
                fit: BoxFit.fill,
              ), // BoxDecorationImage
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                OffsetText(
                  text: 'Lifetune',
                  type: AnimationType.letter,
                  duration: const Duration(milliseconds: 500),
                  slideType: SlideAnimationType.alternateTB,
                  textStyle: TextStyle(
                    fontSize: 70,
                    fontFamily: 'PoetsenOne',
                  ),
                ),
                Text(
                  'Take charge of your health:\nall aspects, one app!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          Spacer(),
          AnimatedButton()
        ],
      ),
    );
  }
}
