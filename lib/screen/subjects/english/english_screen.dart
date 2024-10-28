import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_flip/page_flip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class EnglishScreen extends StatefulWidget {
  final String pdfPath;

  const EnglishScreen({
    Key? key,
    required this.pdfPath,
  }) : super(key: key);

  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  List<Widget> pdfPages = [];
  bool isLoading = true;
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  void dispose() {
    currentPage.dispose();
    super.dispose();
  }

  Future<String> get _cacheDir async {
    final dir = await getTemporaryDirectory();
    final cacheDir = Directory('${dir.path}/pdf_cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create();
    }
    return cacheDir.path;
  }

  Future<void> loadPdf() async {
    setState(() {
      isLoading = true;
    });

    try {
      final cacheDirectory = await _cacheDir;
      // Use the filename from the path as cache directory name
      final pdfName = widget.pdfPath.split('/').last.split('.').first;
      final pdfCacheDir = Directory('$cacheDirectory/$pdfName');

      if (!await pdfCacheDir.exists()) {
        await pdfCacheDir.create();
      }

      // Check if cached pages exist
      final cachedPages = await pdfCacheDir.list().toList();
      if (cachedPages.isNotEmpty) {
        // Load cached pages
        final sortedPages = cachedPages.whereType<File>().toList()
          ..sort((a, b) => int.parse(a.path.split('/').last.split('.').first)
              .compareTo(int.parse(b.path.split('/').last.split('.').first)));

        for (var pageFile in sortedPages) {
          if (mounted) {
            setState(() {
              pdfPages.add(
                Container(
                  color: Colors.white,
                  child: Image.file(
                    pageFile,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            });
          }
        }
        setState(() {
          isLoading = false;
        });
        return;
      }

      // If no cache exists, load and cache the PDF
      final ByteData data = await rootBundle.load(widget.pdfPath);
      final bytes = data.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp.pdf');
      await tempFile.writeAsBytes(bytes);

      final document = await PdfDocument.openFile(tempFile.path);
      final pageCount = await document.pagesCount;

      // Convert and cache each page
      for (var i = 0; i < pageCount; i++) {
        final page = await document.getPage(i + 1);
        final pageImage = await page.render(
          width: page.width * 2,
          height: page.height * 2,
          format: PdfPageImageFormat.jpeg,
          backgroundColor: '#ffffff',
        );
        await page.close();

        if (pageImage != null) {
          // Cache the page image
          final pageFile = File('${pdfCacheDir.path}/$i.jpg');
          await pageFile.writeAsBytes(pageImage.bytes);

          if (mounted) {
            setState(() {
              pdfPages.add(
                Container(
                  color: Colors.white,
                  child: Image.file(
                    pageFile,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            });
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading PDF: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
          pdfPages = [
            Center(
              child: Text('Error loading PDF: $e'),
            )
          ];
        });
      }
    }
  }

  void _updatePageNumber() {
    if (_controller.currentState != null) {
      currentPage.value = _controller.currentState!.pageNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
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
                  child:
                      const Icon(Icons.keyboard_backspace, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF487CFC),
              const Color(0xFF487CFC).withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: PageFlipWidget(
                              key: _controller,
                              backgroundColor: Colors.white,
                              duration: const Duration(milliseconds: 450),
                              cutoffForward: 0.8,
                              cutoffPrevious: 0.1,
                              initialIndex: 0,
                              lastPage: Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'The End',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF487CFC),
                                    ),
                                  ),
                                ),
                              ),
                              children: pdfPages,
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPage,
                              builder: (context, value, child) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                );
                              },
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
}
