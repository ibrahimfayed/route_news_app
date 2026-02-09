import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel category;
  int index;
  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: screenHeight * 0.25,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/${category.imageName}.png',
            height: double.infinity,
            width: double.infinity,
            fit: .fill,
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            top: 50,
            start: index.isOdd ? screenWidth * 0.13 : null,
            end: index.isEven ? screenWidth * 0.13 : null,
            child: Text(category.name, style: textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
