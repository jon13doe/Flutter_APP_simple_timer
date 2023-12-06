import 'package:flutter/material.dart';
import 'package:simple_interval_timer/features/home_window/home_window.dart';

class SimpleTimerApp extends StatefulWidget {
  const SimpleTimerApp({super.key});

  @override
  State<SimpleTimerApp> createState() => _SimpleTimerAppState();
}

class _SimpleTimerAppState extends State<SimpleTimerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //Switch of "Debug" corner
        home: const HomeWindow(),
      );
  }
}


// class SimpleTimerApp extends StatelessWidget {
//   const SimpleTimerApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }