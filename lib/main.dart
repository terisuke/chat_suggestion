

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'chat_api.dart';
void main() async {
  await dotenv.load(fileName: ".env");
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

class TweetSuggestionPage extends StatefulWidget {
  @override
  _TweetSuggestionPageState createState() => _TweetSuggestionPageState();
}

class _TweetSuggestionPageState extends State<TweetSuggestionPage> {
  final chatAPI = ChatAPI();
  String? suggestionText;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweet Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your text',
                ),
                minLines: 3,
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final generatedText =
                      await chatAPI.requestChatAPI(_controller.text);
                  setState(() {
                    suggestionText = generatedText;
                  });
                },
                child: Text('Generate Suggestion'),
              ),
              SizedBox(height: 16),
              if (suggestionText != null)
                Text(
                  suggestionText!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
