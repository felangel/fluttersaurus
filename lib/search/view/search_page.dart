import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/icons/fluttersaurus.png', width: 48),
                const SizedBox(width: 8),
                Text(
                  'Fluttersaurus',
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: BlocProvider(
                create: (context) => SearchBloc(
                  context.read<ThesaurusRepository>(),
                ),
                child: const SearchForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
