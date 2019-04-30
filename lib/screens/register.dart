import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget nameTextFormField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Name', hintText: 'Type your name'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: nameTextFormField(),
      ),
    );
  }
}
