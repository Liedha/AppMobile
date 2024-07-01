import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay untuk menampilkan splash screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke halaman home setelah splash
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purpleAccent.shade100,
          image: DecorationImage(
            image: AssetImage('assets/logo.jpg'), // Ganti dengan path yang sesuai dengan logo Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Daily Inspiration',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
