import 'package:flutter/material.dart';

import 'account_manager.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

class _LoginRegisterState extends State<LoginRegisterPage> {
  bool _isLogin = AccountManager.instance.isLogin();
  bool _clearNameIconShow = false;
  bool _clearPasswordIconShow = false;
  String _errorNameText;
  String _errorPasswordText;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _clearName() {
    _nameController.clear();
    _onNameChanged("");
  }

  void _clearPassword() {
    _passwordController.clear();
    _onPassWordChanged("");
  }

  void _onNameChanged(String value) {
    if (value.length > 0) {
      setState(() {
        _clearNameIconShow = true;
      });
      if (value.length >= 6) {
        setState(() {
          _errorNameText = null;
        });
      }
    } else {
      setState(() {
        _clearNameIconShow = false;
      });
    }
  }

  void _onPassWordChanged(String value) {
    if (value.length > 0) {
      setState(() {
        _clearPasswordIconShow = true;
      });
      if (value.length >= 6) {
        setState(() {
          _errorPasswordText = null;
        });
      }
    } else {
      setState(() {
        _clearPasswordIconShow = false;
      });
    }
  }

  void _loginOrRegister() {
    var userName = _nameController.text;
    var password = _passwordController.text;

    if (userName.isEmpty || userName.length < 6) {
      setState(() {
        _errorNameText = "username is invalid";
      });
      return;
    }
    if (password.isEmpty || password.length < 6) {
      setState(() {
        _errorPasswordText = "password in invalid";
      });
      return;
    }
    setState(() {
      _errorNameText = null;
      _errorPasswordText = null;
    });

    if (_isLogin) {
      AccountManager.instance.login(userName, password).then((user) {
        Navigator.pop(context);
      });
      return;
    }
    AccountManager.instance
        .register(_nameController.text, _passwordController.text)
        .then((user) {
      Navigator.pop(context);
    }).catchError((e) {
      print(e.toString());
      setState(() {
        _errorNameText = e.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? "登录" : "注册"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                onChanged: _onNameChanged,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: Visibility(
                      visible: _clearNameIconShow,
                      child: IconButton(
                          icon: Icon(Icons.clear), onPressed: _clearName),
                    ),
                    labelText: "username",
                    errorText: _errorNameText),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.text,
                onChanged: _onPassWordChanged,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Visibility(
                      visible: _clearPasswordIconShow,
                      child: IconButton(
                          icon: Icon(Icons.clear), onPressed: _clearPassword),
                    ),
                    labelText: "password",
                    errorText: _errorPasswordText),
              ),
              Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.blue,
                  elevation: 4,
                  textColor: Colors.white,
                  onPressed: _loginOrRegister,
                  child: Text(_isLogin ? "登录" : "注册并登录"),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin ? "注册新账号" : "登录账号")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
