//main.dart
//main.dart

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'suggestion_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    print('.env file loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tweet Suggestions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TweetSuggestionPage(),
    );
  }
}
