// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todoProvider.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TodoForm(
              onChangeTitle: (title) => setState(
                () {
                  this.title = title;
                },
              ),
              onChangeDescription: (description) => setState(
                () {
                  this.description = description;
                },
              ),
              saveTodo: addTodo,
            ),
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      if (title.isNotEmpty) {
        final todo = Todo(
          title: title,
          description: description,
          createdTime: DateTime.now(),
        );

        final provider = Provider.of<TodosProvider>(context, listen: false);
        provider.addTodo(todo);

        Navigator.of(context).pop();
      } else {}
    }
  }
}

class TodoForm extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;
  final VoidCallback saveTodo;

  const TodoForm(
      {Key? key,
      this.title = ' ',
      this.description = ' ',
      required this.onChangeTitle,
      required this.onChangeDescription,
      required this.saveTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            buildTitle(),
            SizedBox(height: 10),
            buildDescription(),
            SizedBox(height: 20),
            buildSaveButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangeTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'Input Field is Empty.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
          hintText: 'Input Todo Title here...',
        ),
      );
  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangeDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
          hintText: 'Input Todo Description here...',
        ),
      );
  Widget buildSaveButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: saveTodo,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 28, 28, 28)),
          ),
          child: Text(
            'Save',
          ),
        ),
      );
}
