// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_provider/provider/todoProvider.dart';
import 'package:flutter_todo_provider/widget/Alert.dart';
import 'package:provider/provider.dart';

import '../page/editpage.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                onPressed: (_) => editTodo(context, todo),
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (context) => deleteTodo(context, todo),
              ),
            ],
          ),
          key: Key(todo.id),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, todo),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);

                  AlertNotif.ShowSnackBar(
                      context,
                      isDone
                          ? 'Task Completed.'
                          : 'Task Marked as Incomplete.');
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    AlertNotif.ShowSnackBar(context, 'Task Deleted Successfully.');
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoPage(todo: todo),
      ),
    );
  }
}

class TodoListItems extends StatelessWidget {
  const TodoListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No todos left...',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
              height: 8,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
          );
  }
}
