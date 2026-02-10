import 'package:flutter/material.dart';
import 'package:news_app/news/news_view.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: NewsView(),
    );
  }
}
