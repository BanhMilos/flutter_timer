import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/timer/bloc/timer_bloc.dart';
import 'package:flutter_timer/timer/view/background.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Flutter timer")),
        body: const Stack(
          children: [
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TimerText(),
                Actions(),
              ],
            )
          ],
        ));
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      "$minutesStr : $secondsStr",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                    child: const Icon(Icons.start),
                  ),
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPaused()),
                    child: const Icon(Icons.pause),
                  ),
                  const SizedBox(width: 10,),
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                    child: const Icon(Icons.replay),
                  ),
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResumed()),
                    child: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: 10,),
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                    child: const Icon(Icons.replay),
                  ),
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                    child: const Icon(Icons.replay),
                  ),
                ]
            },
          const Spacer()
          ],
        );
      },
    );
  }
}
