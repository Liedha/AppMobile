import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Path gambar latar belakang
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Lapisan semi transparan
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Konten register
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Memusatkan vertikal konten
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white), // Warna label
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0), // Border radius
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.white), // Icon di sebelah kiri input
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3), // Warna latar input
                    ),
                    style: TextStyle(color: Colors.white), // Warna teks input
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await loginViewModel.register(emailController.text, passwordController.text);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50), // Padding tombol
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18), // Ukuran teks tombol
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
