// ignore_for_file: unused_import, must_be_immutable, prefer_typing_uninitialized_variables, no_logic_in_create_state, file_names

import 'package:ecg_app/screens/line_titles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

class LineChartWidget extends StatefulWidget{
  
  var dataIndex;
  List<Widget> listTiles = [];

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 35, 182, 230),
    const Color(0xff02d39a),
  ];

  LineChartWidget({Key? key,
  required this.dataIndex,
  }) : super(key: key);

  Future<Widget> build(BuildContext context) async {
    // Create an empty list to store the FlSpots
    List<FlSpot> spots = [];

    // Reference to the specific folder in Firebase

    // Add 250 FlSpots to the list using a for loop
    for (int i = 0; i < 250; i++) {
      // Calculate the x and y values based on your data or requirements

       //double y =i*i*0.02+2*i*0.02+3*0.02; // calculate or get the y value for the corresponding x value
      // // Create the FlSpot and add it to the list
      // spots.add(FlSpot(x, y));
      

      // final snapshot = await ref.child('/$i').get();
      // if (snapshot.exists) {
      //    print(snapshot.value);
      // } else {
      //    print('No data available.');
      // }

      
      
      // print(dataIndex);//for the correct index is test //very important
     // print(y);
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 250,
        minY: 0,
        maxY: 300,
        titlesData: LineTitles.getTitleData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots, // Use the list of FlSpots here
            isCurved: true,
            color: const Color.fromARGB(179, 4, 168, 233),
            barWidth: 5,
            // dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
                show: true,
                color: const Color(0xff02d39a).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  State<StatefulWidget> createState() {
    
    throw UnimplementedError();
  }
}
