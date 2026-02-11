import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/news/tab_item.dart';

class NewsView extends StatefulWidget {
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  List<SourceModel> sources = List.generate(
    10,
    (index) => SourceModel(id: '$index', name: 'Source $index'),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: AppTheme.white,
            tabAlignment: .start,
            labelPadding: EdgeInsetsDirectional.only(start: 16),
            isScrollable: true,
            tabs: sources
                .map(
                  (source) => TabItem(
                    source: source,
                    isSelected: currentIndex == sources.indexOf(source),
                  ),
                )
                .toList(),
            onTap: (index) {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => NewsItem(),
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
