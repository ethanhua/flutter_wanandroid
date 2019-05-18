// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult<T> _$ApiResultFromJson<T>(Map<String, dynamic> json) {
  return ApiResult<T>(
      json['data'] == null ? null : Converter<T>().fromJson(json['data']),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$ApiResultToJson<T>(ApiResult<T> instance) =>
    <String, dynamic>{
      'data':
          instance.data == null ? null : Converter<T>().toJson(instance.data),
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

ApiListResult<T> _$ApiListResultFromJson<T>(Map<String, dynamic> json) {
  return ApiListResult<T>(
      json['data'] == null
          ? null
          : ListData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$ApiListResultToJson<T>(ApiListResult<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
