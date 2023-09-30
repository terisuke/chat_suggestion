//suggestion_page.dart
import 'package:flutter/material.dart';
import 'chat_api.dart';

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
              ElevatedButton(
                onPressed: () async {
                  final revisedText =
                      await chatAPI.requestRevisionAPI(_controller.text);
                  setState(() {
                    suggestionText = revisedText;
                  });
                },
                child: Text('Revise Text'),
              ),
              SizedBox(height: 16),
              if (suggestionText != null)
                GestureDetector(
                  onTap: () {
                    _controller.text = suggestionText!;
                  },
                  child: Text(
                    suggestionText!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
