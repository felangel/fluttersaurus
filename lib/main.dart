import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttersaurus/bloc_observer.dart';
import 'package:fluttersaurus/fluttersaurus.dart';
import 'package:thesaurus_repository/thesaurus_repository.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = FluttersaurusBlocObserver();
  runApp(
    Fluttersaurus(
      thesaurusRepository: ThesaurusRepository(),
    ),
  );
}
