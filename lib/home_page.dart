import 'package:flutter/material.dart';

import 'article_item_view.dart';
import 'datasource/data_repository.dart';
import 'datasource/model/article.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<Article> _list = List();

  @override
  void initState() {
    super.initState();
    DataRepository().listHome(0).then((data) {
      if (!mounted) {
        return;
      }
      setState(() {
        _list = data;
      });
    });
  }

  void _search() {}

  Widget _getRow(int i) {
    return ArticleItemView(_list[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        AppBar(title: Text("博文"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            alignment: Alignment.centerRight,
            onPressed: _search,
          )
        ]),
        Expanded(
          child: _list.length > 0
              ? ListView.separated(
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _getRow(position);
                  },
                  separatorBuilder: (BuildContext context, int position) {
                    return Divider(height: 1, color: Color(0xFFE0E0E0));
                  })
              : Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
