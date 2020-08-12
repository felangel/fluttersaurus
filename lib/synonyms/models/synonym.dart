import 'package:equatable/equatable.dart';

class Synonym extends Equatable {
  const Synonym(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}
