import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TODOPage extends StatefulWidget {
  const TODOPage({Key? key}) : super(key: key);

  @override
  State<TODOPage> createState() => _TODOPageState();
}

class _TODOPageState extends State<TODOPage> {
  TextEditingController _textFieldController = TextEditingController();
  String newTask = "";
  String newTaskText = "";
  List<Widget> list = [];
  List<bool> _value = [];
  var argument = Get.arguments;
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    generatedCheckbox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 0, 24),
            child: Text(
              "${argument[1].toString()} Tasks",
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Text(
              argument[0],
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
            child: LinearPercentIndicator(
              animateFromLastPercent: true,
              width: MediaQuery.of(context).size.width * 0.7,
              animation: true,
              animationDuration: 1000,
              lineHeight: 4.0,
              trailing: new Text("${(argument[2] * 100).toStringAsFixed(0)}%"),
              percent: argument[2],
              barRadius: const Radius.circular(2),
              progressColor: Colors.orange,
            ),
          ),
          Expanded(
            child: isLoading
                ? CircularProgressIndicator()
                : ListView(
                    children: list,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void generatedCheckbox() {
    int tasks = argument[1];
    var todos = [
      "Design sprint",
      "HTML/CSS study",
      "Icon for mobile app",
      "Weekly report",
      "Design meeting",
      "Quick prototyping"
    ];
    _value = [false, false, false, false, false, false];

    for (int i = 0; i < tasks; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.fromLTRB(32, 12, 0, 0),
          child: CheckboxListTile(
            value: _value[i],
            onChanged: (value) {
              setState(
                () {
                  _value[i] = value ?? false;
                },
              );
            },
            title: Text(todos[i]),
          ),
        ),
      );
    }
    setState(() => isLoading = false);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add new task"),
          content: TextField(
            onChanged: (value) {
              setState(() => newTaskText = value);
            },
            controller: _textFieldController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() => newTask = newTaskText);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
