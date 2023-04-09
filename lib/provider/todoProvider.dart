// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
        createdTime: DateTime.now(),
        title: 'TEST 1',
        description: '- test 1 description'),
    Todo(
      createdTime: DateTime.now(),
      title: 'TEST 2 LETSGO',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'AAAAAAAAAAA',
      description: 'neat\nself-retrospecting\ntest description',
    ),
    Todo(
        createdTime: DateTime.now(),
        title: '>>>> 1234@#op',
        description: '??? 123\n///>SD\nfishing\nrandom words'),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.isDone = false,
  }) : id = const Uuid().v4();
}
