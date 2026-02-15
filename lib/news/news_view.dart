import 'package:flutter/material.dart';
import 'package:news_app/api/api_services.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:news_app/models/sources_response/source.dart';
import 'package:news_app/models/sources_response/sources_response.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/news/tab_item.dart';
import 'package:news_app/widgets/error_indicator.dart';
import 'package:news_app/widgets/loading_indicator.dart';

class NewsView extends StatefulWidget {
  String categoryId;
  NewsView({required this.categoryId});
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
   late Future<SourcesResponse>getSourcesFuture = APIServices.getSources(widget.categoryId,);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourcesFuture, //future i want to listen the changes on it
      builder: (context, snapshot) {
        if (snapshot.connectionState == .waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
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
                child: FutureBuilder(
                  future: APIServices.getNews(sources[currentIndex].id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == .waiting) {
                      return LoadingIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> newsList = snapshot.data?.newsList ?? [];
                      return ListView.separated(
                        itemBuilder: (context, index) => NewsItem(newsList[index]),
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: newsList.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
