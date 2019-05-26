import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/article.dart';

const String dbName = "wanandroiddb";
const String tableReadHistory = "readhis";
const String CREATE_READ_HIS_SQL = ''' create table $tableReadHistory(
      $columnId integer primary key autoincrement,
      $columnTitle text not null,
      $columnDesc text,
      $columnNiceDate text not null,
      $columnAuthor text not null,
      $columnSuperChapterName text,
      $columnChapterName text,
      $columnEnvelopePic text,
      $columnLink text,
      $columnCollect integer,
      $columnLastReadTime integer)
       ''';

class ReadHistoryDbProvider {
  Database db;

  Future open() async {
    var path = await getAppDbPath();
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(CREATE_READ_HIS_SQL);
    });
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableReadHistory, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Article article) async {
    await open();
    var map = article.toMap();
    map[columnLastReadTime] = DateTime.now().millisecondsSinceEpoch;
    var id = await db.update(tableReadHistory, map,
        where: "$columnId = ?", whereArgs: [article.id]);
    if (id == 0) {
      id = await db.insert(tableReadHistory, map);
    }
    await close();
    print("update success:$id");
    return id;
  }

  Future<List<Article>> query() async {
    await open();
    List<Map> listArticle =
        await db.query(tableReadHistory, orderBy: "$columnLastReadTime DESC");
    await close();
    return listArticle
        .map((e) => e == null ? null : Article.fromDbMap(e))
        .toList();
  }

  Future close() async => db.close();
}

Future<String> getAppDbPath() async {
  var dbPath = await getDatabasesPath();
  var path = join(dbPath, dbName);
  return path;
}
