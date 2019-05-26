import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/text_utils.dart';

import 'article_item_view.dart';
import 'datasource/data_repository.dart';
import 'datasource/model/article.dart';
import 'datasource/model/project.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print("create ProjectPage");
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _tabController;
  List<ProjectCategory> _listCategory = List();

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  List<Widget> _getTabs() {
    List<Tab> list = List();
    for (var value in _listCategory) {
      list.add(Tab(text: TextUtils.clean(value.name)));
    }
    return list;
  }

  _getContentView() {
    return TabBarView(
        controller: _tabController, children: _getTabChildViews());
  }

  List<Widget> _getTabChildViews() {
    List<Widget> list = List();
    for (var value in _listCategory) {
      list.add(ProjectListPage(value.id));
    }
    return list;
  }

  void generateListView(chapterId) {}

  void _reload() {
    DataRepository().listProjectCategory().then((list) {
      setState(() {
        _listCategory = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_listCategory == null || _listCategory.isEmpty) {
      return Text("loading");
    }
    if (_tabController == null) {
      _tabController = TabController(length: _listCategory.length, vsync: this);
    }
    return Column(
      children: <Widget>[
        AppBar(
          title: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: _getTabs(),
          ),
        ),
        Expanded(child: _getContentView())
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProjectListPage extends StatefulWidget {
  final int _chapterId;

  ProjectListPage(this._chapterId);

  @override
  State<StatefulWidget> createState() {
    return _ProjectListPageState(_chapterId);
  }
}

class _ProjectListPageState extends State<ProjectListPage> {
  final int _chapterId;
  List<Article> _projectList = List();

  _ProjectListPageState(this._chapterId);

  @override
  void initState() {
    super.initState();
    DataRepository().listProject(0, _chapterId).then((list) {
      if (!mounted) {
        return;
      }
      setState(() {
        _projectList = list;
      });
    });
  }

  Widget _getRow(int i) {
    return ArticleItemView(_projectList[i]);
  }

  @override
  Widget build(BuildContext context) {
    return _projectList.length > 0
        ? ListView.separated(
            itemCount: _projectList.length,
            itemBuilder: (BuildContext context, int position) {
              return _getRow(position);
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(height: 1, color: Color(0xFFE0E0E0));
            })
        : Center(child: CircularProgressIndicator());
  }
}
