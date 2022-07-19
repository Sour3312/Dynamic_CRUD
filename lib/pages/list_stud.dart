// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/pages/update.dart';
import 'package:flutter/material.dart';

class ListStudents extends StatefulWidget {
  ListStudents({Key? key}) : super(key: key);

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  final Stream<QuerySnapshot> studStream =
      FirebaseFirestore.instance.collection("student2").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error Occured");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List storeDta = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a1 = document.data() as Map<String, dynamic>;
            storeDta.add(a1);
            a1['id'] = document.id;
            // print(document.id);
          }).toList();

          CollectionReference studd =
              FirebaseFirestore.instance.collection('student2');

          Future<void> DeleteUser(id) {
            return studd
                .doc(id)
                .delete()
                .then((value) => print("user deleted"))
                .catchError((error) => print("failed to delete"));
          }

          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(30.0),
              child: Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Container(
                              color: Colors.pinkAccent,
                              child: Center(
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))),
                      TableCell(
                          child: Container(
                              color: Colors.pinkAccent,
                              child: Center(
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))),
                      TableCell(
                          child: Container(
                              color: Colors.pinkAccent,
                              child: Center(
                                child: Text(
                                  'Opreations',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )))
                    ]),
                    for (var i = 0; i < storeDta.length; i++) ...[
                      TableRow(children: [
                        TableCell(
                            child: Container(
                                child: Center(
                          child: Text(
                            storeDta[i]['name'],
                          ),
                        ))),
                        TableCell(
                            child: Container(
                                child: Center(
                          child: Text(
                            storeDta[i]['email'],
                          ),
                        ))),
                        TableCell(
                            child: Center(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    print("object");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateStudent(
                                                updateIdd: storeDta[i]['id'])));
                                  },
                                  icon: Icon(Icons.drive_file_rename_outline)),
                              IconButton(
                                  onPressed: () {
                                    DeleteUser(storeDta[i]['id']);
                                    print("deleted");
                                    // print(storeDta);
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ))
                      ]),
                    ],
                  ]),
            ),
          ));
//   }
// }
        });
  }
}
