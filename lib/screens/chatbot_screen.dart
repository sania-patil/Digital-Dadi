import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  final String recipeHint;
  final String language; // 'hi' or 'en'

  const ChatbotScreen({
    Key? key,
    required this.recipeHint,
    this.language = 'en',
  }) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _addBotMessage(
      widget.language == 'hi'
          ? 'नमस्ते! मैं आपकी ${widget.recipeHint} में मदद कर सकती हूँ। कोई सवाल पूछें!'
          : 'Hello! I\'m here to help with your ${widget.recipeHint}. Ask me anything!',
    );
  }

  void _addBotMessage(String message) {
    setState(() {
      _messages.add({
        'isUser': false,
        'message': message,
      });
    });
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    final userMessage = _messageController.text;
    setState(() {
      _messages.add({
        'isUser': true,
        'message': userMessage,
      });
    });

    _messageController.clear();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 800), () {
      _addBotMessage(
        widget.language == 'hi'
            ? 'यह बहुत अच्छा सवाल है! इस बारे में और जानकारी के लिए कृपया अपने डॉक्टर से परामर्श लें।'
            : 'That\'s a great question! For more detailed advice, please consult your healthcare provider.',
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD4847A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.language == 'hi' ? 'रेसिपी सहायता' : 'Recipe Assistant',
          style: const TextStyle(
            color: Color(0xFFD4847A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),

          // Recipe hint card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFDBF9D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFD4847A),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.recipeHint,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF3D2C2A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE8D7D2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: widget.language == 'hi'
                          ? 'आपका सवाल लिखें...'
                          : 'Ask a question...',
                      hintStyle: const TextStyle(
                        color: Color(0xFFB5A5A2),
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFFE8D7D2),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4847A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isUser = msg['isUser'] as bool;
    final message = msg['message'] as String;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFFD4847A)
              : const Color(0xFFE8D7D2),
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : const Color(0xFF3D2C2A),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
