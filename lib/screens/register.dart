import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Your password',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.red,
          )),
      obscureText: true,
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Your@email.com',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          icon: Icon(
            Icons.email,
            color: Colors.red,
          )),
    );
  }

  Widget nameTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Name',
          hintText: 'Type your name',
          icon: Icon(
            Icons.account_circle,
            color: Colors.red,
          )),
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
        child: Column(
          children: <Widget>[
            Container(
              child: nameTextFormField(),
              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              child: emailTextFormField(),
              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              child: passwordTextFormField(),
              margin: EdgeInsets.only(bottom: 10),
            )
          ],
        ),
      ),
    );
  }
}
