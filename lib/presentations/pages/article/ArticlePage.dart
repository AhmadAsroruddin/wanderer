import 'package:flutter/material.dart';
import 'package:wanderer/presentations/pages/article/search_bar_article.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'ArticleComponent.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Center(
                    child: SearchBarHome(
                      isCamper: true,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child:
                Column(
                  children: <Widget>[
                    ArticleComponent(
                      title: 'ARTIKEL 1',
                      imgUrl: 'https://th.bing.com/th/id/OIP.DJ_CvFricUifuoqhTZmqFwHaEy?w=281&h=180&c=7&r=0&o=5&pid=1.7',
                      articleUrl: 'https://reddit.com/',
                    ),
                    ArticleComponent(
                      title: 'ARTIKEL 2',
                      imgUrl: 'https://ih1.redbubble.net/image.1007574517.1289/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
                      articleUrl: 'https://youtube.com/',
                    ),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}