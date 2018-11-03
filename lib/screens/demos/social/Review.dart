import 'package:appfolio/screens/demos/social/Post.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
class Review
{
  TaggedText reviewText;
  User user;
  Social social;
  int stars;
  int price;
  Review({this.reviewText, this.social, this.price, this.stars, this.user});

  static List<Review> generateDummyData()
  {
    List<Review> dummy = [];
    dummy.add(
        new Review(
            user: User.generateDummyUser(),
            reviewText: TaggedText('Excelente servicio, lo recomiendo 100%'),
            social: new Social(liked: true, likes: 100),
            price: 2,
            stars: 5)
    );
    return dummy;
  }

  Widget generateListItem()
  {
    return _generateReviewBody();
  }

  Widget _generateReviewBody()
  {
    Color ratingsColors = Colors.orange;
    if(stars == 5)
      ratingsColors = Colors.yellow[700];

    else if(stars >= 3)
      ratingsColors = Colors.grey[400];

    List<Widget> dollars = new List();

    for(int i = 0; i < 5; i ++)
    {
      dollars.add(new Container(
        child: new Text('\$', style: new TextStyle(color: price > i ? Colors.teal : Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold)),
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.only(bottom: 10.0),
          decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.grey[300], width: 1.0))),
          margin: new EdgeInsets.only(top: 10.0,left: 16.0, right: 16.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              new Flexible(child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(bottom: 10.0),
                        child: new SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: user.getAvatar(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Flexible(
                        child: new Container(
                          child:
                          new Text(
                              user.name,
                              textAlign: TextAlign.start,
                              style: new TextStyle(fontSize: 16.0, fontFamily: 'Poiret', color: Colors.black, fontWeight: FontWeight.bold)
                          ),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.only(top: 5.0),
                        child: new Text('Nivel ${user.level}', textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, color: parseColor(user.currentLevelColor), fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              )),

              new Flexible(
                flex: 4,
                child: new Container(
                  decoration: new BoxDecoration(border: new Border(left: new BorderSide(color: Colors.grey[300], width: 1.0))),
                  margin: new EdgeInsets.only(left: 10.0),
                  padding : new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.only(bottom: 5.0),
                            child: new Text('Calificación:', textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      new Container(
                        margin: new EdgeInsets.only(bottom: 10.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                child: new Text('${stars}', style: new TextStyle(fontSize: 18.0, color: ratingsColors))
                            ),
                            new Container(
                              margin: new EdgeInsets.only(right: 10.0),
                              child: new Icon(Icons.star, color: ratingsColors, size: 20.0),
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: dollars,
                            ),
                          ],
                        ),
                      ),

                      new Container(
                        padding: new EdgeInsets.all(10.0),
                        decoration: new BoxDecoration(color: Colors.cyan[300],
                            borderRadius: new BorderRadius.circular(10.0)
                        ),
                        child: reviewText.createRichText(normal: TextStyle(fontSize: 16.0, color: Colors.white)),
                      ),
                      _createLikeButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createLikeButtons({bool center = false, noMargins = false})
  {
    bool liked = false;
    int likes = 0;

    likes = social.likes ?? 0;

    liked = social.liked ?? false;

    return new Container(
      margin: new EdgeInsets.only(top: noMargins ? 0.0 : 10.0, left:  noMargins ? 0.0 : 10.0, right:  noMargins ? 0.0 : 16.0),
      padding: new EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
      child: new Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.end,
        children: <Widget>[

          new InkWell(
            borderRadius:new BorderRadius.circular(10.0),
            onTap: (){},
            child: new AnimatedContainer(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              duration: new Duration(milliseconds: 50),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  new SizedBox(
                      child: new Icon(Icons.thumb_up, color: liked ? Colors.cyan[300] : Colors.grey, size: liked ? 25.0 : 20.0),
                      width: liked ? 25.0 : 20.0,
                      height: liked ? 25.0 : 20.0
                  ),

                  new Container(
                    margin: new EdgeInsets.only(left: 5.0),
                    child: new AnimatedDefaultTextStyle(
                        child: new Text(likes > 0 ? '$likes' : ''),
                        style: new TextStyle(fontSize: liked ? 16.0 : 15.0, color: liked ? Colors.cyan[300] : Colors.grey),
                        duration: new Duration(milliseconds: 50)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color parseColor(String hex)
  {
    String raw = '0x' + hex;
    return new Color(int.parse(raw));
  }

}

class TaggedText{

  String text;
  List<RichSpan> tags;

  TaggedText(this.text, {this.tags});

  static List<TaggedText> generateTagsExample()
  {
    var dummy = <TaggedText>[];
    dummy.add(TaggedText('si, el mejor lugar es en {tag}', tags: RichSpan.generateDummyData()));
    return dummy;
  }

  Widget createRichText({TextStyle normal, TextStyle link})
  {
    var normalStyle = normal ?? TextStyle(color: Colors.grey[700], fontSize: 14.0);
    var linkStyle = link ?? TextStyle(color: Colors.pink[700], fontSize: 15.0);

    List<TextSpan> spans = [];

    if(tags != null && tags.isNotEmpty)
    {
      var clickable = new TextSpan(
        text: 'página web.',
        style: new TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.bold),
        recognizer: new TapGestureRecognizer()
          ..onTap = () {

          },
      );

      var list = text.split(' ');
      int tagCounter = 0;
      list.forEach(
              (word)
          {
            if(word != RichSpan.tagIndicator)
            {
              spans.add(
                  TextSpan(
                    text: word+' ',
                    style: normalStyle,
                  ));
            }
            else
            {
              if(tags.length > tagCounter) {
                final tag = tags[tagCounter];
                spans.add(
                    TextSpan(
                      text: tag.span,
                      style: linkStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          print('click on ${tag.span}');
                        },
                    ));
                tagCounter ++;
              }
            }
          }
      );
    }
    else
    {
      spans.add(
          TextSpan(
            text: text,
            style: normalStyle,
          ));
    }

    return RichText(
      text: TextSpan(
          children: spans
      ),
    );
  }
}

class RichSpan{
  static const String tagIndicator ='{tag}';
  static const String TYPE_PLACE ='PLACE';
  static const String TYPE_USER='USER';
  String span;
  String type;

  Map<String, dynamic> data;

  RichSpan({this.span, this.type, this.data});

  static List<RichSpan> generateDummyData(){
    var dummy = <RichSpan>[];
    dummy.add(RichSpan(span: '@ParqueLaCarolina', type: TYPE_PLACE));
    return dummy;
  }
}

class User
{
  final String id;
  final int level;
  final String name;
  final String email;
  final double progress;
  final String lifeStyle;
  final String clientCode;
  final String avatarUrl;
  final String nextLevelColor;
  final int userClientRankingID;
  final String currentLevelColor;

  User({this.level = 1,
    this.nextLevelColor,
    this.currentLevelColor,
    this.name,
    this.id,
    this.email,
    this.lifeStyle = "",
    this.clientCode = "",
    this.userClientRankingID,
    this.progress = 0.5,
    this.avatarUrl = 'https://avatars0.githubusercontent.com/u/13877046?s=400&u=cda97123eb363e239991085b8a7a1bff252f55dd&v=4'});

  static User generateDummyUser()
  {
    return new User(
      level: 5,
      id: '10',
      name: 'Alejandro',
      email: 'alegsm7@gmail.com',
      progress: 0.7,
      avatarUrl: 'https://avatars0.githubusercontent.com/u/13877046?s=400&u=cda97123eb363e239991085b8a7a1bff252f55dd&v=4',
      nextLevelColor: 'FFF44336',
      currentLevelColor: 'FFFF6E40',
    );
  }

  static User parse(raw)
  {
    if (raw != null && raw is Map<String, dynamic>)
    {
      final userClientRankingId = raw['userClientRankingId'];
      final currentLevelColor = raw['currentLevelColor'];
      final nextLevelColor = raw['nextLevelColor'];
      final clientCode = raw['clientCode'];
      final lifeStyle = raw['lifeStyle'];
      final progress = raw['progress'];
      final email = raw['email'];
      final level = raw['level'];
      final name = raw['name'];
      final id = raw['id'];

      return new User(
          level: level,
          nextLevelColor: nextLevelColor,
          currentLevelColor: currentLevelColor,
          name: name,
          id: id,
          email: email,
          lifeStyle: lifeStyle,
          clientCode: clientCode,
          userClientRankingID: userClientRankingId,
          progress: progress
      );
    }
    return null;
  }



  Widget getAvatar({fontSize = 20.0, color : Colors.blue})
  {
    String imgUrl = avatarUrl ?? '';

    Widget avatar = new Container();

    if(imgUrl.isEmpty)
      avatar = new CircleAvatar(
          radius: 100.0,
          minRadius: 100.0,
          maxRadius: 100.0,
          backgroundColor: color,
          child: new Align(
              alignment: Alignment.center,
              child: new Text(name.substring(0, 1),
                  textAlign: TextAlign.center,
                  // ignore: conflicting_dart_import
                  style: new TextStyle(color: Colors.white, fontSize: fontSize)
              )
          )
      );
    else
      avatar = new CircleAvatar(
        backgroundImage: new NetworkImage(imgUrl),
      );

    return avatar;
  }


}