import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(this.news);
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    DateTime dateTime = DateTime.now().subtract(Duration(minutes: 20));
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.white),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              news.urlToImage??'https://tse1.mm.bing.net/th/id/OIP.TdX9D7lAgnLjiFIgHvflfAHaHa?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3',
              height: screenHeight * 0.25,
              width: double.infinity,
              fit: .fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            news.title ?? '',
            style: textTheme.titleSmall,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('By : ${news.source?.name??''}', style: textTheme.labelSmall),
              Text(timeago.format(news.publishedAt ?? DateTime.now()), style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
