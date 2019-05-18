import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/datasource/model/project.dart';

import '../account_manager.dart';
import 'model/apiresult.dart';
import 'model/article.dart';
import 'model/user.dart';

class DataRepository {
  static const SUFFIX_JSON = "/json";
  static const BASE_URL = "https://www.wanandroid.com";

  /// 业务url
  static const HOME_LIST = "/article/list/";
  static const PROJECT_CATEGORY = "/project/tree";
  static const PROJECT_LIST = "/project/list/";
  static const USER_REGISTER = "/user/register";
  static const USER_LOGIN = "/user/login";

  Future<List<Article>> listHome(int page) async {
    var url = "$BASE_URL$HOME_LIST$page$SUFFIX_JSON";
    Response<String> response =
        await Dio().get<String>(url, options: _getOptions());
    var jsonResp = jsonDecode(response.data);
    var apiResult = ApiListResult<Article>.fromJson(jsonResp);
    return apiResult.data.datas;
  }

  Future<List<ProjectCategory>> listProjectCategory() async {
    var url = "$BASE_URL$PROJECT_CATEGORY$SUFFIX_JSON";
    Response<String> response =
        await Dio().get<String>(url, options: _getOptions());
    Map<String, dynamic> jsonResp = jsonDecode(response.data);
    if (jsonResp.containsKey("data")) {
      return (jsonResp['data'] as List)
          ?.map((e) => e == null ? null : ProjectCategory.fromJson(e))
          ?.toList();
    }
    return null;
  }

  Future<List<Article>> listProject(int page, int chapterId) async {
    var url = "$BASE_URL$PROJECT_LIST$page$SUFFIX_JSON?cid=$chapterId";
    Response<String> response =
        await Dio().get<String>(url, options: _getOptions());
    var apiResult = ApiListResult<Article>.fromJson(jsonDecode(response.data));
    return apiResult.data.datas;
  }

  Future<User> login(String userName, String password) async {
    var url = "$BASE_URL$USER_LOGIN";
    print("login:" + url);
    Response response = await Dio().post(url,
        data: FormData.from({"username": userName, "password": password}));
    checkResultSuccess(response);
    var apiResult = ApiResult<User>.fromJson(response.data);
    apiResult?.data?.cookie = _getCookieFromResponse(response);
    return apiResult?.data;
  }

  Future<User> register(String userName, String password) async {
    var url = "$BASE_URL$USER_REGISTER";
    print("register:" + url);
    Response response = await Dio().post(url,
        data: FormData.from({
          "username": userName,
          "password": password,
          "repassword": password
        }));
    checkResultSuccess(response);
    print("user return:" + response.data.toString());
    var apiResult = ApiResult<User>.fromJson(response.data);
    apiResult?.data?.cookie = _getCookieFromResponse(response);
    return apiResult?.data;
  }

  String _getCookieFromResponse(Response response) {
    print("_getCookieFromResponse" + response.data.toString());
    var cookie ="";
    response.headers.forEach((String name, List<String> values) {
      if (name == "set-cookie") {
        cookie = json
            .encode(values)
            .replaceAll("\[\"", "")
            .replaceAll("\"\]", "")
            .replaceAll("\",\"", "; ");
      }
    });
    return cookie;
  }

  void checkResultSuccess(Response response) {
    if (response.data != null) {
      Map<String, dynamic> apiResult = response.data;
      if (apiResult != null) {
        int errorCode = apiResult["errorCode"];
        if (errorCode == 0) {
          return;
        } else {
          throw Exception(apiResult["errorMsg"]);
        }
      }
    }
    throw Exception("error unknown");
  }

  Options _getOptions() {
    return Options(headers: _getHeaders());
  }

  Map<String, dynamic> _getHeaders() {
    Map<String, dynamic> headers = Map();
    headers["Cookie"] = AccountManager.instance.getCookie();
    return headers;
  }
}
