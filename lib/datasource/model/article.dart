import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';


@JsonSerializable()
class Article extends Object {
  int id;
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  String link;
  String niceDate;
  String origin;
  String prefix;
  String projectLink;
  double publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Article(this.id,
          this.apkLink,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.link,
      this.niceDate,
      this.origin,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan);

  factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);
}

@JsonSerializable()
class Tag extends Object {
   String name;
   String url;

   Tag(this.name,this.url);

   factory Tag.fromJson(Map<String,dynamic> json) => _$TagFromJson(json);

}