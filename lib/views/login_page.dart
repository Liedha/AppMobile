import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
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
                image: AssetImage('assets/logo.jpg'), // Path gambar latar belakang
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Lapisan semi transparan
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Konten login
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
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Email harus diisi')),
                        );
                        return;
                      }
                      bool success = await loginViewModel.login(emailController.text, passwordController.text);
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Failed')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50), // Padding tombol
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18), // Ukuran teks tombol
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Belum punya akun? Daftar',
                      style: TextStyle(color: Colors.white), // Warna teks tombol register
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
