import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  // For firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  // For SnackBar
  final snackBarKey = GlobalKey<ScaffoldState>();

  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.white,
      ),
      tooltip: 'Upload to Firebase',
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'Name = $nameString, Email = $emailString, Password = $passwordString');
          uploadValueToFirebase(context);
        }
      },
    );
  }

  void uploadValueToFirebase(BuildContext context) async {
    final FirebaseUser firebaseUser = await _auth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((user) {
      print('Register Success');
      showSnackBar('Register Success');
      addValueToFirebaseDatabase(context);
      // Navigator.pop(context);
    }).catchError((error) {
      print('------------------------ Error ----------------------------');
      showSnackBar(error.message);
      print(error.message);
      print('------------------------ Error ----------------------------');
    });
  }

  void addValueToFirebaseDatabase(BuildContext context) async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    print('UID = ${firebaseUser.uid.toString()}');

    // Create map type
    Map<String,String> map = Map();
    map['Name'] = nameString;
    
    await firebaseDatabase.reference().child(firebaseUser.uid).set(map);
    Navigator.pop(context);
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
      },
      onSaved: (String value) {
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
      },
      onSaved: (String value) {
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
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: snackBarKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Register'),
          actions: <Widget>[uploadButton(context)],
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
