
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_wanandroid/datasource/converter.dart';
import 'listdata.dart';
part 'apiresult.g.dart';

@JsonSerializable()
class ApiResult<T> {
   @Converter()
   T data;
   int errorCode;
   String errorMsg;

   ApiResult(this.data, this.errorCode, this.errorMsg);

   factory ApiResult.fromJson(Map<String,dynamic> json) => _$ApiResultFromJson(json);

}

@JsonSerializable()
class ApiListResult<T>{
   @Converter()
   ListData<T> data;
   int errorCode;
   String errorMsg;

   ApiListResult(this.data, this.errorCode, this.errorMsg);

   factory ApiListResult.fromJson(Map<String,dynamic> json) => _$ApiListResultFromJson(json);


}
