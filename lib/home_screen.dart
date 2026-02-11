import 'package:flutter/material.dart';
import 'package:news_app/categories/categories_view.dart';
import 'package:news_app/drawer/home_drawer.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/news/news_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory == null ? 'Home' : selectedCategory!.name),
      ),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(categoryId: selectedCategory!.id),
      drawer: HomeDrawer(onGoToHomeClicked: resetSelectedCategory),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
