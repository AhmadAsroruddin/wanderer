import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/presentations/bloc/article_bloc.dart';
import 'package:wanderer/presentations/pages/article/search_bar_article.dart';
import 'package:wanderer/presentations/shared/theme.dart';
import 'ArticleComponent.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    context.read<ArticleCubit>().getArticle(false, "");
    return SafeArea(
      child: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          return Scaffold(
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
                          isArticle: true,
                        ),
                      )
                    ],
                  ),
                ),
                if (state is ArticleSuccess)
                  SizedBox(
                    height: deviceHeight * 0.5,
                    width: deviceWidth,
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return ArticleComponent(
                          title: state.data[index].title.toString(),
                          articleUrl: state.data[index].url,
                          imgUrl: state.data[index].photoUrl,
                        );
                      },
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
