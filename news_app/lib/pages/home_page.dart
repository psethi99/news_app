import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/news_model.dart';
import '../viewmodel/news_viewmodel.dart';
import 'detail_page.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late Future<List<News>> _newsFuture;
  int _current = 0;
  late TabController _tabController;
  List<News> _favoriteNews = [];

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsViewModel().getNews();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'News App',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All News'),
            Tab(text: 'Business'),
            Tab(text: 'Sports'),
            Tab(text: 'Politics'),
          ],
          indicatorColor: Colors.orange,
          labelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(4, (index) {
          return _buildNewsList(index);
        }),
      ),
    );
  }

  Widget _buildNewsList(int index) {
    return FutureBuilder(
      future: _newsFuture,
      builder: (context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final newsList = snapshot.data!;
          return Column(
            children: [
              _buildImageSlider(context, newsList),
              Expanded(
                child: ListView.separated(
                  itemCount: newsList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 30);
                  },
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      leading: Container(
                        width: 100,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(news.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(news.title),
                      trailing: IconButton(
                        icon: Icon(
                          _isFavorite(news)
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color:
                              _isFavorite(news) ? Colors.orange : Colors.grey,
                        ),
                        onPressed: () {
                          _toggleFavorite(news);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionPage(news: news),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildImageSlider(BuildContext context, List<News> newsList) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            viewportFraction: 0.8, // Adjust as needed
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: newsList.map((news) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DescriptionPage(news: news),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(news.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              news.title,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: newsList.map((news) {
            int index = newsList.indexOf(news);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.orange : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _isFavorite(News news) {
    return _favoriteNews.contains(news);
  }

  void _toggleFavorite(News news) {
    setState(() {
      if (_favoriteNews.contains(news)) {
        _favoriteNews.remove(news);
      } else {
        _favoriteNews.add(news);
      }
    });
  }
}
