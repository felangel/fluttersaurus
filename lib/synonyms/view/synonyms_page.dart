import 'package:flutter/material.dart';

class SynonymsPage extends StatelessWidget {
  const SynonymsPage._({Key key, @required String word})
      : assert(word != null),
        _word = word,
        super(key: key);

  static Route route({@required String word}) {
    return MaterialPageRoute<void>(builder: (_) => SynonymsPage._(word: word));
  }

  final String _word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_word)),
      body: const Center(child: Placeholder()),
    );
  }
}
