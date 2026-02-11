import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/app_theme.dart';

class HomeDrawer extends StatelessWidget {
  VoidCallback onGoToHomeClicked;
  
  HomeDrawer({required this.onGoToHomeClicked});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      color: AppTheme.black,
      width: screenWidth * 0.7,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            color: AppTheme.white,
            width: double.infinity,
            alignment: .center,
            child: Text(
              'News App',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: .bold,
                color: AppTheme.black,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    onGoToHomeClicked();
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/home.svg',
                        height: 24,
                        width: 24,
                        fit: .scaleDown,
                      ),
                      SizedBox(width: 8),
                      Text('Go To Home', style: textTheme.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
