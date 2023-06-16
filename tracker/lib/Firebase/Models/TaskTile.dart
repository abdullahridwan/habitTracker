import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tracker/Firebase/Models/TaskModel.dart';
import 'package:tracker/Firebase/firebase_helper.dart';
import 'package:tracker/constants.dart';

import '../../components/rect_textformfield.dart';
import 'package:google_fonts/google_fonts.dart';

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
    currentTask.clear();
    widget.taskModel.updateTask();
    Navigator.pop(context, 'OK');
  }

  deleteTask() {
    widget.taskModel.deleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.black,
          // ),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                  Text(
                    widget.taskModel.item,
                    style: GoogleFonts.lato(),
                  ),
                ],
              ),
              GestureDetector(
                // onTap: () => showDialog<String>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     var cancelButton = TextButton(
                //       onPressed: () => Navigator.pop(context, 'Cancel'),
                //       child: const Text('Cancel'),
                //     );
                //     var okButton = TextButton(
                //       onPressed: updateTaskText,
                //       child: const Text('OK'),
                //     );
                //     var deleteButton = TextButton(
                //       onPressed: deleteTask,
                //       style:
                //           ElevatedButton.styleFrom(foregroundColor: Colors.red),
                //       child: const Text('Delete'),
                //     );
                //     return AlertDialog(
                //       title: const Text('Making Changes?'),
                //       content: RectTextFormField(
                //         controller: currentTask,
                //         isObscured: false,
                //         labelTextField: 'New Task Name',
                //         validator: (email) {},
                //       ),
                //       actions: <Widget>[
                //         deleteButton,
                //         cancelButton,
                //         okButton,
                //       ],
                //     );
                //   },
                // ),
                onTap: () => showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    var cancelButton = TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    );
                    var okButton = TextButton(
                      onPressed: updateTaskText,
                      child: const Text('OK'),
                    );
                    var deleteButton = TextButton(
                      onPressed: deleteTask,
                      style:
                          ElevatedButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Delete'),
                    );
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RectTextFormField(
                              controller: currentTask,
                              isObscured: false,
                              labelTextField: "Current Task Name",
                              validator: (email) {
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  deleteButton,
                                  cancelButton,
                                  okButton,
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),

                child: HeroIcon(
                  HeroIcons.ellipsisVertical,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
