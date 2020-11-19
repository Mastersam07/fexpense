import 'package:fexpense/models/iexpense.dart';
import 'package:flutter/material.dart';

typedef DeleteCallback = Function(String id);

class ExpenseCard extends StatelessWidget {
  final IExpense expense;
  final DeleteCallback delete;

  ExpenseCard(
      {Key key,
      @required this.expense,
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
          expense.resource.data.name,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        subtitle: Text(
          "Amount:" + expense.resource.data.amount,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent, size: 20.0),
            onPressed: () => delete(expense.resource.ref.ref.id)),
      ),
    );
  }
}
