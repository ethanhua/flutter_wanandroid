import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/datasource/model/article.dart';

import '../collect_page.dart';
import '../login_register_page.dart';
import '../read_history_page.dart';
import '../web_page.dart';

class Router {
  openWebPage(BuildContext context, String url, String title) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return WebPage(url: url, title: title);
    }));
  }

  openArticle(BuildContext context, Article article) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return WebPage(
        article: article,
      );
    }));
  }

  openLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return LoginRegisterPage();
    }));
  }

  openReadHistory(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ReadHistoryPage();
    }));
  }

  openCollectList(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CollectPage();
    }));
  }
}
