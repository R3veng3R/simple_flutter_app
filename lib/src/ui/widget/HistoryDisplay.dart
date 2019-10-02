import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDisplay extends StatelessWidget {
  final Map<String, dynamic> history;

  HistoryDisplay({this.history});

  List<Widget> getChildren() {
    List<Widget> result = new List<Widget>();

    this.history.forEach((final key, final value) {
      result.add(Text('${key} : ${value}'));
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (history == null) {
      return Text('No history data.');
    }

    return Padding(
        padding: const EdgeInsets.all(8), child: Column(children: this.getChildren()));
  }
}
