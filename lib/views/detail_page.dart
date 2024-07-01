import 'package:flutter/material.dart';
import '../models/inspiration.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Inspiration inspiration = ModalRoute.of(context)!.settings.arguments as Inspiration;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inspiration Detail'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade500, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                inspiration.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "- ${inspiration.author} -",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
