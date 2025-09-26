import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttersaurus/bloc_observer.dart';
import 'package:fluttersaurus/fluttersaurus.dart';

void main() {
  Bloc.observer = FluttersaurusBlocObserver();
  runApp(const Fluttersaurus());
}
