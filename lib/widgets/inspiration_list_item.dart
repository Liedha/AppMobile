import 'package:flutter/material.dart';
import '../models/inspiration.dart';

class InspirationListItem extends StatelessWidget {
  final Inspiration inspiration;

  InspirationListItem({required this.inspiration});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inspiration.text),
      subtitle: Text(inspiration.author),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: inspiration);
      },
    );
  }
}
