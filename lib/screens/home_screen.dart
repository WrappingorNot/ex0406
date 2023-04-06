import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  static const twentyFiveMInutes = 1500;
  int totalSecond = twentyFiveMInutes;
  bool isRunnung = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSecond == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunnung = false;
        totalSecond = twentyFiveMInutes;
        timer.cancel();
      });
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunnung = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunnung = false;
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      totalSecond = twentyFiveMInutes;
      isRunnung = false;
    });
  }

  String fotmat(int seconds) {
    var duration = Duration(seconds: seconds);

    String outstring = duration.toString().split(".").first.substring(2, 7);
    return outstring;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              fotmat(totalSecond),
              style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
          flex: 3, // 공간 차지 비율
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunnung ? onPausePressed : onStartPressed,
                    icon: Icon(isRunnung
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline)),
                IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: onStopPressed,
                    icon: const Icon(Icons.stop_circle_outlined)),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .color),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
