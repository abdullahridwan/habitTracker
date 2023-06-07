import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/Firebase/Models/TaskTile.dart';
import 'package:tracker/Firebase/config.dart';
import 'package:uuid/uuid.dart';

import '../firebase_helper.dart';

class TaskModel {
  String id;
  String userId;
  String item;
  bool isDone;

  TaskModel({required this.item, required this.isDone})
      : id = Uuid().v4(),
        userId = FirebaseAuth.instance.currentUser!.uid;
  TaskModel.previous(
      {required this.id,
      required this.userId,
      required this.item,
      required this.isDone});

  addTask() {
    return taskModelHelper.add(this);
  }

  getTask() {
    taskModelHelper.get(this.id);
  }

  updateTask() {
    taskModelHelper.update(this.id, this);
  }

  deleteTask() {
    taskModelHelper.delete(this.id);
  }
}

FirebaseHelper<TaskModel> taskModelHelper = FirebaseHelper<TaskModel>(
  CONFIG['collectionName']!,
  fromMap: (id, data) => TaskModel.previous(
    id: id,
    userId: data['userId'],
    item: data['item'],
    isDone: data['isDone'],
  ),
  toMap: (taskmodel) => {
    "userId": taskmodel.userId,
    'item': taskmodel.item,
    'isDone': taskmodel.isDone,
  },
);
