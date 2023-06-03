import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:tracker/screens/task.dart';

import '../components/rect_textformfield.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemsDone = 0;
  // late ValueNotifier<int> countNotifier;
  TextEditingController newTask = TextEditingController();
  late Map<DateTime, int>? data;

  Map<String, bool> tasks = {
    "Your first task!": false,
  };

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

  addNewTaskToTasks() {
    setState(() {
      tasks[newTask.text] = false;
      newTask.text = "";
    });
  }

  deleteTask(String itemToUpdate) {
    setState(() {
      tasks.remove(itemToUpdate);
    });
  }

  updateTask(String itemToUpdate, bool isDone, String newTaskText) {
    setState(() {
      tasks.remove(itemToUpdate);
      tasks[newTaskText] = isDone;
    });
  }

  toggleisDone(String taskName) {
    print("Task Name: ${taskName}");
    print("Before Value: ${this.tasks[taskName]}");
    bool v = this.tasks[taskName]!;
    setState(() {
      this.tasks[taskName] = !v;
    });
    print("After Value: ${this.tasks[taskName]}");
    if (v) {
      this.decreaseCount();
    } else {
      this.increaseCount();
    }
    print(data);
  }

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
              HeatMapCalendar(
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks.keys.elementAt(index);
                    final notifier = tasks[task]!;
                    return Task(
                      increaseCount: increaseCount,
                      decreaseCount: decreaseCount,
                      updateTasks: updateTask,
                      deleteTasks: deleteTask,
                      item: tasks.keys.elementAt(index),
                      isDone: tasks.values.elementAt(index),
                      toggleIsDone: toggleisDone,
                    );
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
                        onPressed: () =>
                            {addNewTaskToTasks(), Navigator.pop(context, 'OK')},
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
