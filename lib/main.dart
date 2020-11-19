import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'widgets/expenseCard.dart';
import 'models/iexpense.dart';
import 'services/expenseServices.dart';
import 'widgets/expenseDialog.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Tracker',
        home: ExpenseList(),
        debugShowCheckedModeBanner: false);
  }
}

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Expense Tracker')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _getExpenses(),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(context),
            tooltip: 'Add Expense',
            child: Icon(Icons.add)));
  }

  // Display Add Expense Dialog
  Future<void> _updatedDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: AlertDialog(
              title: Center(
                child: Text(
                  "Expenses Updated Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              content: Container(
                child: Icon(
                  Icons.check_circle,
                  size: 150,
                  color: Colors.green,
                ),
              ),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => ExpenseList()),
                        (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CLOSE",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Add Expense Dialog
  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return ExpenseDialog(
              title: 'Add Expenses',
              positiveAction: 'ADD',
              negativeAction: 'CANCEL',
              submit: _handleDialogSubmission);
        });
  }

  // Add Expense
  Future<void> _handleDialogSubmission(String expense, String amount) async {
    var expenses = <String, dynamic>{'name': expense, 'amount': amount};
    await DatabaseHelper.addExpense(expenses);
    _updatedDialog(context);
  }

  // Retrieve Expenses
  Widget _getExpenses() {
    return FutureBuilder(
        future: DatabaseHelper.getExpense(),
        builder: (BuildContext context, AsyncSnapshot<List<IExpense>> snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length > 0) {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => ExpenseCard(
                  expense: snapshot.data[index], delete: _deleteExpense),
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("Empty"),
            );
          }
        });
  }

  Future<void> _deleteExpense(String id) async {
    await DatabaseHelper.deleteExpense(id);
    _updatedDialog(context);
  }
}
