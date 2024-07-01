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
      trailing: inspiration.imageUrl != null
          ? Image.network(inspiration.imageUrl!)
          : null,
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: inspiration);
      },
    );
  }
}
