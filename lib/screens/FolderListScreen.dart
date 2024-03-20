// ignore_for_file: file_names

import 'package:ecg_app/screens/homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FolderListScreen extends StatefulWidget {
  const FolderListScreen({Key? key}) : super(key: key);

  @override
  State<FolderListScreen> createState() => _FolderListScreenState();
}

class _FolderListScreenState extends State<FolderListScreen> {
  final auth =FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref();

  var indexx;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent.shade200,
            Colors.lightBlueAccent.shade700
          ]

        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("All ECG Data"),
           centerTitle: true,
           automaticallyImplyLeading: false,
          ),
        
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              const Duration(seconds: 1);
              
              setState(() {
                // Reset your data or perform refresh operations
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              });
            },
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
                    
                    if(!snapshot.hasData){
                      return const Center(
                        child: CircularProgressIndicator()
                      );
                    }else{
                      

                       return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context,index){
                        
                       return Dismissible(
                        background: Container(
                          color: Colors.redAccent,
                          padding:  const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(6.0),
                          child: const Icon(Icons.delete_forever,color: Colors.white,size: 40,),
                        ),
                         key: ValueKey(index),
                         direction: DismissDirection.endToStart,
                         confirmDismiss: (direction){
                          return showDialog(
                            context: context,
                            builder:(ctx) => AlertDialog(
                              title: const Text("Do you wnat to DELETE "),
                              content: const Text("Are You Sure ?"),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.of(ctx).pop(true);
                                  ref.child((index+1).toString()).remove();
                                },child: const Text("Delete")),
                                
                                ElevatedButton(onPressed: (){
                                  Navigator.of(ctx).pop(false);
                                },child: const Text("Cancel")),
                              ],
                            ),
                          );
                         },
                         
                         child: Card(
                            color: Colors.amber,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> HomePage(
                                    
                                     dataIndex:(index+1).toString(),
                                     falseID: (index+1).toString(),
                                    
                                  )
                                  ),
                                );
                                print("id " +index.toString());
                              },
                              child: ListTile(
                                title: Text(
                                  
                                   indexx=(index+1).toString()
                                ),
                                
                              ),
                               
                            ),
                            
                          ),
                       );
                      
                    });
                  
                    }
                   },
                ),
              ),
              
            ],
          ),
        ),
      )
      ),
    );
  }
}

