import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TimerScreen(DateTime(2024, 8, 23, 2, 0))));
  }

}
      

class TimerScreen extends StatefulWidget {
  final DateTime initDate; 
  
  const TimerScreen(this.initDate,{super.key});
  
  @override
  State<StatefulWidget> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  late ValueNotifier<Duration> notifier;
  
  @override
  void initState() {
    notifier = ValueNotifier<Duration>(DateTime.now().difference(widget.initDate));
    
    Timer.periodic(const Duration(seconds: 1), (timer) => notifier.value += Duration(seconds: 1));
    super.initState();
  }
  
  int get days {
    return notifier.value.inDays;
  }
  
  int get hours {
    return notifier.value.inHours - (notifier.value.inDays * 24);
  }
  
  int get minutes {
    return notifier.value.inMinutes - (notifier.value.inHours * 60);
  }
  
  int get seconds {
    return notifier.value.inSeconds - (notifier.value.inMinutes * 60);
  }
  
  Widget build(BuildContext context) {
    return Center(
      child: ListenableBuilder(listenable: notifier, builder: (context, child) => Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min ,children: [
        Text('Days: ${days}'),
        Text('Hours: ${hours}'),
        Text('Min: ${minutes}'),
        Text('Sec: ${seconds}'),
        
      ]),),
    );
  }
}
