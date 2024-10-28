import 'package:flutter/material.dart';
import 'package:flutter_digit_recognizer/flutter_digit_recognizer.dart';

class DigitRecognise extends StatefulWidget {
  const DigitRecognise({super.key});

  @override
  State<DigitRecognise> createState() => DigitRecogniseState();
}

class DigitRecogniseState extends State<DigitRecognise> {
  String predictNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                height: 44,
                width: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white.withOpacity(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                  ),
                  child: Icon(Icons.keyboard_backspace, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF487CFC),
              Color(0xFF487CFC).withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 120),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(20, 20, 20, 30), // Added bottom padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Math Recognition",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Draw a number clearly within the canvas. The more clearly you write, the better the prediction will be!",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Expanded drawing canvas
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: DrawScreenTheme(
                          data: DrawScreenThemeData(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Color(0xFF487CFC),
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: DrawScreen(
                            getPredictNum: (String num) {
                              debugPrint("Predicted Number: $num");
                              setState(() {
                                predictNumber += num;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // Bottom section with fixed height
                    Container(
                      height: 120, // Fixed height for bottom section
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _formatNumber(predictNumber),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF487CFC),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF487CFC),
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                predictNumber = "";
                              });
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(String number) {
    if (number.isEmpty) return number;
    final buffer = StringBuffer();
    int count = 0;
    for (int i = number.length - 1; i >= 0; i--) {
      buffer.write(number[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }
    return buffer.toString().split('').reversed.join('');
  }
}
