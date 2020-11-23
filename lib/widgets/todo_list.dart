import 'package:flutter/material.dart';

class TodoList extends StatefulWidget{

  @override
  _TodoListState createState() => _TodoListState();
}
class _TodoListState extends State<TodoList>{
  final List<String> entries = <String>['A', 'B', 'C'];
  final _formKey = GlobalKey<FormState>();

  void _addToList(String value) {
    setState(() {
      entries.add(value);
    });
  }
  void _clearList() {
    setState(() {
      entries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Write your todo item',
                    ),
                    onSubmitted: (text) => _addToList(text),
                  ),
                  ElevatedButton(
                    onPressed: () => _clearList(),
                    child: Text('Clear'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: entries.length,
              itemBuilder: (context, index) => Text('Entry ${entries[index]}')
            ),
          ],
        ),
      ),
    );
  }
}