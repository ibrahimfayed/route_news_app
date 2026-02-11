import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    DateTime dateTime = DateTime.now().subtract(Duration(minutes: 20));
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.white)
        ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/news.png',
              height: screenHeight * 0.25,
              width: double.infinity,
              fit: .fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '40-year-old man falls 200 feet to his death while canyoneering at national park',
            style: textTheme.titleSmall,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('By : Jon Haworth', style: textTheme.labelSmall),
              Text(timeago.format(dateTime), style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
