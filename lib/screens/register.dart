import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString,emailString,passwordString;

  Widget uploadButton() {
    return IconButton(
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.white,
      ),
      tooltip: 'Upload to Firebase',
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Name = $nameString, Email = $emailString, Password = $passwordString');
        }
      },
    );
  }

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
      validator: (String value) {
        if (value.length < 6) {
          return 'Password must more than 6 charactor';
        }
      },onSaved: (String value){
        passwordString = value;
      },
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
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Email in the blank';
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Fill Email Format';
        }
      },onSaved: (String value){
        emailString = value;
      },
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
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Name in the blank';
        }
      },onSaved: (String value){
        nameString = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Register'),
          actions: <Widget>[uploadButton()],
          backgroundColor: Colors.red,
        ),
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.white, Colors.blue],
                    radius: 2.5,
                    center: Alignment(-1, -1))),
            padding: EdgeInsets.all(50.0),
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
        ));
  }
}
