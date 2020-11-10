import 'dart:async';
import 'dart:convert';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:fexpense/models/itodo.dart';
import 'package:fexpense/models/todoModels.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseHelper {
  static Future<void> addExpense(var task) async {
    final config = FaunaConfig.build(
      secret: DotEnv().env['fauna_secret'],
    );
    final client = FaunaClient(config);
    // return client;
    await client
        .query(Create(Collection('tasks'), Obj({'data': task})))
        .catchError((e) {
      print(e);
    });
  }

  static Future<List<ITodo>> getExpense() async {
    List<ITodo> todoList = List();
    final config = FaunaConfig.build(
      secret: DotEnv().env['fauna_secret'],
    );
    final client = FaunaClient(config);
    final result = await client.query(Paginate(Match(Index('all_tasks'))));
    var datainJson = jsonDecode(result.raw.toString());
    var todo = Todo.fromJson(datainJson);
    for (var i = 0; i < todo.resource.data.length; i++) {
      final newresult = await client
          .query(Get(Ref(Collection("tasks"), todo.resource.data[i].ref.id)));
      var dataInJson = jsonDecode(newresult.raw.toString());
      todoList.add(ITodo.fromJson(dataInJson));
    }
    return todoList;
  }

  static Future<void> deleteExpense(String id) async {
    final config = FaunaConfig.build(
      secret: DotEnv().env['fauna_secret'],
    );
    final client = FaunaClient(config);
    await client.query(Delete(Ref(Collection('tasks'), id))).catchError((e) {
      print(e);
    });
  }
}
