import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/categories/categories_view.dart';
import 'package:news_app/drawer/home_drawer.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/news/view/widgets/news_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: textTheme.titleMedium?.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: textTheme.titleMedium?.copyWith(
                    color: AppTheme.white,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (value) {
                  // TODO: implement search logic
                },
              )
            : Text(
                selectedCategory == null ? 'Home' : selectedCategory!.name,
              ),
        actions: [
          IconButton(
            onPressed: isSearching ? closeSearch : openSearch,
            icon: Icon(isSearching ? Icons.close : Icons.search),
          ),
        ],
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

  void openSearch() {
    isSearching = true;
    setState(() {});
  }

  void closeSearch() {
    isSearching = false;
    _searchController.clear();
    setState(() {});
  }
}