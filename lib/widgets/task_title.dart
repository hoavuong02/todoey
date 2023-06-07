import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoey/models/task.dart';

class TaskTitle extends StatelessWidget {
  final int isChecked;
  final String taskTitle;
  final Function() onCheckBoxChange;
  final Function onLongPress;
  TaskTitle(
      {required this.taskTitle,
      this.isChecked = 0,
      required this.onCheckBoxChange,
      required this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        onLongPress();
      },
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked == 1 ? TextDecoration.lineThrough : null),
      ),
      trailing: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked == 1 ? true : false,
          onChanged: (value) {
            onCheckBoxChange();
          },
        ),
      ),
    );
  }
}
