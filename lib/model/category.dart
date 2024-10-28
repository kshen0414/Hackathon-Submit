// lib/model/category.dart

enum SubjectType {
  math,
  english,
  malay,
  science
}

class Category {
  final String name;
  final String thumbnail;
  final int noOfCourses;
  final SubjectType subjectType;
  final bool isAvailable;  // to show availability

  Category({
    required this.name,
    required this.thumbnail,
    required this.noOfCourses,
    required this.subjectType,
    this.isAvailable = true,  // defaults to true
  });
}

final List<Category> categoryList = [
  Category(
    name: 'Math',
    thumbnail: 'assets/images/math2.png', // Update with your asset path
    noOfCourses: 5,
    subjectType: SubjectType.math,
  ),
  Category(
    name: 'English',
    thumbnail: 'assets/images/english.png', // Update with your asset path
    noOfCourses: 6,
    subjectType: SubjectType.english,
  ),
  Category(
    name: 'Malay',
    thumbnail: 'assets/images/malay2.png', // Update with your asset path
    noOfCourses: 5,
    subjectType: SubjectType.malay,
  ),
  Category(
    name: 'Science',
    thumbnail: 'assets/images/science2.png', // Update with your asset path
    noOfCourses: 0,
    subjectType: SubjectType.science,
    isAvailable: false,
  ),
];