// lib/screens/subjects/malay/malay_screen.dart
import 'package:flutter/material.dart';

import '../../../model/malay_words.dart';
import 'word_game_screen.dart';

class MalayScreen extends StatefulWidget {
  const MalayScreen({Key? key}) : super(key: key);

  @override
  State<MalayScreen> createState() => _MalayScreenState();
}

class _MalayScreenState extends State<MalayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text('Let\'s learn Malay'),
        // backgroundColor: Colors.purple,
        backgroundColor: Colors.white,
        title: const Text(
          'Let\'s learn Malay',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Choose a category to play',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categoryList[index],
                  onTap: () =>
                      _navigateToGame(context, categoryList[index].category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToGame(BuildContext context, WordCategory category) {
    // Changed parameter type
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WordGameScreen(category: category), // Now passing WordCategory
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryInfo category;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12), // Reduced padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category.color,
                category.color.withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Added this
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                size: 40, // Reduced size
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              FittedBox(
                // Added FittedBox
                fit: BoxFit.scaleDown,
                child: Text(
                  category.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                // Added FittedBox
                fit: BoxFit.scaleDown,
                child: Text(
                  category.subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12, // Reduced font size
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                // Changed to Expanded
                child: Text(
                  category.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10, // Reduced font size
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
