// ignore_for_file: unused_label, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:ecg_app/screens/line_chart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

  

class HomePage extends StatelessWidget {
  var  dataIndex;
  var falseID;

  HomePage({Key? key,
    required this.dataIndex,
    required this.falseID,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
        appBar: AppBar(title: Text("${falseID.toString()}\tECG DATA"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: PageView(
            children: [
              LineChartPage(dataIndex:dataIndex,),
            ],
          ),
        ),
      );
    }
}