import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  final myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  // text controller
  final _controller = TextEditingController();
  // List todoList = [
  //   ['Make Tutorial', true],
  //   ['Do Exercise', false],
  //   ['Play Padel', false],
  // ];

  @override
  void initState() {
    // if is the first time the create the default data
    if(myBox.get('TODOLIST') == null){
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  // when checkbox is tapped
  void checkBoxChanged(int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSve: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChange: (value) {
              checkBoxChanged(index);
            },
            onDeleteTask: (context) {
              return deleteTask(index);
            },
          );
        },
      ),
    );
  }
}

// ListView(
// children: [
//   ToDoTile(
//     taskName: 'Make Tutorial',
//     taskCompleted: true,
//     onChange: (value) {},
//   ),
//   ToDoTile(
//     taskName: 'Do Exercise',
//     taskCompleted: true,
//     onChange: (value) {},
//   ),
//   ToDoTile(
//     taskName: 'Play Padel',
//     taskCompleted: false,
//     onChange: (value) {},
//   ),
// ],
// ),
