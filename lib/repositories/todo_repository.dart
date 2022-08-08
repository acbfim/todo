import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  void saveTodoList(List<Todo> todos) {
    final jsonSting = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonSting);
  }

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();

    final String jsonSting = sharedPreferences.getString('todo_list') ?? '[]';
    final jsonDecoded = json.decode(jsonSting) as List;

    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }
}
