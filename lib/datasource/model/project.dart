import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';


@JsonSerializable()
class ProjectCategory{
   int courseId;
   int id;
   String name;
   int order;
   int parentChapterId;
   bool userControlSetTop;
   int visible;

   ProjectCategory(this.courseId,
       this.id,
       this.name,
       this.order,
       this.parentChapterId,
       this.userControlSetTop,
       this.visible);

   factory ProjectCategory.fromJson(Map<String,dynamic> json) => _$ProjectCategoryFromJson(json);
}