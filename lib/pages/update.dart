// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, sort_child_properties_last, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  final String updateIdd;

  UpdateStudent({Key? key, required this.updateIdd}) : super(key: key);

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference studens =
      FirebaseFirestore.instance.collection('student2');

  Future<void> UpdatteUser(id, name, email, password) {
    return studens
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Update"),
                ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text('Go Back', style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ),
          body: Form(
              key: _formKey,
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('student2')
                      .doc(widget.updateIdd)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("Something went wrng");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data!.data();
                    var name = data!['name'];
                    var email = data['email'];
                    var password = data['password'];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              initialValue: name,
                              autofocus: false,
                              onChanged: (value) => name = value,
                              decoration: InputDecoration(
                                labelText: 'Name: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15),
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
                              autofocus: false,
                              initialValue: email,
                              onChanged: (value) => email = value,
                              decoration: InputDecoration(
                                labelText: 'Email: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15),
                              ),
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
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: password,
                              onChanged: (value) => password = value,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password: ',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    UpdatteUser(widget.updateIdd, name, email,
                                        password);
                                    Navigator.pop(context);
                                    // }
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => {},
                                  child: Text(
                                    'Reset',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }))),
    );
  }
}
