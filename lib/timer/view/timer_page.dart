import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/timer/bloc/timer.dart';
import 'package:flutter_timer/ticker.dart';
import 'timer_view.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}