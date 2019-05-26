import 'package:flutter_wanandroid/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static const KEY_USER = "key_user";

  String username;
  String password;
  @JsonKey()
  String _cookie;

  // 服务器cookie过期时间
  @JsonKey(fromJson: _timeFromString, toJson: _timeToString)
  DateTime _cookieExpireTime;

  User(this.username, this.password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime _timeFromString(String time) {
    return DateTime.parse(time);
  }

  static String _timeToString(DateTime time) {
    return time.toIso8601String();
  }

  set cookie(String cookie) {
    this._cookie = cookie;
    if (cookie == null || cookie.isEmpty) {
      return;
    }
    try {
      this._cookieExpireTime = DateUtils.formatExpiresTime(this._cookie);
    } catch (e) {
      print("getTimeError:" + e);
      this._cookieExpireTime = DateTime.now();
    }
  }

  get cookie {
    return _cookie;
  }

  get cookieExpireTime {
    return _cookieExpireTime;
  }
}
