import 'package:flutter/material.dart';
import 'package:fluttersaurus/search/search.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                  style: textTheme.headline4.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              // TODO: Provide SearchBloc
              child: SearchForm(),
            ),
          ],
        ),
      ),
    );
  }
}
