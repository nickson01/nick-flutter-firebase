import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  Widget signUpButton() {
    return RaisedButton(
      color: Colors.orange[600],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text('Sign Up'),
      onPressed: () {},
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text('Sign In'),
      onPressed: () {},
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '8 bit',
      ),
      obscureText: true,
    );
  }

  Widget emailTextFromField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email :', hintText: 'Your@email.com'),
    );
  }

  Widget showAppName() {
    return Text(
      "My นิคนะ Name",
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: 'Charm'),
    );
  }

  Widget showLogo() {
    return Image.asset('images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.green], begin: Alignment(0, -1))),
        padding: EdgeInsets.only(top: 100.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              child: showLogo(),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: showAppName(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: emailTextFromField(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0),
              child: passwordTextFormField(),
            ),
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: signInButton(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 4.0),
                      child: signUpButton(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
