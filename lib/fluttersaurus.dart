import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class Fluttersaurus extends StatelessWidget {
  const Fluttersaurus({
    required ThesaurusRepository thesaurusRepository,
    super.key,
  }) : _thesaurusRepository = thesaurusRepository;

  final ThesaurusRepository _thesaurusRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _thesaurusRepository,
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
          ),
          textTheme: GoogleFonts.abrilFatfaceTextTheme(),
        ),
        home: const SearchPage(),
      ),
    );
  }
}
