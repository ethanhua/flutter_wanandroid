import 'package:json_annotation/json_annotation.dart';

import 'article.dart';
import 'package:flutter_wanandroid/datasource/converter.dart';

part 'listdata.g.dart';


@JsonSerializable()
class ListData<T>{
  int curPage;
  @Converter()
  List<T> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ListData(this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total);

  factory ListData.fromJson(Map<String,dynamic> json) => _$ListDataFromJson<T>(json);

}

//List<T> fromJson<T>(List input) {
//  // looking for a way to check what T is we can call the correct Class.formJson()
//  return input.
//}

//Map<String, dynamic> toJson<T>(List input) => {'datas': input};

