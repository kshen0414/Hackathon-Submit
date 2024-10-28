import 'package:education_app/constants/color.dart';
import 'package:education_app/constants/size.dart';
import 'package:education_app/screen/subjects/math/math_screen.dart';
import 'package:education_app/screen/subjects/malay/malay_screen.dart';
import 'package:education_app/widgets/search_testfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/category.dart';
import '../subjects/english/english_books_screen.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<Category> filteredCategories = [];
  final FocusNode _searchFocusNode = FocusNode(); // Initialize FocusNode

  @override
  void initState() {
    super.initState();
    filteredCategories = categoryList;
  }

  @override
  void dispose() {
    _searchFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = categoryList;
      } else {
        filteredCategories = categoryList
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus(); // Unfocus the search field
      return false; // Prevent the pop
    }
    return true; // Allow the pop
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: WillPopScope(
        onWillPop: _onWillPop, // Intercept back button
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                onSearch: _handleSearch,
                focusNode: _searchFocusNode, // Pass FocusNode
              ),
              Body(categories: filteredCategories),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final List<Category> categories;

  const Body({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Learning Resources",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Opacity(
                  opacity: 0,
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      "See All",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (categories.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No matches found',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 24,
                ),
                itemBuilder: (context, index) {
                  return ResourceCard(
                    category: categories[index],
                  );
                },
                itemCount: categories.length,
              ),
            ),
        ],
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final Category category;
  const ResourceCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  void _navigateToSubject(BuildContext context, SubjectType subjectType) {
    if (!category.isAvailable) return;

    Widget screen;
    switch (subjectType) {
      case SubjectType.math:
        screen = const MathScreen();
        break;
      case SubjectType.english:
        screen = const EnglishBooksScreen();
        break;
      case SubjectType.malay:
        screen = const MalayScreen();
        break;
      case SubjectType.science:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSubject(context, category.subjectType),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand, // Make stack fill the container
          children: [
            // Base content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Image.asset(
                      category.thumbnail,
                      height: kCategoryCardImageSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.isAvailable
                      ? "${category.noOfCourses.toString()} resources"
                      : "Coming Soon",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
              ],
            ),
            // Coming Soon Overlay
            if (!category.isAvailable)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.6), // Made more transparent
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.5, // About 30 degrees
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 6), // Reduced padding
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Reduced shadow opacity
                              blurRadius: 3,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: const Text(
                          'COMING SOON',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12, // Reduced font size
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1, // Reduced letter spacing
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final void Function(String) onSearch;
  final FocusNode focusNode; // Add FocusNode parameter

  const CustomAppBar({
    Key? key,
    required this.onSearch,
    required this.focusNode, // Require FocusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color(0xff886ff2),
            Color(0xff6849ef),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nWelcome Back User",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SearchTextField(
            onSearch: onSearch,
            focusNode: focusNode, // Pass FocusNode to SearchTextField
          ),
        ],
      ),
    );
  }
}
