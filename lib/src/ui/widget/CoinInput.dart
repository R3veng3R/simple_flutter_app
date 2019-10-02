import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String HINT = 'Type currency code:';
const int MAX_INPUT_LENGTH = 3;

class CoinInput extends StatelessWidget {
  final void Function(String value) onChange;

  CoinInput({this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        maxLength: MAX_INPUT_LENGTH,
        autofocus: true,
        onChanged: this.onChange,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '',
          labelText: HINT,

        ),
      ),
    );
  }
}
