import 'package:firebase_core/firebase_core.dart';
import 'package:first_project_mas_ade/ui/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          // Add your own Firebase project configuration from google-services.json
          apiKey: 'AIzaSyCXt14LkMuCRLxMmfEfE5M3_xDJccvA08w', // api_key
          appId:
              '1:405414384812:android:ab950ad8144bdc369b3b09', // mobilesdk_app_id
          messagingSenderId: '405414384812', // project_number
          projectId: 'absensi-mas-ade' // project_id
          ),
    );
    // Firebase connection success
    print("Firebase Terhubung ke:");
    print("API Key: ${Firebase.app().options.apiKey}");
    print("Project ID: ${Firebase.app().options.projectId}");
  } catch (e) {
    // Firebase connection failed
    print("Firebase gagal terhubung: $e");
  }
  // runApp(const HomeScreen());
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  // Main App
  const TestApp({super.key}); // Constructor of TestApp clas

  @override // can give information about about your missing override code
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      home: const HomeScreen(), // HomeScreen class
    );
  }
}

