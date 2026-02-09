import 'package:flutter/material.dart';
import 'package:news_app/categories/category_item.dart';
import 'package:news_app/models/category_model.dart';

class CategoriesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Good Morning\nHere is Some News For You',
              style: textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(top: 16),
                itemBuilder: (_, index) => CategoryItem(
                  category: CategoryModel.categories[index],
                  index: index,
                ),

                itemCount: CategoryModel.categories.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
              ),
            ),
          ],
        ),
      );
  }
}