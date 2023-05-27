// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:webview_app/View/WebViewPage.dart';
import 'package:webview_app/View/defualt_screen.dart';
import 'package:webview_app/Widgets/CustomAnimation.dart';
import 'package:webview_app/constants/color.dart';
import 'package:webview_app/constants/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
    // incrementTapCount();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

void navigationPage() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const DefaultScreen(),
      ),
    );
  }

  int _tapCount = 0;

  void incrementTapCount() {
    setState(() {
      _tapCount++;
    });

    if (_tapCount == 3) {
      showDialog<void>(
        context: context,
        builder: (context) => ScreenLock(
          correctString: '1245',
          secretsBuilder: (
            context,
            config,
            length,
            input,
            verifyStream,
          ) =>
              SecretsWithCustomAnimation(
            verifyStream: verifyStream,
            config: config,
            input: input,
            length: length,
          ),
          onUnlocked: () {
            Navigator.pop(context);
            Get.to(() => const WebViewPage());
          },
        ),
      );
      _tapCount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: Container(
          width: AppConfig(context).width,
          color: const Color(0xFFE5E5E5).withOpacity(0.10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: AppConfig(context).height / 9,
              ),
              GestureDetector(
                onTap: () => incrementTapCount(),
                child: Center(
                  child: Container(
                    height: AppConfig(context).height / 2,
                    width: AppConfig(context).height / 2,
                    child: Lottie.asset(
                      "assets/images/pic1.json",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppConfig(context).height / 10,
                child: const SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    spinnerMode: true,
                    size: 40,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
