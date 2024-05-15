import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late TextEditingController _controller;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void _sendMessage(String message) async {
    setState(() {
      messages.add({'sender': 'user', 'message': message});
    });

    final response = await http.get(Uri.parse(
        'http://api.brainshop.ai/get?bid=181522&key=VyZzIkw1rP2v1U22&uid=[uid]&msg=$message'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        messages.add({'sender': 'bot', 'message': data['cnt']});
      });
    } else {
      setState(() {
        messages.add({'sender': 'bot', 'message': 'Failed to get response'});
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['sender'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: message['sender'] == 'user' ? Colors.white : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (message['sender'] == 'bot') const Icon(Icons.android, color: Colors.green),
                        Text(
                          message['message'],
                          style: const TextStyle(color: Colors.black),
                        ),
                        if (message['sender'] == 'user') const Icon(Icons.person, color: Colors.blue),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                    onSubmitted: (value) {
                      _sendMessage(value);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
