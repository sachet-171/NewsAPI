import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'service_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService _newsService = NewsService();
  List<dynamic>? _newsArticles;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final articles = await _newsService.fetchNews('us'); // Change the country code as needed
    setState(() {
      _newsArticles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: Center(
        child: _newsArticles == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _newsArticles!.length,
                itemBuilder: (context, index) {
                  final article = _newsArticles![index];
                  return ListTile(
                    title: Text(article['title'] ?? 'No Title'),
                    subtitle: Text(article['description'] ?? 'No Description'),
                    onTap: () {
                      if (article['url'] != null) {
                        _launchURL(article['url']);
                      }
                    },
                  );
                },
              ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
