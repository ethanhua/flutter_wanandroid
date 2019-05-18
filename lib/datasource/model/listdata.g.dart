// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListData<T> _$ListDataFromJson<T>(Map<String, dynamic> json) {
  return ListData<T>(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) => e == null ? null : Converter<T>().fromJson(e))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$ListDataToJson<T>(ListData<T> instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas
          ?.map((e) => e == null ? null : Converter<T>().toJson(e))
          ?.toList(),
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };
