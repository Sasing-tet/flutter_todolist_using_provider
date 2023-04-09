import 'package:flutter/material.dart';
import 'package:flutter_todo_provider/provider/todoProvider.dart';
import 'package:provider/provider.dart';
import 'page/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Todo List Application'),
      ),
    );
  }
}
