import 'package:flutter/material.dart';
import 'package:news_app/widgets/error_indicator.dart';
import 'package:news_app/widgets/loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebview extends StatefulWidget {
  
  final String url;
  NewsWebview(this.url);

  @override
  State<NewsWebview> createState() => _NewsWebviewState();
}

class _NewsWebviewState extends State<NewsWebview> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool hasError = false;
  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (_) {
            setState(() {
              isLoading = false;
              hasError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          if (isLoading) LoadingIndicator(),
          if (hasError) ErrorIndicator(),
          WebViewWidget(controller: _controller), 
          
        ],
      ),
    ),
  );
  }
}
