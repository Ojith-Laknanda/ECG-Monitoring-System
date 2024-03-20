// ignore_for_file: avoid_print, library_private_types_in_public_api, file_names

import 'package:ecg_app/screens/FolderListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OPENUP extends StatefulWidget {
  const OPENUP({Key? key}) : super(key: key);

  @override
  _OPENUPState createState() => _OPENUPState();
}

class _OPENUPState extends State<OPENUP> {
 
  @override
  void initState() {
    super.initState();

    // Automatically navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      try {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FolderListScreen()
          ),
        ); // Replace with your home route
      } catch (e) {
        print("Navigation error: $e");
        // Handle the navigation error gracefully
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            color: Colors.cyanAccent.shade700, // Blue background color
            curve: Curves.easeInOut,
            onEnd: () {
              setState(() {
                // Change the background color to red after the animation ends
                
                // You can customize this as needed
                // For example, you can use another animation or logic here
              });
            },
          ),
          const Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('images/ECG.png'), // Path to your image,
                
              
            ),
          ),
        ],
      ),
    );
  }
}
