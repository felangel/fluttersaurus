import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  const Suggestion(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}
