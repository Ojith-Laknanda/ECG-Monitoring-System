// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:ecg_app/screens/line_chart_widget.dart';
import 'package:flutter/material.dart';

class LineChartPage extends StatelessWidget {
  var dataIndex;
  List<Widget> listTiles = [];
   LineChartPage({Key? key, 
    required this.dataIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: Color.fromARGB(255, 244, 244, 245),
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LineChartWidget(dataIndex),
        ),
      );
    }
}