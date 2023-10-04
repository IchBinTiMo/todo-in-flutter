import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eztodo/component/dialog_box.dart';
import 'package:eztodo/component/stuff_todo.dart';
import 'package:eztodo/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _selectedItem = ValueNotifier("Daily");
  final _mybox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(String tab, bool? value, int index) {
    setState(() {
      db.toDoList[tab]?[index][1] = value!;
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_controller.text.isEmpty) {
      return;
    } else {
      setState(() {
        db.toDoList[_selectedItem.value]?.add([_controller.text, false]);
        _controller.clear();
        _selectedItem.value = "Daily";
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          selectedItem: _selectedItem,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
            _selectedItem.value = "Daily";
            _controller.clear();
          },
        );
      },
    );
  }

  void deleteTask(String type, int index) {
    setState(() {
      db.toDoList[type]?.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 8, 8),
          elevation: 0,
          title: const Text(
            "To Do",
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Daily",
            ),
            Tab(
              text: "Weekly",
            ),
            Tab(
              text: "Others",
            )
          ]),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: TabBarView(children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 0, 61, 55)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: ListView.builder(
              itemCount: db.toDoList["Daily"]?.length,
              itemBuilder: (context, index) {
                return StuffTodo(
                  taskIndex: index + 1,
                  taskLength: db.toDoList["Daily"]?.length,
                  taskName: db.toDoList["Daily"]?[index][0],
                  taskCompleted: db.toDoList["Daily"]?[index][1],
                  onChanged: (value) => checkBoxChanged("Daily", value, index),
                  deleteFunction: (context) => deleteTask("Daily", index),
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 0, 61, 55)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: ListView.builder(
              itemCount: db.toDoList["Weekly"]?.length,
              itemBuilder: (context, index) {
                return StuffTodo(
                  taskIndex: index + 1,
                  taskLength: db.toDoList["Weekly"]?.length,
                  taskName: db.toDoList["Weekly"]?[index][0],
                  taskCompleted: db.toDoList["Weekly"]?[index][1],
                  onChanged: (value) => checkBoxChanged("Weekly", value, index),
                  deleteFunction: (context) => deleteTask("Weekly", index),
                );
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 0, 61, 55)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: ListView.builder(
              itemCount: db.toDoList["Others"]?.length,
              itemBuilder: (context, index) {
                return StuffTodo(
                  taskIndex: index + 1,
                  taskLength: db.toDoList["Others"]?.length,
                  taskName: db.toDoList["Others"]?[index][0],
                  taskCompleted: db.toDoList["Others"]?[index][1],
                  onChanged: (value) => checkBoxChanged("Others", value, index),
                  deleteFunction: (context) => deleteTask("Others", index),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
