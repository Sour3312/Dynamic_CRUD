// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_print, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String name = '';
    var email = '';
    var password = '';

    TextEditingController _name = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    ClearText() {
      _name.clear();
      _email.clear();
      _password.clear();
    }

    CollectionReference students =
        FirebaseFirestore.instance.collection('student2');

//++++++++++++++++++++++ Adduser Function ++++++++++++++++++++++
    Future<void> addUser() {
      return students
          .add({'name': name, 'email': email, 'password': password})
          .then((value) => print('User Added'))
          .catchError((error) => print('Failed to Add user: $error'));
    }

    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add here"),
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: Text('Go Back', style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(68.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              // students.get().then((value) => null),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: _name,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    // labelStyle: TextStyle(fontSize: 20.0),
                    // border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Email: ',
                    // labelStyle: TextStyle(fontSize: 20.0),
                    // border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 11.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  obscuringCharacter: '#',
                  decoration: InputDecoration(
                    labelText: 'Password: ',
                    // labelStyle: TextStyle(fontSize: 20.0),
                    // border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  RaisedButton(
                      onPressed: () {
                        print("object");
                        // if (_formkey.currentState!.validate()) {
                        setState(() {
                          name = _name.text;
                          email = _email.text;
                          password = _password.text;
                          addUser();
                        });
                        // }
                      },
                      child: Text("Submitttt")),
                  Spacer(),
                  RaisedButton(
                      onPressed: () {
                        ClearText();

                        print("reset");
                      },
                      child: Text("Reset"))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
