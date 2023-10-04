import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  Map<String, List<dynamic>> toDoList = {};

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = {
      "Daily": [
        ["Daily", false]
      ],
      "Weekly": [
        ["Weekly", false]
      ],
      "Others": [
        ["Others", false]
      ],
    };
  }

  // load the data from database
  void loadData() {
    toDoList = Map<String, List<dynamic>>.from(_myBox.get("TODOLIST"));
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
