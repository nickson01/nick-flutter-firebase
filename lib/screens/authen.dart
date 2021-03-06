import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './register.dart';
import './service.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // For Form
  final formKey = GlobalKey<FormState>();

  // Constant
  String titleHaveSpace = 'กรุณากรอกข้อมูล';
  String titleEmailFalse = 'กรุณากรอก Email ให้ถูกต้อง';
  String titlePasswordFalse = 'กรุณากรอก Password มากกว่า 6 ตัวอักษร';

  // Explicit
  String emailString, passwordString;

  // For firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // For SnackBar
  final snackBarKey = GlobalKey<ScaffoldState>();

  // Initial Method
  @override
  void initState(){
    super.initState();
    print('InitState Work !!!!!!!!');

    checkStatus(context);
  }

  Future checkStatus(BuildContext context) async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    if(firebaseUser != null){
      print(firebaseUser.email);
      var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
    }
  }

  Widget signUpButton(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.orange[600],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      icon: Icon(Icons.vpn_lock),
      label: Text('Sign Up'),
      onPressed: () {
        print('Clicking Sign Up');
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return RaisedButton.icon(
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      icon: Icon(Icons.person),
      label: Text('Sign In'),
      onPressed: () {
        print('Clicking Sign In');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('email = $emailString :::: Password $passwordString');
          checkAuthen(emailString, passwordString, context);
        }
      },
    );
  }

  void checkAuthen(String email, String password, BuildContext context) async {
    FirebaseUser firebaseUser = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((objValue) {
      FirebaseUser aaa;
      aaa = objValue;
      print('Login success UID == (${aaa.email})');
      showSnackBar('Success ${aaa.email}');

      var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
    }).catchError((error) {
      String aaa = error.message;
      print('Error == $aaa');
      showSnackBar('Success $aaa');
    });
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      content: Text(message),
      action: SnackBarAction(
        textColor: Colors.blue,
        label: 'ปุ่มอะไรซักอย่าง',
        onPressed: () {},
      ),
    );

    snackBarKey.currentState.showSnackBar(snackBar);
  }

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '8 bit',
      ),
      validator: (String value) {
        if (value.length == 0) {
          return titleHaveSpace;
        } else if (value.length < 6) {
          return titlePasswordFalse;
        }
      },
      onSaved: (String input) {
        passwordString = input;
      },
      obscureText: true,
    );
  }

  Widget emailTextFromField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email :', hintText: 'Your@email.com'),
      validator: (String value) {
        if (value.length == 0) {
          return titleHaveSpace;
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return titleEmailFalse;
        }
      },
      onSaved: (String input) {
        emailString = input;
      },
    );
  }

  Widget showAppName() {
    return Text(
      "แอพพลิเคชั่นของนิค",
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
        key: snackBarKey,
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.green],
                    begin: Alignment(0, -1))),
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
                          child: signInButton(context),
                        ),
                      ),
                      Text('Or'),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 4.0),
                          child: signUpButton(context),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
