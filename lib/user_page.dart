import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/router/router.dart';

import 'account_manager.dart';
import 'datasource/model/user.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> {
  double _screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

  String _getUserName() {
    User user = AccountManager.instance.getUser();
    return user?.username ?? "Login";
  }

  void _onUserRegionClick() {
    if (AccountManager.instance.isLogin()) {
      _showLogoutDialog();
      return;
    }
    Router().openLogin(context);
  }

  void _logout() {
    AccountManager.instance.logout();
    setState(() {});
  }

  void _showLogoutDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("确定退出登录吗？"),
            actions: <Widget>[
              FlatButton(
                  child: Text("yes"),
                  textColor: Colors.blue,
                  onPressed: () {
                    _logout();
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: Text("no"),
                textColor: Colors.grey,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: _screenWidth * 2 / 3,
          forceElevated: true,
          flexibleSpace: GestureDetector(
            onTap: _onUserRegionClick,
            child: FlexibleSpaceBar(
              background: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 120,
              ),
              title: Text(_getUserName()),
              centerTitle: true,
            ),
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return _getListItem(index);
          }, childCount: 2),
        )
      ],
    );
  }

  Widget _getListItem(int index) {
    if (index == 0) {
      return ListTile(
          onTap: () {
            Router().openReadHistory(context);
          },
          leading: Icon(Icons.history),
          title: Text("阅读历史"),
          trailing: Icon(Icons.keyboard_arrow_right));
    }
    if (index == 1) {
      return ListTile(
          onTap: () {
            Router().openCollectList(context);
          },
          leading: Icon(Icons.favorite),
          title: Text("收藏"),
          trailing: Icon(Icons.keyboard_arrow_right));
    }
    return Text("");
  }
}
