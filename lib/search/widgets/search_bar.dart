import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    this.onChanged,
    this.trailing,
    this.controller,
  }) : super(key: key);

  final ValueSetter<String> onChanged;
  final Widget trailing;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.roboto(),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: trailing,
        hintText: 'search here',
        hintStyle: GoogleFonts.roboto(),
      ),
      onChanged: onChanged,
    );
  }
}
