import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearchButton;
  final bool showLogoutButton; // Tambahkan parameter untuk tombol logout

  CustomAppBar({
    required this.title,
    this.showSearchButton = true,
    this.showLogoutButton = true, // Inisialisasi tombol logout
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (showSearchButton)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              debugPrint(context.toString()); // Periksa konteks di sini
              Navigator.pushNamed(context, '/search');
            },
          ),

        if (showLogoutButton)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
