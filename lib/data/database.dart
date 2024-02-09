import 'package:hive/hive.dart';

class ToDoDatabase {
  List todoList = [];

  // reference our box
  final _myBox = Hive.box('myBox');

  // run this method if this is the first time ever opening the application
  void createInitialData() {
    todoList = [
      ['Make Tutorial', true],
      ['Do Exercise', false],
      ['Play Padel', false],
    ];
  }

  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  void updateDatabase() {
    _myBox.put('TODOLIST', todoList);
  }
}
