
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/router/router.dart';
import 'package:flutter_wanandroid/utils/text_utils.dart';

import 'datasource/db_provider.dart';
import 'datasource/model/article.dart';

class ArticleItemView extends StatelessWidget{

  final Article article;
  ArticleItemView(this.article);

  @override
  Widget build(BuildContext context) {
     return new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        TextUtils.clean(article.title),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      margin: EdgeInsets.only(bottom: 6),
                    ),
                    Offstage(
                      offstage: article.desc.isEmpty,
                      child: Container(
                          child: Text(
                            TextUtils.clean(article.desc),
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Color(0xFF6b6b6b), fontSize: 12),
                          ),
                          margin: EdgeInsets.only(bottom: 6)),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.access_time,
                            size: 14,
                            color: Color(0xFF6b6b6b),
                          ),
                          margin: EdgeInsets.only(right: 2),
                        ),
                        Text(article.niceDate,
                            style: TextStyle(color: Color(0xFF6b6b6b))),
                        Text("@${article.author}",
                            style: TextStyle(color: Color(0xFF6b6b6b)))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.category,
                            size: 14,
                            color: Color(0xFF6b6b6b),
                          ),
                          margin: EdgeInsets.only(right: 2),
                        ),
                        Text("${article.superChapterName}/${article.chapterName}",
                            style: TextStyle(color: Color(0xFF6b6b6b)))
                      ],
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: article.envelopePic.isEmpty,
                child: article.envelopePic.isEmpty ? Text("") : ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image(
                    image: NetworkImage(
                        article.envelopePic),
                    width: 36,
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: (){
          ReadHistoryDbProvider().update(article);
          Router().openArticle(context, article);
        },
     );
  }

}