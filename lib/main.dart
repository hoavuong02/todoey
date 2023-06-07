import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/screens/tasks_screen.dart';

import 'database/db.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => TaskListProvider(),
    //   child: const MyApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListProvider>(
            create: (_) => TaskListProvider()),
        ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TasksScreen(),
    );
  }
}

class TaskListProvider extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Halo'),
    Task(name: 'Hello'),
  ];

  String title = '';
  List<Task> get getTasks => tasks;
  String get getTitle => title;
  void handleChechBox(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void getValueInput(String value) {
    title = value;
    notifyListeners();
  }

  void updateTaskList() {
    if (title != '') {
      tasks.add(Task(name: title));
      title = '';
      notifyListeners();
    }
  }

  void handleLongPress(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}
