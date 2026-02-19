import 'package:flutter/material.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/models/news_response/news.dart';
import 'package:news_app/news/news_webview.dart';
import 'package:news_app/widgets/default_elevated_buttom.dart';

class NewsButtomSheet extends StatelessWidget {
  final News news;
  NewsButtomSheet(this.news);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      height: screenHeight * 0.5,
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
              news.urlToImage ??
                  'https://tse1.mm.bing.net/th/id/OIP.TdX9D7lAgnLjiFIgHvflfAHaHa?cb=defcache2&defcache=1&rs=1&pid=ImgDetMain&o=7&rm=3',
              height: screenHeight * 0.25,
              width: double.infinity,
              fit: .fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            news.content ?? '',
            style: textTheme.labelMedium!.copyWith(color: AppTheme.black),
          ),
          Spacer(),
          DefaultElevatedButtom(
            label: 'View Full Articel',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsWebview(news.url??''),
                ),
              );
            },
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
