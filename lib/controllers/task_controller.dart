import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fyp_calendar_2/db/db_helper.dart';
import 'package:get/get.dart';
import '../models/task.dart';

class TaskController extends GetxController {

  @override
  void onReady(){
    super.onReady();
  }
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insertTask(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.queryTask();
    int i = tasks.length;
    //taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    print("Here is getTask");
    for (var r = 0; r < i; r++){
        var tar = tasks[r]["title"];
        print(tar);}
  }

  Future<List<Map<String, dynamic>>> getTaskToEventList() async {
    List<Map<String, dynamic>> tasks = await DBHelper.rawQueryTask();
    return Future.value(tasks);
}


}