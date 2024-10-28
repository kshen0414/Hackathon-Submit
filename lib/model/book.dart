class Book {
  final String title;
  final String author;
  final String coverImage;
  final String description;
  final String pdfPath;

  Book({
    required this.title,
    required this.author,
    required this.coverImage,
    required this.description,
    required this.pdfPath,
  });
}

final List<Book> englishBooks = [
  Book(
    title: 'Do You Wonder About Rain, Snow, Sleet and Hail',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/01-book.png',
    description: 'Science has never been so much fun. All that a child needs to know about water, rain, hail, sleet and water cycle.',
    pdfPath: 'assets/books_pdf/01-book.pdf',
  ),
  Book(
    title: 'Doing my Chores',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/02-book.png',
    description: 'Read how a little girl makes chores fun and easy to do',
    pdfPath: 'assets/books_pdf/02-book.pdf',
  ),
  Book(
    title: 'Hammy the Hamster',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/03-book.png',
    description: 'He’s got swag. He wears a tux. He’s a hipster hamster who likes to live free.',
    pdfPath: 'assets/books_pdf/03-book.pdf',
  ),
  Book(
    title: 'Abe the Service Dog',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/04-book.png',
    description: 'Abe was a real Service Dog who dedicated his life assisting BJ, a good family friend.',
    pdfPath: 'assets/books_pdf/04-book.pdf',
  ),
  Book(
    title: 'A Trick Trike',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/05-book.png',
    description: 'Little Ross was sad. He didn’t have a nice tricycle like all the other children. All he had was an old trike',
    pdfPath: 'assets/books_pdf/05-book.pdf',
  ),
  Book(
    title: 'The Lunker',
    author: 'T. Albert',
    coverImage: 'assets/books_pdf_cover/06-book.png',
    description: 'Monday through Saturday was dad’s to take but come Sunday, the lad caught a lunker.',
    pdfPath: 'assets/books_pdf/06-book.pdf',
  ),



  // Add more books as needed
];