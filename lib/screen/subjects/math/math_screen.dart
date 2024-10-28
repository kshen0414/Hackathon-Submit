import 'package:education_app/screen/subjects/math/digit_recognise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:education_app/widgets/header.dart';

import '../../../constants/const.dart';
import '../../worksheet/worksheet_generator_screen.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({Key? key}) : super(key: key);

  @override
  _MathScreenState createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
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
                  horizontal: Constants.mainPadding,
                  vertical: Constants.mainPadding,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Constants.mainPadding,
                  vertical: Constants.mainPadding,
                ),
                height: 44,
                width: 44,
                // child: ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.zero,
                //     backgroundColor: Colors.white.withOpacity(0),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     elevation: 0,
                //   ),
                //   child: Icon(Icons.menu, color: Colors.white),
                //   onPressed: () {
                //     // Add menu functionality here
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Header(), // Using the same Header widget as HomeScreen
          Padding(
            padding: EdgeInsets.all(Constants.mainPadding),
            child: Column(
              // Changed from ListView to Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),

                // Title Section
                Text(
                  "Mathematics\nLearning",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: Constants.mainPadding * 2),

                // Content Container
                Expanded(
                  // Added Expanded to fill remaining space
                  child: Container(
                    padding: EdgeInsets.all(Constants.mainPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      // Only the cards are scrollable
                      child: Column(
                        // Changed from ListView to Column
                        children: <Widget>[
                          _buildCard(
                            title: "Addition",
                            subtitle: "Learn basic addition",
                            icon: Icons.add_circle_outline,
                            color: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorksheetGeneratorScreen(
                                    initialOperation:
                                        'Addition', // Add this parameter to WorksheetGeneratorScreen
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            title: "Subtraction",
                            subtitle: "Master number differences",
                            icon: Icons.remove_circle_outline,
                            color: Colors.red,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorksheetGeneratorScreen(
                                    initialOperation: 'Subtraction',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            title: "Multiplication",
                            subtitle: "Mutliply numbers confidently",
                            icon: Icons.close,
                            color: Colors.green,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorksheetGeneratorScreen(
                                    initialOperation: 'Multiplication',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            title: "Division",
                            subtitle: "Learn to divide numbers",
                            icon: CupertinoIcons.divide,
                            color: Colors.orange,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorksheetGeneratorScreen(
                                    initialOperation: 'Division',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            title: "Math Recognition",
                            subtitle: "Identify mathematical numbers",
                            icon: Icons.draw_outlined,
                            color: Colors.purple,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DigitRecognise(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Constants.mainPadding),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: EdgeInsets.all(Constants.mainPadding),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: Constants.mainPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constants.textDark,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Constants.textDark.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Constants.textDark.withOpacity(0.7), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
