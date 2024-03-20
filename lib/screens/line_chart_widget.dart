// ignore_for_file: unused_import, avoid_print, use_build_context_synchronously, unused_label, prefer_initializing_formals, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_logic_in_create_state, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ecg_app/screens/line_titles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


class LineChartWidget extends StatefulWidget {
  var dataIndex;

  LineChartWidget(dataIndex, {Key? key}) : super(key: key){
    this.dataIndex=dataIndex;
  }
  @override
  // ignore: library_private_types_in_public_api
  _LineChartWidgetState createState() => _LineChartWidgetState(dataIndex: dataIndex);
}

class _LineChartWidgetState extends State<LineChartWidget> {
  
  var dataIndex;
  List<Widget> listTiles = [];
  List<String> dataList = [];

  String prediction_label = ''; 
  int prediction = 0;
  

  final List<Color> gradientColors = [
    const Color.fromARGB(255, 35, 182, 230),
    const Color(0xff02d39a),
  ];

  _LineChartWidgetState({required dataIndex}){
    this.dataIndex=dataIndex;
  }
 

  
  final auth =FirebaseDatabase.instance;
  late final ref = FirebaseDatabase.instance.ref(dataIndex);
  bool isDataLoaded=false;
  
  
  
    @override
  void initState() {
    super.initState();
    _readdb_onechild();
  }

  _readdb_onechild() async {
  for (int path = 0; path < 250; path++) {
    print("Reading path: $path");
    await ref.child(path.toString()).once().then((DatabaseEvent databaseEvent) {
      print("Data read: ${databaseEvent.snapshot.value}");
    if (mounted) {// this is for when person exit before the data is fully loaded kind of exception handle 
      setState(() {
        dataList.add(databaseEvent.snapshot.value.toString());
      });
    }
    });
    
  }
}
  
  final controller=ScreenshotController();  
  @override
  Widget build(BuildContext context) {
    
    controller:controller;
    // Create an empty list to store the FlSpots
    List<FlSpot> spots = [];

  
     // Add FlSpots using data from dataList
    for (int i = 0; i < dataList.length; i++) {
      double x = i.toDouble();
      double y = 0.0; // Default value in case parsing fails
      

        if (dataList[i].isNotEmpty) {
          try {
            y = double.parse(dataList[i].toString());
          } catch (e) {
            print("Error parsing value at index $i: ${dataList[i]}");
            print(dataList[i].toString());
          }
        }
        //  Future.delayed(const Duration(milliseconds: 100)); // Add a delay of 100 milliseconds
          spots.add(FlSpot(x, y));
      
    }

    return Screenshot(
      controller: controller,
      child: Stack(
        children: [
          LineChart( 
            LineChartData(
              minX: 0,
              maxX: 250,
              minY: -4000,
              maxY: 4000,
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
                  // color: Color.fromARGB(179, 4, 168, 233),
                  color: Color.fromARGB(255, 14, 1, 1),
                  barWidth: 1,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                      show: true,
                      // color: const Color(0xff02d39a).withOpacity(0.3),
                      // color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.0,
            right: 16.0,    
            height: 50,      
            child:
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(229, 229, 235, 55),
                
              ),
              onPressed: () async{
                print("hihihihhihihihihii");
                final image=await controller.capture();
                if(image==null){
                  return print("nothing");
                }
                 
                await saveImage(image);
                Future.delayed(const Duration(milliseconds: 500)); // Add a delay of 500 milliseconds
                await saveAndShare(image);
                
              },
              child: const Icon(
                Icons.photo_camera
              ),
            )
          )
        ],
      ),
    );
  }

  

  Future<String> saveImage(Uint8List bytes) async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = '${dataIndex}_ECG_Screenshot_$time';
      final result = await ImageGallerySaver.saveImage(bytes, name: name);
      return result['filePath'] ?? '';
    } else {
      print("Storage permission denied");
      return showAlertDialog(context);
    }
  }



  Future<void> saveAndShare(Uint8List bytes) async {
    final imageFile = File('${(await getTemporaryDirectory()).path}/temp_screenshot.png');
    await imageFile.writeAsBytes(bytes);

    final cropKey = GlobalKey<CropState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Crop Image"),
          content: Crop(
            key: cropKey,
            image: FileImage(imageFile),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final area = cropKey.currentState?.area;
                if (area != null) {
                  final croppedFile = await ImageCrop.cropImage(
                    file: imageFile,
                    area: area,
                  );

                  if (croppedFile != null) {
                    await sendImageAndPredict(croppedFile);
                  }
                }
              },
              child: Text("Crop and Share"),
            ),
          ],
        );
      },
    );
  }

  // Future<void> sendImageAndPredict(File imageFile) async {
  //   final apiUrl = 'http://127.0.0.1:8000/ecg/make_predictions';
  //   final headers = {
  //     'Content-Type': 'multipart/form-data',
      
  //   };
  //   print("ojiyaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

  //   final fileBytes = await imageFile.readAsBytes();

  //   final ecg = http.MultipartFile.fromBytes(
  //     'ecg',
  //     fileBytes,
  //     filename:'${dataIndex}_ECG_Screenshot.png' ,
  //     contentType: MediaType('image', 'png'),//contentType: MediaType('image', 'jpeg'),
  //   );

  //   final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
  //     ..headers.addAll(headers)
  //     ..files.add(ecg); // Modify this line

  //   try {
  //     final response = await request.send();
  //     final responseJson = await http.Response.fromStream(response);
  //     final responseData = json.decode(responseJson.body);

  //     setState(() {
  //       prediction_label = responseData['prediction_label'];
  //       prediction = responseData['prediction'];
  //     });
  //   } catch (error) {
  //     print('Error sending request: $error');
  //   }
  // }

   Future<void> sendImageAndPredict(File imageFile) async {
      print("dddddddddaaaaaaaaaaaattttttttttttttttaaaaaaaaaaannnnnnnoooootttttttttseeeeeeennnnnndddddddddddd");
  final apiUrl = 'http://127.0.0.1:8000/ecg/make_predictions'; // Replace with your server's API URL
  final headers = {
    'Content-Type': 'multipart/form-data',
  };

  try {
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile(
          'ecg',
          imageFile.readAsBytes().asStream(),
          imageFile.lengthSync(),
          filename: '${widget.dataIndex}_ECG_Screenshot.png',
          contentType: MediaType('image', 'png'),
        ),
      );

    final response = await request.send();
    final responseJson = await http.Response.fromStream(response);
    final responseData = json.decode(responseJson.body);

    setState(() {
      prediction_label = responseData['prediction_label'];
      prediction = responseData['prediction'];
    });
  } catch (error) {
    print('Error sending request: $error');
  }
}

  Future<void> shareCroppedImage(File croppedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/${dataIndex}_ECG_Screenshot.png');
    await croppedFile.copy(image.path);
    await Share.shareFiles([image.path]);
  }

  
}

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );