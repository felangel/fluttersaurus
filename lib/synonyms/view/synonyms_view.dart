import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/synonyms/synonyms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SynonymsView extends StatelessWidget {
  const SynonymsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SynonymsCubit, SynonymsState>(
            buildWhen: (previous, current) => previous.word != current.word,
            builder: (context, state) {
              return Text(
                state.word ?? '--',
                style: textTheme.headline2?.copyWith(color: Colors.black87),
              );
            },
          ),
          const SizedBox(height: 24),
          Flexible(
            child: BlocBuilder<SynonymsCubit, SynonymsState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                switch (state.status) {
                  case SynonymsStatus.loading:
                    return const _SynonymsLoading();
                  case SynonymsStatus.success:
                    return _SynonymsSuccess(synonyms: state.synonyms);
                  default:
                    return const _SynonymsFailure();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SynonymsSuccess extends StatelessWidget {
  const _SynonymsSuccess({Key? key, required this.synonyms}) : super(key: key);

  final List<Synonym> synonyms;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      key: const Key('synonyms_success_column'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Synonyms',
          style: textTheme.headline5?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: synonyms.length,
            itemBuilder: (context, index) {
              final synonym = synonyms[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  synonym.value,
                  style: GoogleFonts.robotoCondensed(
                    textStyle: textTheme.headline6,
                  ).copyWith(fontWeight: FontWeight.w100),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _SynonymsLoading extends StatelessWidget {
  const _SynonymsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      key: const Key('synonyms_loading_shimmer'),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [
          Container(height: 48.0, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 300.0, color: Colors.white),
        ],
      ),
    );
  }
}

class _SynonymsFailure extends StatelessWidget {
  const _SynonymsFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('synonyms_failure_center'),
      child: Icon(Icons.warning, color: Colors.redAccent),
    );
  }
}
