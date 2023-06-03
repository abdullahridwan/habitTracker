import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../components/rect_textformfield.dart';

class Task extends StatefulWidget {
  Task({
    Key? key,
    required this.updateTasks,
    required this.deleteTasks,
    required this.item,
    required this.isDone,
    required this.increaseCount,
    required this.decreaseCount,
    required this.toggleIsDone,
  }) : super(key: key);

  dynamic updateTasks;
  dynamic deleteTasks;
  String item;
  bool isDone;
  dynamic increaseCount;
  dynamic decreaseCount;
  dynamic toggleIsDone;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController currentTask = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentTask.text = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: widget.isDone,
                    onChanged: (_) {
                      widget.toggleIsDone(widget.item);
                    },
                    // onChanged: (bool? value) {
                    //   setState(() {
                    //     widget.isDone = value!;
                    //   });
                    //   widget.increaseCount();
                    // },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.item),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Add another task!'),
                        content: RectTextFormField(
                          controller: currentTask,
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
                              widget.updateTasks(
                                  widget.item, widget.isDone, currentTask.text),
                              Navigator.pop(context, 'OK'),
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: HeroIcon(
                      HeroIcons.pencil,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => {widget.deleteTasks(widget.item)},
                    child: HeroIcon(
                      HeroIcons.xCircle,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
