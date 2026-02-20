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
//////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:news_app/api/api_services.dart';
// import 'package:news_app/app_theme.dart';
// import 'package:news_app/models/news_response/news.dart';
// import 'package:news_app/models/sources_response/source.dart';
// import 'package:news_app/models/sources_response/sources_response.dart';
// import 'package:news_app/news/news_item.dart';
// import 'package:news_app/news/tab_item.dart';
// import 'package:news_app/widgets/error_indicator.dart';
// import 'package:news_app/widgets/loading_indicator.dart';

// class NewsView extends StatefulWidget {
//   final String categoryId;
//   const NewsView({required this.categoryId});

//   @override
//   State<NewsView> createState() => _NewsViewState();
// }

// class _NewsViewState extends State<NewsView> {

//   // ─── Sources ────────────────────────────────────────────────────────────────
//   int currentIndex = 0;
//   late Future<SourcesResponse> getSourcesFuture =
//       APIServices.getSources(widget.categoryId);

//   // ─── News / Pagination State ─────────────────────────────────────────────── 
//   // EN: These variables hold everything about the current news list.
//   // AR: المتغيرات دي بتحتفظ بكل حاجة خاصة بالأخبار الحالية.
  
//   List<News> _newsList = [];        // الأخبار المتراكمة
//   int _currentPage = 1;            // الصفحة الحالية
//   bool _isLoadingFirst = false;    // هل بيتحمل أول صفحة؟
//   bool _isLoadingMore = false;     // هل بيتحمل صفحة إضافية؟
//   bool _hasMoreData = true;        // هل في صفحات تانية؟
//   String? _loadedSourceId;         // الـ source اللي اتحمل
//   static const int _pageSize = 10;

//   // ─── Scroll ───────────────────────────────────────────────────────────────── 
//   final ScrollController _scrollController = ScrollController();

//   // ────────────────────────────────────────────────────────────────────────────

//   @override
//   void initState() {
//     super.initState();
//     // EN: Listen to scroll — when near bottom, load next page.
//     // AR: نستمع للـ scroll — لما نوصل قرب الآخر، نجيب الصفحة الجاية.
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }

//   // EN: Fires every scroll event. Triggers load more when 200px from bottom.
//   // AR: بتتنفذ عند كل حركة scroll. بتطلب المزيد لما نكون على بُعد 200px من الآخر.
//   void _onScroll() {
//     final pos = _scrollController.position;
//     if (pos.pixels >= pos.maxScrollExtent - 200) {
//       _loadMoreNews();
//     }
//   }

//   // EN: Called when user taps a source tab.
//   //     Resets everything and loads page 1 for the new source.
//   // AR: بتتنفذ لما المستخدم يضغط على تاب المصدر.
//   //     بتعيد كل حاجة وتجيب الصفحة الأولى للمصدر الجديد.
//   Future<void> _loadSourceNews(String sourceId) async {
//     // EN: Don't reload if the user tapped the same source again.
//     // AR: متحملش تاني لو المستخدم ضغط على نفس المصدر.
//     if (_loadedSourceId == sourceId) return;

//     setState(() {
//       _newsList = [];
//       _currentPage = 1;
//       _hasMoreData = true;
//       _isLoadingFirst = true;
//       _loadedSourceId = sourceId;
//     });

//     try {
//       final response = await APIServices.getNews(
//         sourceId,
//         page: 1,
//         pageSize: _pageSize,
//       );
//       final articles = response.newsList ?? [];
//       setState(() {
//         _newsList = articles;
//         _hasMoreData = articles.length == _pageSize;
//         _isLoadingFirst = false;
//       });
//     } catch (_) {
//       setState(() => _isLoadingFirst = false);
//     }
//   }

//   // EN: Appends the next page to the existing list.
//   //     Guards against duplicate calls or unnecessary fetches.
//   // AR: بتضيف الصفحة الجاية للقائمة الموجودة.
//   //     بتحمي من الاستدعاء المكرر أو الجلب غير الضروري.
//   Future<void> _loadMoreNews() async {
//     if (_isLoadingMore || _isLoadingFirst || !_hasMoreData || _loadedSourceId == null) return;

//     setState(() => _isLoadingMore = true);

//     try {
//       final response = await APIServices.getNews(
//         _loadedSourceId!,
//         page: _currentPage + 1,
//         pageSize: _pageSize,
//       );
//       final newArticles = response.newsList ?? [];
//       setState(() {
//         _currentPage++;
//         _newsList.addAll(newArticles);
//         _hasMoreData = newArticles.length == _pageSize;
//         _isLoadingMore = false;
//       });
//     } catch (_) {
//       setState(() => _isLoadingMore = false);
//     }
//   }

//   // ────────────────────────────────────────────────────────────────────────────

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<SourcesResponse>(
//       future: getSourcesFuture,
//       builder: (context, snapshot) {

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return LoadingIndicator();
//         } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
//           return ErrorIndicator();
//         }

//         final List<Source> sources = snapshot.data?.sources ?? [];

//         // EN: Auto-load the first source tab when sources are ready.
//         // AR: نحمل أول تاب تلقائياً لما المصادر تكون جاهزة.
//         if (_loadedSourceId == null && sources.isNotEmpty) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _loadSourceNews(sources[0].id!);
//           });
//         }

//         return Column(
//           children: [

//             // ── Tab Bar ────────────────────────────────────────────────────────
//             DefaultTabController(
//               length: sources.length,
//               child: TabBar(
//                 dividerColor: Colors.transparent,
//                 indicatorColor: AppTheme.white,
//                 tabAlignment: TabAlignment.start,
//                 labelPadding: EdgeInsetsDirectional.only(start: 16),
//                 isScrollable: true,
//                 tabs: sources
//                     .map((source) => TabItem(
//                           source: source,
//                           isSelected: currentIndex == sources.indexOf(source),
//                         ))
//                     .toList(),
//                 onTap: (index) {
//                   if (currentIndex == index) return;
//                   setState(() => currentIndex = index);
//                   // EN: Load news for the tapped source ONLY here.
//                   // AR: نجيب أخبار المصدر اللي اتضغط عليه هنا بس.
//                   _loadSourceNews(sources[index].id!);
//                 },
//               ),
//             ),

//             // ── News List ──────────────────────────────────────────────────────
//             Expanded(
//               child: _isLoadingFirst
//                   // EN: Show full-screen loader only on first page load.
//                   // AR: نعرض شاشة تحميل كاملة بس عند تحميل الصفحة الأولى.
//                   ? LoadingIndicator()
//                   : _newsList.isEmpty
//                       ? ErrorIndicator()
//                       : ListView.separated(
//                           controller: _scrollController,
//                           padding: const EdgeInsets.only(
//                               top: 16, left: 16, right: 16),
//                           // EN: +1 for the footer item (spinner or end message).
//                           // AR: +1 عشان عنصر الـ footer (دوارة أو رسالة النهاية).
//                           itemCount: _newsList.length + 1,
//                           separatorBuilder: (_, __) =>
//                               const SizedBox(height: 16),
//                           itemBuilder: (context, index) {

//                             // ── Footer ───────────────────────────────────────
//                             if (index == _newsList.length) {
//                               if (_isLoadingMore) {
//                                 return const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16),
//                                   child: Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 );
//                               }
//                               if (!_hasMoreData) {
//                                 return const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 16),
//                                   child: Center(
//                                     child: Text('No more articles'),
//                                   ),
//                                 );
//                               }
//                               return const SizedBox.shrink();
//                             }

//                             // ── News Item ────────────────────────────────────
//                             return NewsItem(_newsList[index]);
//                           },
//                         ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }