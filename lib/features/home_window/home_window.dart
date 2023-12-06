import 'package:flutter/material.dart';

import 'package:simple_interval_timer/features/timer_window/timer_window.dart';

import 'package:simple_interval_timer/features/home_window/cust_one_num_row/index.dart';
import 'package:simple_interval_timer/features/home_window/cust_two_nums_row/index.dart';
import 'package:simple_interval_timer/features/timer_time_list/index.dart';

class HomeWindow extends StatefulWidget {
  const HomeWindow({super.key});

  @override
  State<HomeWindow> createState() => _HomeWindowState();
}

class _HomeWindowState extends State<HomeWindow> {
  late TimerTimesList _timerTimesList;
  late int _totalTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timerTimesList = TimerTimesList(context);
    _totalTime = calculateTotalTime(_timerTimesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sets',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  CustomOneNumRow(
                    initValue: _timerTimesList.data[1][2],
                    maxValue: 99,
                    onChange: (newValue) {
                      setState(() {
                        _timerTimesList.data[1][2] = newValue;
                        _totalTime = calculateTotalTime(_timerTimesList);
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Work',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  CustomTwoNumsRow(
                    initValue: _timerTimesList.data[2][2],
                    maxValueFirst: 99,
                    maxValueSecond: 60,
                    onChange: (newValue) {
                      setState(() {
                        _timerTimesList.data[2][2] = newValue;
                        _totalTime = calculateTotalTime(_timerTimesList);
                      });
                    },
                  ),
                  const Text(
                    'Rest',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  CustomTwoNumsRow(
                    initValue: _timerTimesList.data[3][2],
                    maxValueFirst: 99,
                    maxValueSecond: 60,
                    onChange: (newValue) {
                      setState(() {
                        _timerTimesList.data[3][2] = newValue;
                        _totalTime = calculateTotalTime(_timerTimesList);
                      });
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Total time ${(_totalTime ~/ 60).toString().padLeft(2, '0')}:${(_totalTime % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TimerWindow(
                            timerTimesList: _timerTimesList,
                          );
                        },
                      );
                    },
                    child: const SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 64,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w500,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
