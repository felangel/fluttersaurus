import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchBar(
          onChanged: (term) {
            context.read<SearchBloc>().add(SearchTermChanged(term));
          },
        ),
        const SizedBox(height: 16),
        _SearchContent(),
      ],
    );
  }
}

class _SearchContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<SearchBloc, SearchState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SearchStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('oops try again!')),
              );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case SearchStatus.loading:
              return const _SearchLoading();
            case SearchStatus.success:
              return _SearchSuccess(suggestions: state.suggestions);
            default:
              return const _SearchInitial();
          }
        },
      ),
    );
  }
}

class _SearchLoading extends StatelessWidget {
  const _SearchLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      key: const Key('search_loading_shimmer'),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.separated(
        itemBuilder: (context, index) => Container(
          height: 48.0,
          color: Colors.white,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }
}

class _SearchSuccess extends StatelessWidget {
  const _SearchSuccess({Key? key, required this.suggestions}) : super(key: key);

  final List<Suggestion> suggestions;

  @override
  Widget build(BuildContext context) {
    return SearchResults(
      suggestions: suggestions,
      onTap: (suggestion) {
        Navigator.of(context).push<void>(
          SynonymsPage.route(word: suggestion.value),
        );
      },
    );
  }
}

class _SearchInitial extends StatelessWidget {
  const _SearchInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      'Find some fancy words ✨',
      key: const Key('search_initial_text'),
      style: GoogleFonts.roboto(
        textStyle: textTheme.headline6?.copyWith(fontWeight: FontWeight.w300),
      ),
    );
  }
}
