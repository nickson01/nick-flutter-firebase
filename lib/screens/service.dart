import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nickfirebase/screens/authen.dart';
import 'package:firebase_database/firebase_database.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    readData();
  }

  void readData() async {
    print('Read Data');
    FirebaseUser aaa = await _auth.currentUser();
    // String bb = await firebaseDatabase.reference().child(aaa.uid).onValue.toString();
    // print(bb);
  }
  
  Widget signOutButton(BuildContext context){
    return IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){
      print('Sign out');
      
      _auth.signOut();
      var authenRoute =
          MaterialPageRoute(builder: (BuildContext context) => Authen());
      Navigator.of(context)
          .pushAndRemoveUntil(authenRoute, (Route<dynamic> route) => false);
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),actions: <Widget>[signOutButton(context)],
      ),body: Text('This is body'),
    );
  }
}
