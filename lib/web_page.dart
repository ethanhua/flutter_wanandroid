import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

import 'datasource/model/article.dart';

class WebPage extends StatefulWidget {
  final String url;
  final String title;
  final Article article;

  WebPage({this.url, this.title, this.article});

  String getLoadUrl() {
    return url ?? article?.link ?? "";
  }

  String getTitle() {
    return title ?? article?.title ?? "";
  }

  @override
  State<StatefulWidget> createState() {
    return _WebPageState();
  }
}

class _WebPageState extends State<WebPage> {
  bool _like = false;

  void _actionLike() {

  }

  void _openInBrowser() {
    launch(widget.getLoadUrl());
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.getLoadUrl(),
      appBar: AppBar(
        title: Text(widget.getTitle()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_like ? Icons.favorite : Icons.favorite_border),
            color: _like ? Colors.red : Colors.white,
            onPressed: _actionLike,
          ),
          IconButton(
              icon: Icon(
                Icons.open_in_browser,
                color: Colors.white,
              ),
              onPressed: _openInBrowser)
        ],
      ),
    );
  }
}
