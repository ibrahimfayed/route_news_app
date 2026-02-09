import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/home_screen.dart';

void main() {
  runApp(RouteNewsApp());
}

class RouteNewsApp extends StatelessWidget {
  const RouteNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     routes: {
      HomeScreen.routeName:(_)=>HomeScreen()
     },
     initialRoute: HomeScreen.routeName,
     theme: AppTheme.lightTheme,
     darkTheme: AppTheme.darkTheme,
     themeMode: .dark, 
    );
  }
}