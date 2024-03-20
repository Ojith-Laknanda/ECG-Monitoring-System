// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
   final ref = FirebaseDatabase.instance.ref("").child("5");
  

  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    _readdb_onechild();
  }

  _readdb_onechild() async {
  for (int path = 0; path < 250; path++) {
    // print("Reading path: $path");
    await ref.child(path.toString()).once().then((DatabaseEvent databaseEvent) {
      // print("Data read: ${databaseEvent.snapshot.value}");
      setState(() {
        dataList.add(databaseEvent.snapshot.value.toString());
      });
    });
  }
}


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Data"),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dataList[index]),
          );
        },
      ),
    );
  }
}