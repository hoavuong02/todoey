import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/database/db.dart';
import 'package:todoey/widgets/bottom_sheet.dart';
import 'package:todoey/widgets/task_list.dart';

import '../constants.dart';
import '../main.dart';
import '../models/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    //lấy mảng tasks từ main (nút gốc)
    final tasks = Provider.of<DatabaseProvider>(context).getTasks();
    // final database = Provider.of<DatabaseProvider>(context);
    // database.dropTable();
    // return Container();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> items = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            floatingActionButton: SizedBox(
              width: 60,
              height: 60,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddTaskScreen(),
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.list,
                                color: Colors.lightBlueAccent,
                                size: 80,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              'Todoey',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 65,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${items.length} tasks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(40),
                      decoration: kListViewDecaration,
                      child: TaskList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
