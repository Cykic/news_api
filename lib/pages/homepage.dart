import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_api/models/newsInfo.dart';
import 'package:movie_api/services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<News> _newsModel;

  @override
  void initState() {
    _newsModel = ApiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: Container(
        child: FutureBuilder<News>(
            future: _newsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.articles.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data.articles[index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    height: 100,
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8,),
                            Text(article.title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              SizedBox(height: 8,),
                              Text(article.description,overflow: TextOverflow.ellipsis,maxLines: 2,)
                          ],),
                        )
                        // Image.network(article.urlToImage)
                      ],
                    ),
                  );
                });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
