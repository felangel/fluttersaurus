import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersaurus/search/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

class Fluttersaurus extends StatelessWidget {
  const Fluttersaurus({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ThesaurusRepository(),
      dispose: (repository) => repository.dispose(),
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
