import 'package:flutter/material.dart';
import 'package:fluttersaurus/search/search.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    Key? key,
    required this.onTap,
    this.suggestions = const <Suggestion>[],
  }) : super(key: key);

  final ValueSetter<Suggestion> onTap;
  final List<Suggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) => _SearchResult(
        suggestion: suggestions[index],
        onTap: () => onTap(suggestions[index]),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    Key? key,
    required this.suggestion,
    required this.onTap,
  }) : super(key: key);

  final Suggestion suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      title: Text(suggestion.value),
      onTap: onTap,
    );
  }
}
