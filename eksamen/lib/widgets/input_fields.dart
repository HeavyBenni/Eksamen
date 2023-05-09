import 'package:flutter/material.dart';

class TextField1 extends StatelessWidget {
  final String hintText;
  final String labelText;

  const TextField1({Key? key, required this.hintText, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: hintText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        suffixIcon: Icon(
          Icons.error,
        ),
      ),
    );
  }
}
