import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  // Make this static and final to ensure it's initialized properly
  static final List<({String title, String content})> details = [
  ( 
    title: 'How does Cerah stand out?',  // Shortened title
    content: 'Cerah offers a free AI chatbot for students, offline-first functionality for rural areas, unlimited math worksheet generation, and interactive math learning through on-screen drawing features.',  // More concise content
  ),

  (
    title: 'Why the name Cerah?',
    content: 'Cerah is inspired from the Malay word which means "light" – symbolizing hope for underserved rural communities.',  // Simplified
  ),

  (
    title: 'What is Cerah\'s partnership potential?',  // Shortened title
    content: '''Our key collaborations include:

1. Teach For Malaysia: 400+ teachers, 150,000+ students
2. Ministry of Education: 10,000+ schools, 5M students
3. AIESEC Malaysia: NGO Networks across 126+ countries
4. Chumbaka: STEM education programs

These partnerships boost our growth and rural education impact.''',  // Reformatted for better mobile display
  ),

  (
    title: 'What subjects are covered?',  // Shortened title
    content: '''Available subjects:
1. Mathematics (math recognition, worksheets)
2. English (free ebooks)
3. Bahasa Malaysia (kata nama am, kata nama khas, kata tunjuk)''',
  ),

  (
    title: 'Is the app free?',  // Shortened title
    content: 'Yes! Cerah is completely free, making quality education accessible to all Malaysian primary school students.',
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "FAQ",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top + 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white70,
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ShadAccordion<({String title, String content})>.multiple(
                  children: details
                      .map(
                        (detail) => ShadAccordionItem(
                          value: detail,
                          title: Text(
                            detail.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              detail.content,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
