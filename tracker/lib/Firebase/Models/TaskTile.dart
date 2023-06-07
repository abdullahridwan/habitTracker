import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tracker/Firebase/Models/TaskModel.dart';
import 'package:tracker/Firebase/firebase_helper.dart';

import '../../components/rect_textformfield.dart';

class TaskTile extends StatefulWidget {
  TaskTile({
    Key? key,
    required this.taskModel,
  }) : super(key: key);

  TaskModel taskModel;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  TextEditingController currentTask = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentTask.text = widget.taskModel.item;
  }

  updateCheckBox(bool? value) {
    setState(() {
      widget.taskModel.isDone = value!;
    });
    widget.taskModel.updateTask();
  }

  updateTaskText() {
    setState(() {
      widget.taskModel.item = currentTask.text;
    });
    widget.taskModel.updateTask();
    Navigator.pop(context, 'OK');
  }

  deleteTask() {
    widget.taskModel.deleteTask();
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
                    value: widget.taskModel.isDone,
                    onChanged: updateCheckBox,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.taskModel.item),
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
                            onPressed: updateTaskText,
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
                    onTap: deleteTask,
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
