import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/inspiration_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';
import 'views/home_page.dart';
import 'views/detail_page.dart';
import 'views/login_page.dart';
import 'views/registration_page.dart';
import 'views/search_page.dart';
import 'views/splash_page.dart';


void main() {
  runApp(DailyInspirationApp());
}

class DailyInspirationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InspirationViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'Daily Inspiration',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistrationPage(),
          '/home': (context) => HomePage(),
          '/search': (context) => SearchPage(),
          '/detail': (context) => DetailPage(),
        },
      ),
    );
  }
}
