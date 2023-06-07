import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:tracker/Firebase/Models/TaskModel.dart';
import 'package:tracker/Firebase/Models/TaskTile.dart';

import '../Firebase/firebase_helper.dart';
import '../components/rect_textformfield.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemsDone = 0;
  TextEditingController newTask = TextEditingController();
  late Map<DateTime, int>? data;

  Stream<List<TaskModel>> tasks = taskModelHelper.getAll();

  increaseCount() {
    setState(() {
      itemsDone++;
    });
  }

  decreaseCount() {
    setState(() {
      itemsDone--;
    });
  }

  addNewTask() {
    var newTask = TaskModel(item: this.newTask.text, isDone: false);
    newTask.addTask();
    setState(() {
      this.newTask.clear();
    });
  }

  // addNewTaskToTasks(TaskModel t) {
  //   setState(() {
  //     tasks.add(t);
  //   });
  // }

  // deleteTask(String itemToUpdate) {
  //   setState(() {
  //     tasks.remove(itemToUpdate);
  //   });
  // }

  // updateTask(TaskModel t, String newTaskText) {
  //   setState(() {
  //     t.item = newTaskText;
  //     tasks[tasks.indexWhere((element) => element.id == t.id)] = t;
  //   });
  // }

  // toggleisDone(String taskName) {
  //   print("Task Name: ${taskName}");
  //   print("Before Value: ${this.tasks[taskName]}");
  //   bool v = this.tasks[taskName]!;
  //   setState(() {
  //     this.tasks[taskName] = !v;
  //   });
  //   print("After Value: ${this.tasks[taskName]}");
  //   if (v) {
  //     this.decreaseCount();
  //   } else {
  //     this.increaseCount();
  //   }
  //   print(data);
  // }

  @override
  void initState() {
    super.initState();

    data = {
      DateTime(2023, 6, 9): 5,
      DateTime(2023, 6, 13): 6,
    };
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    data![DateTime(now.year, now.month, now.day)] = itemsDone;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: HeatMapCalendar(
                    showColorTip: false,
                    defaultColor: Colors.white,
                    flexible: true,
                    colorMode: ColorMode.opacity,
                    datasets: {
                      DateTime(2023, 6, 9): 5,
                      DateTime(2023, 6, 13): 6,
                      DateTime(now.year, now.month, now.day): itemsDone,
                    },
                    colorsets: const {
                      1: Colors.green,
                    },
                    onClick: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.toString())));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: tasks,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Column(children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('Stack trace: ${snapshot.stackTrace}'),
                        ),
                      ]);
                    } else {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Column(children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue,
                              size: 60,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Select a lot'),
                            ),
                          ]);
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          var listOfItems = snapshot.data!;
                          return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return TaskTile(
                                taskModel: listOfItems.elementAt(index),
                              );
                            },
                          );
                        case ConnectionState.done:
                          return Column(
                            children: [Text("Done")],
                          );
                      }
                    }
                  },
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Add another task!'),
                    content: RectTextFormField(
                      controller: newTask,
                      isObscured: false,
                      labelTextField: 'New Task Name',
                      validator: (email) {},
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => {
                          addNewTask(),
                          Navigator.pop(context, 'OK'),
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
