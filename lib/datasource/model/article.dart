import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';


const String columnId = "_id";
const String columnTitle = "title";
const String columnDesc = "desc";
const String columnNiceDate = "nicedate";
const String columnAuthor = "author";
const String columnSuperChapterName = "superchaptername";
const String columnChapterName = "chaptername";
const String columnEnvelopePic = "envelopepic";
const String columnLink = "link";
const String columnCollect = "collect";
const String columnLastReadTime ="readtime";
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
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<Tag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  Article(
      this.id,
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

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Article.fromDbMap(Map map) {
    id = map[columnId];
    title = map[columnTitle];
    desc = map[columnDesc];
    niceDate = map[columnNiceDate];
    author = map[columnAuthor];
    superChapterName = map[columnSuperChapterName];
    chapterName = map[columnChapterName];
    envelopePic = map[columnEnvelopePic];
    link = map[columnLink];
    collect = map[columnCollect] == 1;
  }

  Map<String,dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map[columnId] = id;
      map[columnTitle] = title;
      map[columnDesc] = desc;
      map[columnNiceDate] = niceDate;
      map[columnAuthor] = author;
      map[columnSuperChapterName] = superChapterName;
      map[columnChapterName] = chapterName;
      map[columnEnvelopePic] = envelopePic;
      map[columnLink] = link;
      map[columnCollect] = collect == true ? 1 : 0;
    }
    return map;
  }
}

@JsonSerializable()
class Tag extends Object {
  String name;
  String url;

  Tag(this.name, this.url);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
