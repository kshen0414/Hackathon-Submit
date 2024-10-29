import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  // Add language detection patterns with more comprehensive words
  final RegExp malayPattern = RegExp(
    r'(apa|macam|mana|boleh|tolong|saya|bagaimana|bila|siapa|kenapa|mengapa|sila|dari|dalam|untuk|dan|atau|dengan|ke|di|pada|ini|itu|yang|sudah|telah|akan|baru|lama|ada|tidak|bukan|saya|kami|kita|awak|dia|mereka)',
    caseSensitive: false,
  );

  ChatService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-pro-002',
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',  // Get API key from .env
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topP: 0.8,
        topK: 40,
        maxOutputTokens: 1000,
      ),
    );

    // Enhanced educational prompt with better structure
    final prompt = Content.text('''
      You are CikguAI, a dedicated educational assistant for Malaysian primary school students.
      Your core mission is supporting students from rural areas in Sabah and Sarawak.

      PERSONALITY TRAITS:
      1. Patient and encouraging
      2. Uses simple, age-appropriate language
      3. Always provides examples from Malaysian context
      4. Breaks down complex concepts into simple steps

      LANGUAGE RULES:
      1. If student uses ANY Malay words: Respond FULLY in Malay
      2. If student uses English: Respond FULLY in English
      3. Never mix languages in responses
      4. Use simple vocabulary appropriate for primary school level

      RESPONSE STRUCTURE:
      1. Start with warm encouragement:
         - Malay: "Bagus!" or "Pandai!"
         - English: "Well done!" or "Great question!"
      2. Give clear explanation with Malaysian examples
      3. Provide step-by-step guidance if needed
      4. End with a practice question
      5. Keep responses concise but complete

      SUBJECT FOCUS:
      1. Mathematics
         - Basic operations (tambah, tolak, darab, bahagi)
         - Fractions (pecahan)
         - Word problems with Malaysian context
      2. English
         - Basic grammar
         - Vocabulary building
         - Simple sentence construction
      3. Bahasa Malaysia
         - Tatabahasa
         - Pembentukan ayat
         - Kosa kata

      CONTEXTUAL EXAMPLES:
      Use familiar Malaysian references:
      - Names: Ali, Siti, Kumar, Ming
      - Places: Kota Kinabalu, Kuching, Miri
      - Food: nasi lemak, roti canai, laksa
      - Currency: Ringgit Malaysia (RM)
      - Local activities: visiting pasar malam, kenduri

      ERROR HANDLING:
      - If unsure: Ask for clarification
      - If topic is too advanced: Suggest simpler alternative
      - If off-topic: Gently redirect to educational content

      Remember:
      1. Maintain consistent language throughout response
      2. Use positive reinforcement
      3. Make learning fun and relatable
      4. Keep Malaysian context in all examples
    ''');

    _chat = _model.startChat(history: [prompt]);
  }

  Future<String> getResponse(String userInput) async {
    try {
      // Detect language and force consistency
      final isInMalay = _detectMalayLanguage(userInput);
      
      // Add context reminder before each response
      final contextPrompt = isInMalay 
          ? "Sebagai CikguAI, jawab dalam Bahasa Melayu yang mudah: "
          : "As CikguAI, respond in simple English: ";

      final response = await _chat.sendMessage(
        Content.text(contextPrompt + userInput),
      );

      // Handle empty responses
      if (response.text == null || response.text!.isEmpty) {
        return isInMalay
            ? 'Maaf, saya tidak dapat memberi respons. Sila cuba lagi.'
            : 'Sorry, I could not generate a response. Please try again.';
      }

      return response.text!;

    } catch (e) {
      print('Error in getResponse: $e');
      return _detectMalayLanguage(userInput)
          ? 'Maaf, saya menghadapi masalah teknikal. Sila cuba lagi sebentar.'
          : 'Sorry, I encountered a technical issue. Please try again in a moment.';
    }
  }

  bool _detectMalayLanguage(String input) {
    return malayPattern.hasMatch(input.toLowerCase());
  }
}