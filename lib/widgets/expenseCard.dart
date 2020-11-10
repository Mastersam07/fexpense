import 'package:fexpense/models/itodo.dart';
import 'package:flutter/material.dart';

typedef DeleteCallback = Function(String id);

class ExpenseCard extends StatelessWidget {
  final ITodo todo;
  // final String content, id;
  final DeleteCallback delete;
  // final TextEditingController updateText = TextEditingController();

  ExpenseCard(
      {Key key,
      @required this.todo,
      // @required this.content,
      // @required this.id,
      @required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        leading: Icon(
          Icons.arrow_upward,
          color: Colors.red,
        ),
        title: Text(
          todo.resource.data.name,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        subtitle: Text(
          "Amount:" + todo.resource.data.amount,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent, size: 20.0),
            onPressed: () => delete(todo.resource.ref.ref.id)),
      ),
    );
  }
}
