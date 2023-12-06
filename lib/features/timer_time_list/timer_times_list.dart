import 'package:flutter/material.dart';

class TimerTimesList {
  final List<List<dynamic>> data;

  TimerTimesList(BuildContext context)
      : data = [
          ['prepare', 'prepare', 10],
          ['sets', 'sets', 5],
          ['work', 'work', 90],
          ['work', 'rest', 15],
          ['reset', 'reset', 15],
        ];
}

int calculateTotalTime(TimerTimesList timerTimesList) {
  num totalTime = 0;
  num nSets = 0;
  num currentSets = 0;

  for (var item in timerTimesList.data) {
    switch (item[0]) {
      case 'sets':
        nSets++;
        currentSets = item[2];
        break;
      case 'prepare':
        totalTime += item[2];
        break;
      case 'reset':
        if (nSets > 1) {
          totalTime += item[2] * (nSets - 1);
        }
        break;
      default:
        totalTime += item[2] * currentSets;
        break;
    }
  }
  return totalTime.toInt();
}
