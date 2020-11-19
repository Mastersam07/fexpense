import 'package:flutter/material.dart';

typedef VoidCallback = Function(String expense, String amount);

class EditDialog extends StatefulWidget {
  const EditDialog(
      {@required this.title,
      @required this.positiveAction,
      @required this.negativeAction,
      @required this.submit});
  final String title, positiveAction, negativeAction;
  final VoidCallback submit;

  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool _validateDialog = false;

  @override
  void initState() {
    nameController.addListener(_updateDialogTextField);
    numberController.addListener(_updateDialogTextField);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: getDialogContent(),
      actions: <Widget>[
        FlatButton(
          child: Text(widget.positiveAction,
              style: TextStyle(
                color: _validateDialog ? Colors.blueAccent : Colors.grey,
              )),
          onPressed: () {
            if (_validateDialog) {
              widget.submit(nameController.text.trim().toString(),
                  numberController.text.trim().toString());
              Navigator.of(context).pop();
            }
          },
        ),
        FlatButton(
          child: Text(
            widget.negativeAction,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget getDialogContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    errorText:
                        !_validateDialog ? 'Value Can\'t Be Empty' : null,
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: "Expense",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: !_validateDialog
                        ? 'Value Can\'t Be Empty and must be a number'
                        : null,
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    hintText: "Amount",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateDialogTextField() {
    setState(() {
      _validateDialog =
          nameController.text.isNotEmpty && numberController.text.isNotEmpty;
    });
  }
}
