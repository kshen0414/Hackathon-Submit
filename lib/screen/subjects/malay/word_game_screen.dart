// lib/screens/subjects/malay/word_game_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../model/malay_words.dart';

class WordGameScreen extends StatefulWidget {
  final WordCategory category;

  const WordGameScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<WordGameScreen> createState() => _WordGameScreenState();
}

class _WordGameScreenState extends State<WordGameScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';
  late List<MalayWord> _allWords; // All available words
  late List<MalayWord> _sessionWords; // 5 random words for current session
  int _currentIndex = 0;
  bool _isCorrect = false;
  String _status = '';
  static const int wordsPerSession = 5;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _allWords = malayWords[widget.category]!;
    _sessionWords = _getRandomWords();
    _initializeSpeech();
  }

  List<MalayWord> _getRandomWords() {
    final random = Random();
    final List<MalayWord> wordPool = List.from(_allWords); // Create a copy
    final List<MalayWord> selectedWords = [];

    for (int i = 0; i < wordsPerSession; i++) {
      if (wordPool.isEmpty) break;
      final index = random.nextInt(wordPool.length);
      selectedWords.add(wordPool[index]);
      wordPool.removeAt(index);
    }
    return selectedWords;
  }

  Future<void> _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) => setState(() => _status = status),
      onError: (errorNotification) =>
          setState(() => _status = errorNotification.errorMsg),
    );
    if (!available) {
      setState(() => _status = 'Speech recognition not available');
    }
  }

  Future<void> _listen() async {
    setState(() {
      _isListening = true;
      _spokenText = '';
      _isCorrect = false;
      _status = 'Listening...';
    });

    try {
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords.toLowerCase();
            _isCorrect =
                _spokenText == _sessionWords[_currentIndex].word.toLowerCase();
            if (_isCorrect) {
              _speech.stop();
              _isListening = false;
            }
          });
        },
        localeId: 'ms_MY',
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isListening = false;
      });
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _nextWord() {
    if (_currentIndex < _sessionWords.length - 1) {
      setState(() {
        _currentIndex++;
        _spokenText = '';
        _isCorrect = false;
        _status = '';
      });
    } else {
      _showSessionComplete();
    }
  }

  void _showSessionComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Tahniah! / Congratulations!'),
        content: const Text('Would you like to try another set of words?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to category selection
            },
            child: const Text('Finish'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _sessionWords = _getRandomWords();
                _currentIndex = 0;
                _spokenText = '';
                _isCorrect = false;
                _status = '';
              });
            },
            child: const Text('Try Another Set'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            '${_currentIndex + 1} / $wordsPerSession',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          // Invisible button that takes up the same space
          Opacity(
            opacity: 0, // Makes it invisible
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed:
                  null, // Null callback means it won't respond to touches
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          LinearProgressIndicator(
            value: (_currentIndex + 1) / wordsPerSession,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 8, // Makes the progress bar thicker
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Word display card
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _sessionWords[_currentIndex].word,
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _sessionWords[_currentIndex].meaning,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                _sessionWords[_currentIndex].example,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Status and controls section
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _status,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_spokenText.isNotEmpty)
                          Text(
                            'You said: $_spokenText',
                            style: TextStyle(
                              fontSize: 20,
                              color: _isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 24),

                        // Microphone button
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isListening ? Colors.red : Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                            ),
                            onPressed: _isListening ? _stopListening : _listen,
                          ),
                        ),

                        // Next button
                        // Next button
                        if (_isCorrect) ...[
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: _nextWord,
                              icon: const Icon(
                                Icons.arrow_forward,
                                size: 24,
                                color: Colors.white, // White icon
                              ),
                              label: const Text(
                                'Next Word',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white, // White text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(
                                    0xFF487CFC), // Using your app's blue color
                                elevation: 2, // Slight shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }
}
