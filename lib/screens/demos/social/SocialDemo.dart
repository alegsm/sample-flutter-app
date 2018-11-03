
import 'package:appfolio/screens/demos/social/Post.dart';
import 'package:flutter/material.dart';

class SocialDemoPage extends StatefulWidget {

  SocialDemoPage();
  @override
  SocialDemoPageState createState() => new SocialDemoPageState();
}

class SocialDemoPageState extends State<SocialDemoPage> {

  List<Post> posts = Post.generateDummyData();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      body: new Container(
        child: new CustomScrollView(
          slivers: <Widget>[
            new SliverList(delegate: new SliverChildListDelegate([
              new Container(
                padding: new EdgeInsets.only(top: 50.0, bottom: 10.0),
                color: Colors.white,
              ),
            ])),
            new SliverSafeArea(
                top: false,
                minimum:new EdgeInsets.only(bottom: 60.0),
                sliver: new SliverList(
                    delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int i)
                        {
                          return posts[i%2 == 0 ? 0 : 1].generateListItem(context);
                        },
                        childCount: 10
                    )
                )),
          ],
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.cyan[700],
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(icon: Icon(Icons.navigate_before, color: Colors.white),
                onPressed: (){
                  Navigator.of(context).pop();
                }
            ),
            new IconButton(icon: Icon(Icons.home, color: Colors.white),
                onPressed: (){
                  Navigator.of(context).pop();
                }
            ),

          ],
        ),
      ),
    );
  }

}
