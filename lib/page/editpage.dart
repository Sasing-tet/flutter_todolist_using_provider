// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/widget/text_dialog.dart';
import 'package:provider/provider.dart';
import '../provider/todoProvider.dart';
import '../widget/Alert.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          IconButton(
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.removeTodo(widget.todo);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: TodoForm(
            title: title,
            description: description,
            onChangeTitle: (title) => setState(() {
              this.title = title;
            }),
            onChangeDescription: (description) => setState(() {
              this.description = description;
            }),
            saveTodo: saveTodo,
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);

      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
      AlertNotif.ShowSnackBar(context, 'Task Edited Successfully.');
    }
  }
}
