// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
        // show: true,
        bottomTitles: AxisTitles(
          sideTitles:SideTitles(
          showTitles: true,
          
          reservedSize: 35,
          interval: 0.8,
          getTitlesWidget: (value,meta) {
            switch (value.toInt()) {
              case 0:
                return Text('0',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
              case 50:
                return Text('50',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
              case 100:
                return Text('100',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
              case 150:
                return Text('150',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
              case 200:
                return Text('200',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
              case 250:
                return Text('250',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
            }
            return Text('',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,),
                );
          },
          
        ),
        ),

        leftTitles:AxisTitles(
          sideTitles:SideTitles(
          showTitles: true,
          interval: 1,
          
          getTitlesWidget: (value,meta) {
            switch (value.toInt()) {
              case 0:
                return Text('0',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case 500:
                return Text('500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case 1000:
                return Text('1000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case 1500:
                return Text('1500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case 2000:
                return Text('2000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case 2500:
                return Text('2500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case 3000:
                return Text('3000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case 3500:
                  return Text('3500',style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,),
                  );
                case 4000:
                  return Text('4000',style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,),
                  );

                  case -500:
                return Text('-500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case -1000:
                return Text('-1000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case -1500:
                return Text('-1500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case -2000:
                return Text('-2000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case -2500:
                return Text('-2500',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
              case -3000:
                return Text('-3000',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
                case -3500:
                  return Text('-3500',style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,),
                  );
                case -4000:
                  return Text('-4000',style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,),
                  );
            }
              return Text('',style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,),
                );
          },
          reservedSize: 35,
         
        ),
        ),
         
      );
}