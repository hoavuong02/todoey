import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/widgets/task_title.dart';

import '../database/db.dart';
import '../main.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //lấy mảng tasks từ main (nút gốc)
    final db = Provider.of<DatabaseProvider>(context);
    final tasks = Provider.of<DatabaseProvider>(context).getTasks();
    // return Container();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> items = snapshot.data!;
          return ListView.builder(
            itemBuilder: ((context, index) => TaskTitle(
                  taskTitle: items[index]['name'],
                  isChecked: items[index]['isDone'],
                  onCheckBoxChange: () {
                    db.handleChechBox(items[index]['id']);
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm'),
                          content: Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // User clicked Cancel, dismiss dialog
                                Navigator.of(context).pop(false);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // User clicked Delete, confirm and dismiss dialog
                                Navigator.of(context).pop(true);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    ).then((confirmed) {
                      if (confirmed == true) {
                        // User confirmed, perform delete operation
                        db.handleLongpress(items[index]['id']);
                      }
                    });
                  },
                )),
            itemCount: items.length,
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
