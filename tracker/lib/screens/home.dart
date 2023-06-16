import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/Firebase/Models/TaskModel.dart';
import 'package:tracker/Firebase/Models/TaskTile.dart';
import 'package:tracker/components/rect_button.dart';
import 'package:tracker/constants.dart';
import '../components/rect_textformfield.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemsDone = 0;
  int redThird = 0;
  int orangeThird = 1;
  int greenThird = 2;
  TextEditingController newTask = TextEditingController();
  late Map<DateTime, int>? data;
  String firstName = '';
  String lastName = '';
  String email = '';

  Stream<List<TaskModel>> tasks = taskModelHelper.getAll();

  updateCount(List<TaskModel> taskList) {
    setState(() {
      itemsDone =
          taskList.where((element) => element.isDone == true).toList().length;
    });
  }

  addNewTask() {
    var newTask = TaskModel(item: this.newTask.text, isDone: false);
    newTask.addTask();
    setState(() {
      this.newTask.clear();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: Color(0xFFf3f3f7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                ),
                CustomHeatmap(
                    now: now,
                    itemsDone: itemsDone,
                    redThird: redThird,
                    orangeThird: orangeThird,
                    greenThird: greenThird),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Tasks For Today",
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
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
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                updateCount(listOfItems);
                              },
                            );
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
                  backgroundColor: Colors.red,
                  onPressed: () {
                    TaskModalSheet(context, newTask, "Add a New Task!", () {
                      addNewTask();
                      Navigator.pop(context, 'OK');
                    });
                  },
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
                        validator: (email) {
                          return null;
                        },
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
      ),
    );
  }

  Future<void> TaskModalSheet(
      BuildContext context,
      TextEditingController controllerUsed,
      String labelTextField,
      void Function()? onPressedFxn) {
    var parser = EmojiParser();

    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RectTextFormField(
                  controller: controllerUsed,
                  isObscured: false,
                  labelTextField: parser.emojify(labelTextField),
                  validator: (email) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressedFxn,
                    child: Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomHeatmap extends StatelessWidget {
  const CustomHeatmap({
    Key? key,
    required this.now,
    required this.itemsDone,
    required this.redThird,
    required this.orangeThird,
    required this.greenThird,
  }) : super(key: key);

  final DateTime now;
  final int itemsDone;
  final int redThird;
  final int orangeThird;
  final int greenThird;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //width: MediaQuery.of(context).size.width * 0.7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeatMapCalendar(
                  monthFontSize: 20,
                  showColorTip: false,
                  defaultColor: Colors.grey.shade400,
                  flexible: true,
                  textColor: Colors.white,
                  colorMode: ColorMode.color,
                  datasets: {
                    DateTime(1999, 6, 9): 5,
                    DateTime(1999, 6, 9): 5,
                    DateTime(now.year, now.month, now.day): itemsDone,
                  },
                  colorsets: {
                    redThird: Colors.red.shade400,
                    orangeThird: Colors.orange.shade400,
                    greenThird: Colors.green.shade400
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.toString())));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
