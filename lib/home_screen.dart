import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanger/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              child: Text("Start the Flutter background service"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  simpleTaskKey,
                  simpleTaskKey,
                  inputData: <String, dynamic>{
                    'int': 1,
                    'bool': true,
                    'double': 1.0,
                    'string': 'string',
                    'array': [1, 2, 3],
                  },
                );
              },
            ),

            ElevatedButton(
              child: Text("Register rescheduled Task"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  rescheduledTaskKey,
                  rescheduledTaskKey,
                  inputData: <String, dynamic>{
                    'key': Random().nextInt(64000),
                  },
                );
              },
            ),
            ElevatedButton(
              child: Text("Register failed Task"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  failedTaskKey,
                  failedTaskKey,
                );
              },
            ),
            //This task runs once
            //This wait at least 10 seconds before running
            ElevatedButton(
                child: Text("Register Delayed OneOff Task"),
                onPressed: () {
                  Workmanager().registerOneOffTask(
                    simpleDelayedTask,
                    simpleDelayedTask,
                    initialDelay: Duration(seconds: 10),
                  );
                }),
            SizedBox(height: 8),
            //This task runs periodically
            //It will wait at least 10 seconds before its first launch
            //Since we have not provided a frequency it will be the default 15 minutes
            ElevatedButton(
                child: Text("Register 1 hour Periodic Task (Android)"),
                onPressed: () {
                  Workmanager().registerPeriodicTask(
                    simplePeriodicTask,
                    simplePeriodic1HourTask,
                    frequency: Duration(hours: 1),
                  );
                }),
            SizedBox(height: 16),
            Text(
              "Task cancellation",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              child: Text("Cancel All"),
              onPressed: () async {
                await Workmanager().cancelAll();
                print('Cancel all tasks completed');
              },
            ),
          ],
        ),
      ),
      
    );
  }
}
