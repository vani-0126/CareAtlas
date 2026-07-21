import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_messages.dart';
import 'message_bubble.dart';

class AiMedicalexplainer extends StatefulWidget {
  const AiMedicalexplainer({super.key});
  @override
  State<AiMedicalexplainer> createState() => _AiMedicalexplainerState();
}

class _AiMedicalexplainerState extends State<AiMedicalexplainer> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessages> messages = [];

  void _scrollToRecentQuestion() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && messages.isNotEmpty) {
        int lastUserIndex = messages.lastIndexWhere(
          (msg) => msg.isUser == true,
        );

        if (lastUserIndex == -1) lastUserIndex = messages.length - 1;

        double targetOffset = lastUserIndex * 80.0;

        if (targetOffset > _scrollController.position.maxScrollExtent) {
          targetOffset = _scrollController.position.maxScrollExtent;
        }

        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _sendMessage([String? userText]) {
    final text = (userText ?? _controller.text).trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessages(text: text, isUser: true));
    });

    _controller.clear();
  }

  void _handleSubmitted(String value) {
    if (_isLoading) return;
    String lastAiText = "";

    for (var i = messages.length - 1; i >= 0; i--) {
      if (!messages[i].isUser) {
        lastAiText = messages[i].text;
        break;
      }
    }

    _sendMessage(value);

    fetchAiExplanation(value, lastAiText);
  }

  String _aiOutput =
      "Ask a question about a medical concept, terms, treatment or anatomy";
  bool _isLoading = false;

  Future<void> fetchAiExplanation(
    String userText,
    String previousAiResponse,
  ) async {
    if (userText.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _aiOutput = "Processing and verifying information...";
    });

    try {
      // Remember: Use '10.0.2.2:8000' for Android Emulator or '127.0.0.1:8000' for iOS Simulator

      final url = Uri.parse('http://localhost:8000/explain');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "query": userText,
          "previous_ai_response": previousAiResponse,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String serverDefinition =
            data['explanation'] ?? "No text returned from server.";

        setState(() {
          // 1. Clear out your processing text banner
          _aiOutput = "";

          // 2. Append the incoming AI translation cleanly right into your scrolling bubbles!
          messages.add(ChatMessages(text: serverDefinition, isUser: false));
        });
        _scrollToRecentQuestion();
      } else {
        setState(() {
          _aiOutput =
              "Server Error (${response.statusCode}): Unable to complete request.";
        });
      }
    } catch (error) {
      setState(() {
        _aiOutput =
            "Connection Failed. Make sure your Python server is running.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 240, 255),
      appBar: AppBar(title: const Text("AI Medical Explainer")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 28),
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                hintText: "Type your question here",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 32),
            child: SingleChildScrollView(
              child: Text(_aiOutput, style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
