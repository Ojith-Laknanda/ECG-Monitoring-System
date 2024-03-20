// ignore_for_file: camel_case_types, file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class totalData extends StatelessWidget {
  totalData({Key? key}) : super(key: key);
  final ref = FirebaseDatabase.instance.ref("");
  //late String dataIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove the back button
        title: const Text('All ECG Data'),
        // backgroundColor: Colors.transparent,
        // elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                defaultChild: const Text("Loading"),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  // print("\nhiiiiii\n");
                  // print(snapshot.value is Map);
                  // Check if snapshot.value is null before accessing its length
                  if (snapshot.value == null) {
                    return const Center(
                      child: CircularProgressIndicator(), // or any other placeholder widget
                      
                    );
                  }
                  // snapshot.value.keys;
                  // if(snapshot.value is Map){
                  //   print("hello");
                  // }
                  


                  // Get the number of children in the snapshot
                  

                  // Create a list of ListTiles using a for loop
                  List<Widget> listTiles = [];
                  // for (int i = 0; i < itemCount; i++) {
                    
                      listTiles.add(
                      Card(
                        color: Colors.amber,
                        
                          //  child: Text(snapshot.child(0.toString()).value.toString()),
                          child: Text(snapshot.children.toString()),
                      ),
                    );
                    
                  // }

                  // Return a Column with the list of ListTiles
                  return Column(
                    children: listTiles,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
