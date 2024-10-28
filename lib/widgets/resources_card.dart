// lib/widgets/resource_card.dart
import 'package:flutter/material.dart';
import 'package:education_app/model/category.dart';
import 'package:education_app/constants/size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResourceCard extends StatelessWidget {
  final Category category;
  const ResourceCard({
    Key? key,
    required this.category,
  }) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
                width: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(height: 10),
            Text(category.name),
            Text(
              "${category.noOfCourses.toString()} resources",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSubject(BuildContext context, SubjectType subjectType) {
    // Your existing navigation code
  }
}