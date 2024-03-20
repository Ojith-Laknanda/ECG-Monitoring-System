// ignore_for_file: deprecated_member_use, duplicate_ignore, unnecessary_null_comparison, file_names

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("share"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            buildImage(),
            const SizedBox(
              height: 32,
            ),
            FlatButton(
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () async {
                final image = await controller.capture();
                if (image == null) return;

                await saveImage(image);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () async {
                final image = await controller.captureFromWidget(buildImage());
                if (image == null) return;

                await saveImage(image);
                saveAndShare(image);
              },
              child: const Text(
                'Share',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  Widget buildImage() => Image.network(
        'https://www.psdstack.com/wp-content/uploads/2019/08/copyright-free-images-750x420.jpg',
        fit: BoxFit.cover,
      );
}