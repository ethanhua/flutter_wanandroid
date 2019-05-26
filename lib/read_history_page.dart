import 'package:flutter/material.dart';

import 'article_item_view.dart';
import 'datasource/db_provider.dart';
import 'datasource/model/article.dart';

class ReadHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReadHistoryPageState();
  }
}

class _ReadHistoryPageState extends State<ReadHistoryPage> {
  List<Article> _list = List();

  Widget _getRow(int index) {
    return ArticleItemView(_list[index]);
  }

  @override
  void initState() {
    super.initState();
    ReadHistoryDbProvider().query().then((List<Article> list) {
      if (!mounted) {
        return;
      }
      setState(() {
        _list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("阅读历史"),
      ),
      body: _list.length > 0
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _getRow(index);
              },
              itemCount: _list.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1, color: Color(0xFFE0E0E0));
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
