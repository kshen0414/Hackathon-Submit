import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String) onSearch;
  final FocusNode focusNode; // Add FocusNode parameter

  const SearchTextField({
    Key? key,
    required this.onSearch,
    required this.focusNode, // Require FocusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode, // Use the passed FocusNode
      onChanged: onSearch,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
          size: 26,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search your topic",
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        isDense: true,
      ),
    );
  }
}
