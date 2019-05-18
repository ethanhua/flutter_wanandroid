import 'package:json_annotation/json_annotation.dart';

import 'model/article.dart';
import 'model/listdata.dart';
import 'model/project.dart';
import 'model/user.dart';

class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('datas')) {
        return ListData.fromJson(json) as T;
      }
      if (json.containsKey('author') &&
          json.containsKey('link') &&
          json.containsKey('title')) {
        return Article.fromJson(json) as T;
      }
      if (json.containsKey('courseId') &&
          json.containsKey('name') &&
          json.containsKey("order")) {
        return ProjectCategory.fromJson(json) as T;
      }
      if (json.containsKey('username')) {
        return User.fromJson(json) as T;
      }
    }
    if (json is List) {
      return json.map((e) => e == null ? null : fromJson(e)).toList() as T;
    }

    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    print("before:" + json.toString());
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}
