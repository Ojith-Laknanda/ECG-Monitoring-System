// ignore_for_file: unused_import, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:ecg_app/screens/line_titles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class LineChartWidget extends StatelessWidget {
  
  var dataIndex;
  List<Widget> listTiles = [];

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 35, 182, 230),
    const Color(0xff02d39a),
  ];

  LineChartWidget({Key? key,
  required this.dataIndex,
  }) : super(key: key);

  
  final auth =FirebaseDatabase.instance;
  late final ref = FirebaseDatabase.instance.ref(dataIndex);
  
  void data(){
    StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context,index){
                    //  print(snapshot.data!.child(dataIndex).value.toString());
                    //  String abcValue = snapshot.data!.child("abc").value.toString();
                    return const Card(
                      );
                    
                  });
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context,index){
                    //  print(snapshot.data!.child(dataIndex).value.toString());
                    //  String abcValue = snapshot.data!.child("abc").value.toString();
                    return const Card(
                      );
                    
                  });
      },
    )
      )
    );
}
}