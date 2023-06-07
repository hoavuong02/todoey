import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/database/db.dart';

import '../constants.dart';
import '../main.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<DatabaseProvider>(context);
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        decoration: kListViewDecaration,
        child: Column(
          children: [
            const Text(
              'Add Task',
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 40),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              autofocus: true,
              onChanged: ((value) {
                tasks.getValueInput(value);
              }),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                onPressed: (() {
                  tasks.insertTask();
                  Navigator.pop(context);
                }),
                child: Text('Add'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
