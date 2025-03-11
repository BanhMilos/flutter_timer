import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/view/timer_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter timer",
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color.fromRGBO(72, 76, 126, 1)),
      ),
      home: const TimerPage(),
    );
  }
}
