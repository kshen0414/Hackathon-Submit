import 'package:flutter/material.dart';

/// A widget that allows pages to be flipped like a book.
class PageFlipWidget extends StatefulWidget {
  const PageFlipWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 450),
    this.cutoffForward = 0.8,
    this.cutoffPrevious = 0.1,
    this.backgroundColor = Colors.white,
    required this.children,
    this.initialIndex = 0,
    this.lastPage,
    this.isRightSwipe = false,
    this.onPageChanged,  // Add this callback
  })  : assert(initialIndex < children.length, 'initialIndex cannot be greater than children length'),
        super(key: key);

  final Duration duration;
  final double cutoffForward;
  final double cutoffPrevious;
  final Color backgroundColor;
  final List<Widget> children;
  final int initialIndex;
  final Widget? lastPage;
  final bool isRightSwipe;
  final ValueChanged<int>? onPageChanged;  // Add this callback

  @override
  PageFlipWidgetState createState() => PageFlipWidgetState();
}

class PageFlipWidgetState extends State<PageFlipWidget> with TickerProviderStateMixin {
  late List<Widget> pages;
  late List<AnimationController> _controllers;
  int pageNumber = 0;
  bool? _isForward;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    _initializePages();
    _initializeControllers();
    pageNumber = widget.initialIndex;
    // Notify initial page
    widget.onPageChanged?.call(pageNumber);
  }

  void _initializePages() {
    pages = List.from(widget.children);
    if (widget.lastPage != null) {
      pages.add(widget.lastPage!);
    }
  }

  void _initializeControllers() {
    _controllers = List.generate(
      pages.length,
      (index) => AnimationController(
        value: 1.0,
        duration: widget.duration,
        vsync: this,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get _isLastPage => pageNumber == pages.length - 1;
  bool get _isFirstPage => pageNumber == 0;

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!isDragging) return;
    
    final ratio = details.delta.dx / context.size!.width;
    
    if (_isForward == null) {
      if (widget.isRightSwipe ? details.delta.dx < 0.0 : details.delta.dx > 0.0) {
        _isForward = false;
      } else if (widget.isRightSwipe ? details.delta.dx > 0.2 : details.delta.dx < -0.2) {
        _isForward = true;
      }
    }

    if (_isForward == true || pageNumber == 0) {
      if (!_isLastPage) {
        setState(() {
          widget.isRightSwipe 
              ? _controllers[pageNumber].value -= ratio 
              : _controllers[pageNumber].value += ratio;
        });
      }
    } else {
      if (!_isFirstPage) {
        setState(() {
          widget.isRightSwipe 
              ? _controllers[pageNumber - 1].value += ratio 
              : _controllers[pageNumber - 1].value -= ratio;
        });
      }
    }
  }

  Future<void> _handleDragEnd(DragEndDetails details) async {
    isDragging = false;
    
    if (_isForward == null) return;

    if (_isForward == true) {
      if (!_isLastPage && _controllers[pageNumber].value <= widget.cutoffForward) {
        await nextPage();
      } else if (!_isLastPage) {
        await _controllers[pageNumber].forward();
      }
    } else {
      if (!_isFirstPage && _controllers[pageNumber - 1].value >= widget.cutoffPrevious) {
        await previousPage();
      } else {
        if (_isFirstPage) {
          await _controllers[pageNumber].forward();
        } else {
          await _controllers[pageNumber - 1].reverse();
        }
      }
    }

    _isForward = null;
  }

  Future<void> nextPage() async {
    if (_isLastPage) return;

    await _controllers[pageNumber].reverse();
    if (mounted) {
      setState(() {
        pageNumber++;
        // Notify page change
        widget.onPageChanged?.call(pageNumber);
      });
    }
  }

  Future<void> previousPage() async {
    if (_isFirstPage) return;

    await _controllers[pageNumber - 1].forward();
    if (mounted) {
      setState(() {
        pageNumber--;
        // Notify page change
        widget.onPageChanged?.call(pageNumber);
      });
    }
  }

  Future<void> goToPage(int index) async {
    if (index < 0 || index >= pages.length || index == pageNumber) return;

    final direction = index > pageNumber;
    final start = direction ? pageNumber : index;
    final end = direction ? index : pageNumber;

    for (var i = start; direction ? i < end : i > end; i += direction ? 1 : -1) {
      if (direction) {
        await _controllers[i].reverse();
      } else {
        await _controllers[i - 1].forward();
      }
    }

    if (mounted) {
      setState(() {
        pageNumber = index;
        // Notify page change
        widget.onPageChanged?.call(pageNumber);
      });
    }
  }

  int getCurrentPage() {
    return pageNumber;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (_) => isDragging = true,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      onHorizontalDragCancel: () {
        isDragging = false;
        _isForward = null;
      },
      child: Stack(
        fit: StackFit.expand,
        children: List.generate(pages.length, (index) {
          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              final t = _controllers[index].value;
              final rotationAngle = widget.isRightSwipe ? -t * 1.5708 : t * 1.5708;
              
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotationAngle),
                alignment: widget.isRightSwipe ? Alignment.centerRight : Alignment.centerLeft,
                child: child,
              );
            },
            child: Container(
              color: widget.backgroundColor,
              child: pages[index],
            ),
          );
        }).reversed.toList(),
      ),
    );
  }
}