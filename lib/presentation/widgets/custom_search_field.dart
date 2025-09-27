import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final String labelText;
  final String hintText;

  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            searchController.clear();
            onSearchChanged('');
          },
        ),
      ),
    );
  }
}
