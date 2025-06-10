import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.onChanged,
    super.key,
  });

  final ValueSetter<String> onChanged;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('searchBar_textField'),
      controller: _controller,
      style: GoogleFonts.roboto(),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _clear,
              )
            : null,
        hintText: 'search here',
        hintStyle: GoogleFonts.roboto(),
      ),
      onChanged: _onChange,
    );
  }

  void _onChange(String value) {
    widget.onChanged(value);
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    _onChange('');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
