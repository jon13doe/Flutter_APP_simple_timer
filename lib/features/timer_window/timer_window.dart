import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_interval_timer/features/timer_time_list/index.dart';
import 'dynm_icon_button.dart';

class TimerWindow extends StatefulWidget {
  final TimerTimesList timerTimesList;

  const TimerWindow({Key? key, required this.timerTimesList}) : super(key: key);

  @override
  State<TimerWindow> createState() => _TimerWindowState();
}

class _TimerWindowState extends State<TimerWindow> {
  bool menuVisiability = false;
  bool resetStopButtonsVisiability = false;
  bool timerVisiability = true;

  bool stopTimer = false;

  int noticeType = 0;
  int pauseStartIndex = 0;
  int visibilityTime = 3;

  Timer? visibilityTimer;
  Timer? currentTimer;

  late TimerTimesList _timerTimesList;
  int currentIndex = 0;
  int nSets = 0;
  late int currentSetStartIndex;
  late int secondsLeft;
  late String descriptionText;

  bool colorTest = false;

  @override
  void initState() {
    super.initState();
    _timerTimesList = widget.timerTimesList;
    secondsLeft = _timerTimesList.data[1][2];
    descriptionText = _timerTimesList.data[1][1];
    startTimer();
  }

  void startTimer() {
    switch (_timerTimesList.data[currentIndex][0]) {
      case 'sets':
        if (nSets == 0) {
          nSets = _timerTimesList.data[currentIndex][2];
          currentIndex++;
          currentSetStartIndex = currentIndex;
        } else {
          currentIndex = currentSetStartIndex;
          setState(() {
            nSets--;
          });
        }
        startTimer();
        break;
      case 'reset':
        setState(() {
          nSets--;
        });
        if (nSets > 0) {
          currentIndex = currentSetStartIndex;
          startTimer();
        } else {
          setState(() {
            timerVisiability = false;
            menuVisiability = false;
            resetStopButtonsVisiability = true;
          });
        }
        break;
      default:
        setState(() {
          descriptionText = _timerTimesList.data[currentIndex][1];
          secondsLeft = _timerTimesList.data[currentIndex][2];
        });
        clockTimer();
        break;
    }
  }

  void clockTimer() {
    currentTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          colorTest = true;
          secondsLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          currentIndex++;
          startTimer();
        });
      }
    });
  }

  void menuTimer() {
    visibilityTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          menuVisiability = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        visibilityTimer?.cancel();
        currentTimer?.cancel();
        return true;
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            if (timerVisiability == true && menuVisiability == false) {
              setState(() {
                menuVisiability = true;
              });
              menuTimer();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: pauseStartIndex == 1 ? Colors.grey : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: timerVisiability,
                    child: Column(
                      children: [
                        Text(
                          nSets > 0 ? nSets.toString() : '',
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (secondsLeft ~/ 60).toString().padLeft(2, '0'),
                              style: const TextStyle(fontSize: 144),
                            ),
                            const Column(
                              children: [
                                Text(
                                  ':',
                                  style: TextStyle(fontSize: 128),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                            Text(
                              (secondsLeft % 60).toString().padLeft(2, '0'),
                              style: const TextStyle(fontSize: 144),
                            ),
                          ],
                        ),
                        Text(
                          descriptionText.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: resetStopButtonsVisiability,
                  child: Column(
                    children: [
                      Text(
                        'Finish'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            icon: Icon(Icons.stop),
                            iconSize: 80,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                currentIndex = 0;
                                startTimer();
                                resetStopButtonsVisiability = false;
                                timerVisiability = true;
                              });
                            },
                            icon: const Icon(Icons.refresh),
                            iconSize: 64,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: menuVisiability,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            visibilityTimer?.cancel();
                            currentTimer?.cancel();
                            Navigator.of(context).pop();
                          });
                        },
                        icon: Icon(Icons.stop),
                        iconSize: 80,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      DynamicIconButton(
                        iconsList: const [
                          Icons.pause,
                          Icons.play_arrow,
                        ],
                        iconSize: 64,
                        onStateChange: (index) {
                          setState(() {
                            switch (index) {
                              case 0:
                                pauseStartIndex = index;
                                menuVisiability = false;
                                startTimer();
                                break;
                              case 1:
                                pauseStartIndex = index;
                                visibilityTimer?.cancel();
                                currentTimer?.cancel();
                                break;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
