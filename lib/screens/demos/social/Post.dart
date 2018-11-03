import 'dart:ui';

import 'package:appfolio/screens/demos/social/Business.dart';
import 'package:appfolio/screens/demos/social/Review.dart';
import 'package:appfolio/screens/demos/social/SocialImage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Post
{

  static const int TYPE_NEW_BUSINESS = 0;
  static const int TYPE_PROMO = 1;
  static const int TYPE_REVIEW = 2;
  static const int TYPE_PHOTO = 3;
  static const int TYPE_QUESTION = 4;
  static const int TYPE_INVITE = 5;

  Business business;
  int creationDate;
  Social social;
  int type;

  bool _forCommentSection;

  Map<String, dynamic> data;

  Post({this.business, this.creationDate, this.type, this.data, this.social})
  {
    _forCommentSection = false;
  }

  static List<Post> generateDummyData()
  {
    final dummy = new List<Post>();
    Business mongos = Business.generateDummyData()[0];
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_NEW_BUSINESS,
            social: new Social(likes: 10, liked: true)
        )
    );
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_PROMO,
            social: new Social(likes: 10, liked: true)
        )
    );
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_REVIEW,
            social: new Social(likes: 10, liked: true),
            data:
            {
              'review' : Review.generateDummyData()[0],
            }
        )
    );
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_PHOTO,
            social: new Social(likes: 10, liked: true),
            data:
            {
              'photo' : GalleryPhoto.generateDummyData()[0],
            }
        )
    );
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_QUESTION,
            social: new Social(likes: 10, liked: true),
            data:
            {
              'question': Question.generateDummyData()[0],
            }
        )
    );
    dummy.add(
        new Post(
            business: mongos,
            creationDate: new DateTime.now().millisecondsSinceEpoch,
            type: TYPE_INVITE,
            social: new Social(likes: 10, liked: true),
            data:
            {
              'invite': Invite.generateDummyData()[0],
            }
        )
    );

    return dummy;
  }

  User get user
  {
    if(type == TYPE_QUESTION)
      return question.questionOwner;
    if(type == TYPE_REVIEW)
      return review.user;
    if(type == TYPE_PHOTO)
      return galleryPhoto.user;
    if(type == TYPE_INVITE)
      return invite.user;
    else return null;
  }

  Review get review
  {
    if(data != null && data['review'] != null && data['review'] is Review)
      return data['review'];
    else
      return null;
  }

  Invite get invite
  {
    if(data != null && data['invite'] != null && data['invite'] is Invite)
      return data['invite'];
    else
      return null;
  }

  Question get question
  {
    if(data != null && data['question'] != null && data['question'] is Question)
      return data['question'];
    else
      return null;
  }

  GalleryPhoto get galleryPhoto
  {
    if(data != null && data['photo'] != null && data['photo'] is GalleryPhoto)
      return data['photo'];
    else
      return null;
  }

  String get headerText
  {
    String headerText = '';
    switch(type)
    {
      case TYPE_NEW_BUSINESS:
        headerText = business.name;
        break;
      case TYPE_PROMO:
        headerText = business.name;
        break;
      case TYPE_REVIEW:
      case TYPE_PHOTO:
      case TYPE_INVITE:
      case TYPE_QUESTION:
        headerText = user != null ? user.name : '-';
        break;
    }
    return headerText;
  }

  Widget generateListItem(BuildContext context, {bool forCommentSection = false})
  {
    if(forCommentSection)
      _forCommentSection = true;

    var header = new Container(
        decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: type == TYPE_REVIEW ? Colors.transparent : Colors.grey[100], width: 1.0))),
        child: _createHeader(context)
    );

    var body = new Container(
      decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: type == TYPE_REVIEW ? Colors.transparent : Colors.grey[100], width: 1.0))),
      child: _createBody(context),
    );

    var footer = new Container(
      decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.grey[300], width: _forCommentSection ? 1.0 : 0.0))),
      child: _generatePostFooter(context),
    );

    _forCommentSection = false;
    return new Container(
      margin: new EdgeInsets.only(bottom: 10.0),
      child:
      new Material(
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            header,
            body,
            footer,
          ],
        ),
      ),
    );
  }

  Widget getAvatar({bool isBusiness = false})
  {
    String url = '';
    if(!isBusiness) {
      if(type == TYPE_PHOTO || type == TYPE_REVIEW || type == TYPE_QUESTION || type == TYPE_INVITE) {
        url = user.avatarUrl ?? '';
      }
    }
    else
      url = business.avatarUrl ?? '';

    String name = !isBusiness ? user.name : business.name;

    Widget avatar = new Container();

    if(url.isEmpty)
      avatar = new CircleAvatar(
          backgroundColor: Colors.blue,
          child: new Align(
              alignment: Alignment.center,
              child: new Text(name.substring(0, 1),
                  textAlign: TextAlign.center,
                  // ignore: conflicting_dart_import
                  style: new TextStyle(color: Colors.white, fontSize: 20.0)
              )
          )
      );
    else
      avatar = new CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: new NetworkImage(url),
      );

    return new Container(
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black, width: .5),
          borderRadius: new BorderRadius.circular(100.0)
      ),
      child: avatar,
    );
  }

  Widget _createBody(BuildContext context)
  {
    Widget body = new Container();
    switch(type)
    {
      case TYPE_NEW_BUSINESS:
        if(business.images != null && business.images.isNotEmpty)
        {
          body = _generateImageBody(context, isNew: true, image: business.images[0]);
        }
        break;
      case TYPE_PROMO:
        body = _generateImageBody(context, promo: true, image: business.promo?.image);
        break;
      case TYPE_REVIEW:
        body = _generateReviewBody();
        break;
      case TYPE_PHOTO:
        body = _generateImageBody(context, image: galleryPhoto?.img);
        break;
      case TYPE_QUESTION:
        body = _generateQuestionBody();
        break;
      case TYPE_INVITE:
        body = _generateImageBody(context, image: invite?.image, isInvite: true);
        break;
    }
    return body;
  }

  Widget _generateImageBody(BuildContext context, {bool isNew = false, bool promo = false, SocialImage image, bool isInvite = false})
  {
    double width = MediaQuery.of(context).size.width;
    Widget label = new Container();

    if(image == null)
      return new Container();

    if(isNew)
      label = new Align(alignment: Alignment.topLeft,
        child: new Container(
          padding: new EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
          decoration: new BoxDecoration(color: Colors.deepOrange, borderRadius: new BorderRadius.only(bottomRight: new Radius.circular(15.0))),
          child: new Text('label', style: new TextStyle(color: Colors.white, fontSize: 16.0)),
        ),
      );

    if(promo)
      label = new Align(alignment: Alignment.topLeft,
        child: new Container(
          padding: new EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
          decoration: new BoxDecoration(color: Colors.yellow[600], borderRadius: new BorderRadius.only(bottomRight: new Radius.circular(15.0))),
          child: new Text('label', style: new TextStyle(color: Colors.black, fontSize: 16.0)),
        ),
      );

    if(isInvite)
      label = new Align(alignment: Alignment.bottomRight,
        child: new Container(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 2.0, 10.0),
            decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.only(topLeft: new Radius.circular(15.0))),
            child: new InkWell(

              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    width: 30.0,
                    height: 30.0,
                    child: getAvatar(isBusiness: true),
                  ),
                  new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 5.0),
                    child: new Text(business.name, style: new TextStyle(fontSize: 12.0)),
                  ),
                ],
              ),
            )
        ),
      );

    return new Stack(
      alignment: isInvite ? Alignment.bottomRight : Alignment.topLeft,
      children: <Widget>[
        new Container(
          // ignore: conflicting_dart_import
          child: new Image.network(image.url, width: width, height: image.calculateHeight(width), fit: BoxFit.fill),
        ),
        label,
      ],
    );
  }

  Widget _generateReviewBody()
  {
    Color ratingsColors = Colors.orange;
    if(review == null)
      return new Container();

    if(review.stars == 5)
      ratingsColors = Colors.yellow[700];

    else if(review.stars >= 3)
      ratingsColors = Colors.grey[400];

    List<Widget> dollars = new List();

    for(int i = 0; i < 5; i ++)
    {
      dollars.add(new Container(
        child: new Text('\$', style: new TextStyle(color: review.price > i ? Colors.teal : Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold)),
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(top: 10.0, bottom: 5.0, left: 16.0),
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
                          child: getAvatar(),
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
                            child: new Text('rating:', textAlign: TextAlign.start, style: new TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
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
                                child: new Text('${review.stars}', style: new TextStyle(fontSize: 18.0, color: ratingsColors))
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
                        // ignore: conflicting_dart_import
                        child: review.reviewText.createRichText(normal: TextStyle(fontSize: 16.0, color: Colors.white)),
                      )
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

  Widget _generateQuestionBody()
  {
    if(question == null)
      return new Container();

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(top: 10.0, bottom: 20.0, left: 16.0),
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
                          child: getAvatar(),
                        ),
                      ),
                    ],
                  ),
                ],
              )),

              new Flexible(
                flex: 4,
                child: new Container(
                  margin: new EdgeInsets.only(left: 10.0),
                  padding : new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          padding: new EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(color: Colors.cyan[300],
                              borderRadius: new BorderRadius.only(
                                  bottomRight: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0)
                              )
                          ),
                          child: new Text(question.question, style: new TextStyle(fontSize: 16.0, color: Colors.white))),
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

  Widget _createLikeButton()
  {
    bool liked = false;
    int likes = 0;

    likes = social.likes ?? 0;

    liked = social.liked ?? false;

    return InkWell(
      onTap: (){},
      child: new Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new AnimatedContainer(
              padding: new EdgeInsets.only(left: 10.0, right: 10.0),
              duration: new Duration(milliseconds: 50),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  new SizedBox(
                      child: new Icon(Icons.thumb_up, color: liked ? Colors.cyan[300] : Colors.grey, size: 20.0),
                      width: 20.0,
                      height: 20.0
                  ),

                  new Container(
                    margin: new EdgeInsets.only(left: 5.0),
                    child: new AnimatedDefaultTextStyle(
                        child: new Text(likes > 0 ? '$likes' : ''),
                        style: new TextStyle(fontSize: 14.0, color: Colors.grey),
                        duration: new Duration(milliseconds: 50)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color parseColor(String hex)
  {
    String raw = '0x' + hex;
    return new Color(int.parse(raw));
  }

  Widget _generatePostFooter(BuildContext context)
  {
    Widget footer = new Container();
    switch(type)
    {
      case TYPE_NEW_BUSINESS:
        if(business.images != null && business.images.isNotEmpty)
        {
          footer = _generateBusinessFooter(context, isNew: true);
        }
        else
        {
          footer = _generateBusinessFooter(context);
        }
        break;
      case TYPE_PROMO:
        footer = _generateBusinessFooter(context, promo: true, hasCoupon: business.promo?.hasCoupon?? false);
        break;
      case TYPE_REVIEW:
        footer = _generateReviewFooter(context);
        break;
      case TYPE_PHOTO:
        footer = _generatePhotoFooter(context);
        break;
      case TYPE_QUESTION:
        footer = _generateQuestionFooter();
        break;
      case TYPE_INVITE:
        footer = _generateInviteFooter(context);
        break;
    }
    return footer;
  }

  Widget _createHeader(BuildContext context)
  {
    Widget header  = new Container();

    if(type != TYPE_REVIEW && type != TYPE_PHOTO && type != TYPE_INVITE && type != TYPE_QUESTION)
      header = new Material(
        color: Colors.transparent,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new InkWell(
                  child: new Container(
                    margin: new EdgeInsets.only(left: 17.0, top: 10.0, bottom: 10.0),
                    child: new SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: getAvatar(isBusiness: true)
                    ),
                  ),
                )
              ],
            ),
            new Expanded(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new InkWell(

                        child:  new Container(
                          margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                          padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                          child: new Text(headerText, textAlign: TextAlign.start, style: new TextStyle(fontSize: 16.0, fontFamily: 'Poiret', color: Colors.black, fontWeight: FontWeight.bold)),
                        ))],
                )),

          ],
        ),
      );

    if(type == TYPE_PHOTO)
      header = new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(left: 17.0, top: 10.0, bottom: 10.0),
                child: new SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: getAvatar()
                ),
              ),
            ],
          ),
          new Expanded(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: new Text.rich(new TextSpan(text: '', children: [
                      new TextSpan(text: '$headerText \n', style: new TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poiret', fontSize: 16.0)),
                      new TextSpan(text: 'ha subido una imagen en: \n', style: new TextStyle(fontSize: 12.0)),
                      new TextSpan(text: '${business.name}', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontFamily: 'Poiret', fontSize: 16.0),
                        recognizer: new TapGestureRecognizer()
                      ),
                    ])),
                  )
                ],
              )),
          new Container(
            decoration: new BoxDecoration(border: new Border.all(color: Colors.grey, width: 1.0), borderRadius: new BorderRadius.circular(10.0)),
            margin: new EdgeInsets.only(right: 16.0, top: 5.0, bottom: 5.0),
            padding: new EdgeInsets.all(5.0),
            child: new InkWell(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new SizedBox(
                      width: 25.0,
                      height: 25.0,
                      child: new Icon(Icons.home, color: Colors.grey)
                  ),

                ],
              ),
            ),
          ),
        ],
      );

    if(type == TYPE_QUESTION)
      header = new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(left: 17.0, top: 10.0, bottom: 10.0),
                child: new SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: new Container(
                    decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(100.0)),
                    child: new Icon(Icons.help_outline, color: Colors.grey[700], size: 30.0),
                  ),
                ),
              ),
            ],
          ),
          new Expanded(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: new Text.rich(new TextSpan(text: '', children: [
                      new TextSpan(text: '$headerText \n', style: new TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poiret', fontSize: 16.0)),
                      new TextSpan(text: 'ha creado una nueva pregunta en: \n', style: new TextStyle(fontSize: 12.0)),
                      new TextSpan(text: '${question.topicName}', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontFamily: 'Poiret', fontSize: 16.0),
                        recognizer: new TapGestureRecognizer()
                      ),
                    ])),
                  )
                ],
              ))
        ],
      );

    if(type == TYPE_INVITE)
      header = new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(left: 17.0, top: 10.0, bottom: 10.0),
                child: new SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: new Container(
                    decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(100.0)),
                    child: getAvatar(),
                  ),
                ),
              ),
            ],
          ),
          new Expanded(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: new Text.rich(new TextSpan(text: '', children: [
                      new TextSpan(text: '$headerText \n', style: new TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poiret', fontSize: 16.0)),
                      new TextSpan(text: 'quiere ir a ', style: new TextStyle(fontSize: 12.0)),
                      new TextSpan(text: '${business.name}', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontFamily: 'Poiret', fontSize: 16.0),
                      ),
                    ])),
                  )
                ],
              )),
        ],
      );

    return header;
  }

  Widget _generateReviewFooter(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;

    return new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.symmetric(horizontal: 16.0),
              margin: new EdgeInsets.only(bottom: 3.0, top: 10.0),
              child:
              new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text.rich(
                    new TextSpan(text: '', style: new TextStyle(),
                        children: [
                          new TextSpan(text: '${user.name}', style: new TextStyle(color: Colors.black, fontSize: 14.0)),
                          new TextSpan(text: ' comentó en:', style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.grey)),
                        ]
                    ),
                  ),
                ],
              ),
            ),
            new InkWell(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      new Image.network('https://www.mongos.de/bilder/impressionen_start/restaurant_mongos_zutaten.jpg', width: width, height: 100.0, fit: BoxFit.cover),
                      new ClipRect(
                          child: new BackdropFilter(
                              filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: new Container(
                                  child:
                                  new Container(
                                    width: width,
                                    height: 100.0,
                                    color: Colors.grey.shade400.withOpacity(0.2),
                                  )
                              )
                          )
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                            margin: new EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 15.0),
                            child: new Container(
                              child: new SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: getAvatar(isBusiness: true)
                              ),
                            ),
                          ),
                          new Flexible(child: new Text('${business.name}', style: new TextStyle(fontFamily:'Poiret', fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _createOptionsButton(context),
          ],
        ));

  }

  Widget _generateBusinessFooter(context,{
    bool hasCoupon = false,
    bool isNew = false,
    bool promo = false
  })
  {

    Widget description = new Container();
    Widget optionsButton = new Container();
    Widget couponButton = new Container();

    TextStyle normalStyle = new TextStyle(fontSize: 14.0, color: Colors.grey[800]);
    TextStyle boldStyle = normalStyle.copyWith(fontWeight: FontWeight.bold);

    if(isNew)
      description = new Container(
        margin: new EdgeInsets.only(bottom: 5.0, top: 7.0),
        child: new Text.rich(
          new TextSpan(
              style: new TextStyle(fontSize: 14.0, color: Colors.grey[800]),
              text: 'Caption \n',
              children: [
                new TextSpan(style: normalStyle, text: 'name '),
                new TextSpan(style: boldStyle, text: '${business.name}'),
                new TextSpan(style: normalStyle, text: '!.'),
              ]),
        ),
      );
    else if(promo){
      String title = '';
      String body = '';

      if(business?.promo?.title != null)
        title = business?.promo?.title;

      if(business?.promo?.description != null)
        body = business?.promo?.description;

      description = new Container(
        margin: new EdgeInsets.only(bottom: 5.0, top: 7.0),
        child: new Text.rich(
          new TextSpan(
              style: normalStyle,
              text: '',
              children: [
                new TextSpan(style: boldStyle.copyWith(color: Colors.red[600], fontSize: 14.0), text: '$title\n'),
                new TextSpan(style: normalStyle, text: '$body'),
              ]),
        ),
      );
    }

    optionsButton = _createOptionsButton(context);

    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.fromLTRB(20.0, 5.0, 16.0, 10.0),
                  child: description,
                )
              ],
            )),
          ],
        ),
        couponButton,
        optionsButton,
      ],
    );
  }

  Widget _generateQuestionFooter()
  {
    Widget optionsButton = new Container();
    optionsButton = _createQuestionButtons();

    return new Column(
      children: <Widget>[
        optionsButton,
      ],
    );
  }

  Widget _createQuestionButtons()
  {
    return new Container(
        padding: new EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0, top: 10.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(Icons.warning, color: Colors.redAccent, size: 20.0),
                        new Container(
                            margin: new EdgeInsets.only(left: 5.0),
                            child: new Text('Reportar', style: new TextStyle(color: Colors.redAccent, fontSize: 12.0), textAlign: TextAlign.center))
                      ],
                    )
                  ],
                )
            ),
            new Container(
              width: 1.0,
              height: 30.0,
              color: Colors.grey[200],
            ),
            new Expanded(
                child: new Container(child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(Icons.question_answer, color: Colors.cyan, size: 20.0),
                        new Container(
                            margin: new EdgeInsets.only(left: 5.0),
                            child: new Text('Responder', style: new TextStyle(color: Colors.grey, fontSize: 12.0))),
                      ],
                    ),
                  ],
                ))),
          ],
        ));
  }

  Widget _createOptionsButton(context)
  {

    return new Container(
        padding: new EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0, top: 10.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _forCommentSection ? new Container() : new Expanded(
                child: new InkWell(

                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Icon(Icons.comment, color: Colors.grey, size: 20.0),
                              new Container(
                                margin: new EdgeInsets.only(left: 5.0),
                                child: new Text('100',style: new TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                )),

            _forCommentSection ? new Container() : new Container(
              width: 1.0,
              height: 30.0,
              color: Colors.grey[200],
            ),

            new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _createLikeButton(),
                  ],
                )),

          ],
        ));
  }

  Widget _generatePhotoFooter(context)
  {
    Widget caption = new Container();
    TaggedText captionText;

    Widget header = new Container(
        margin: new EdgeInsets.only(left: 16.0, top: 16.0),
        child: new Align(
          alignment: Alignment.centerLeft,
          child: new Container(
            child: new Text('${user.name}:', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
        )
    );

    if(galleryPhoto != null)
      captionText = galleryPhoto.caption;

    if(captionText != null)
      caption = new Container(
        margin: new EdgeInsets.fromLTRB(16.0, 0.0, 10.0, 10.0),
        child: new Row(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ignore: conflicting_dart_import
                captionText.createRichText(normal: TextStyle(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      );

    return new Container(
      decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.grey[300], width: 1.0))),
      child: new Column(
        children: <Widget>[
          header,
          caption,
          _createOptionsButton(context)
        ],
      ),
    );
  }

  Widget _generateInviteFooter(context)
  {
    Widget caption = new Container();
    TaggedText captionText;

    Widget header = new Container(
        margin: new EdgeInsets.only(left: 16.0, top: 16.0),
        child: new Align(
          alignment: Alignment.centerLeft,
          child: new Container(
            child: new Text('${user.name}:', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
        )
    );

    captionText = invite?.inviteText;

    if(captionText != null)
      caption = new Container(
        margin: new EdgeInsets.fromLTRB(16.0, 0.0, 10.0, 10.0),
        child: new Row(
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                captionText.createRichText(normal: TextStyle(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      );

    return new Container(
      decoration: new BoxDecoration(border: new Border(bottom: new BorderSide(color: Colors.grey[300], width: 1.0))),
      child: new Column(
        children: <Widget>[
          header,
          caption,
          _createOptionsButton(context)
        ],
      ),
    );

  }

}

class Social{

  int likes;
  bool liked;

  Social({this.likes, this.liked});

}


class GalleryPhoto
{
  SocialImage img;
  TaggedText caption;
  bool liked;
  int likes;
  User user;

  GalleryPhoto({this.img, this.caption, this.liked, this.likes, this.user});

  static List<GalleryPhoto> generateDummyData()
  {
    List<GalleryPhoto> dummy = [];

    dummy.add(
        new GalleryPhoto(
            img: new SocialImage(
                height: 426.0,
                width: 640.0,
                url: 'https://www.telegraph.co.uk/content/dam/Travel/galleries/travel/picturegalleries/The-worlds-most-recognisable-landmarks/eiffel_2365297a.jpg?imwidth=450'
            ),
            user: User.generateDummyUser(),
            caption: TaggedText('Esto no es en mongos'),
            liked: false,
            likes: 5
        )
    );

    dummy.add(
        new GalleryPhoto(
            img: new SocialImage(
                height: 1280.0,
                width: 720.0,
                url: 'https://i.ytimg.com/vi/mEBFswpYms4/maxresdefault.jpg'
            ),
            user: User.generateDummyUser(),
            caption:TaggedText('Muy buenos tacos') ,
            liked: false,
            likes: 10
        )
    );

    return dummy;
  }
}

class Invite{

  User user;
  TaggedText inviteText;
  SocialImage image;
  Invite({this.user, this.inviteText, this.image});

  static List<Invite> generateDummyData(){
    List<Invite> dummy = [];
    dummy.add(new Invite(
        user: User.generateDummyUser(),
        inviteText: TaggedText('Hoy es viernes y Mongos lo sabe! 🍻'),
        image: new SocialImage(url: 'https://media.giphy.com/media/MS3XuWjQV1FiU/giphy.gif', width: 347.0, height: 480.0)
    ));
    return dummy;
  }
}

class Question {

  int id;
  User questionOwner;
  String topicId;
  String question;
  String topicName;
  List<Answer> answers;

  Question({this.id, this.topicName, this.topicId, this.question, this.questionOwner, this.answers});

  static List<Question> generateDummyData(){
    List<Question> dummy = [];
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 1, topicName: 'Deportes en Quito', topicId: '1', question: 'Conocen un buen lugar para hacer parkour?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 2,topicName: 'Restaurantes en Quito', topicId: '1', question: 'Conocen un buen lugar de comida libanesa?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 1, topicName: 'Deportes en Quito', topicId: '1', question: 'Conocen un buen lugar para hacer parkour?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 2,topicName: 'Restaurantes en Quito', topicId: '1', question: 'Conocen un buen lugar de comida libanesa?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 1, topicName: 'Deportes en Quito', topicId: '1', question: 'Conocen un buen lugar para hacer parkour?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 2,topicName: 'Restaurantes en Quito', topicId: '1', question: 'Conocen un buen lugar de comida libanesa?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 1, topicName: 'Deportes en Quito', topicId: '1', question: 'Conocen un buen lugar para hacer parkour?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 2,topicName: 'Restaurantes en Quito', topicId: '1', question: 'Conocen un buen lugar de comida libanesa?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 1, topicName: 'Deportes en Quito', topicId: '1', question: 'Conocen un buen lugar para hacer parkour?', questionOwner: User.generateDummyUser()));
    dummy.add(new Question(answers: Answer.generateDummyData(), id: 2,topicName: 'Restaurantes en Quito', topicId: '1', question: 'Conocen un buen lugar de comida libanesa?', questionOwner: User.generateDummyUser()));
    return dummy;
  }

  Widget createListItem({double elevation = 0.0, VoidCallback onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.0),
        child: Material(
          animationDuration: Duration(milliseconds: 300),
          elevation: elevation,
          borderRadius: BorderRadius.circular(0.0),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      width: 40.0,
                      height: 40.0,
                      child: questionOwner.getAvatar(),
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(top: 5.0, right: 20.0),
                          child: new Text('Nivel ${questionOwner.level}', textAlign: TextAlign.start, style: new TextStyle(fontSize: 12.0, color: parseColor(questionOwner.currentLevelColor), fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Text(question, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Text('${answers.length}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0, right: 10.0),
                              child: Icon(Icons.question_answer, color: Colors.grey[400], size: 14.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Color parseColor(String hex)
  {
    String raw = '0x' + hex;
    return new Color(int.parse(raw));
  }

  Widget createHeaderItem(elevation)
  {
    return Container(
      child: Material(
        animationDuration: Duration(milliseconds: 300),
        elevation: elevation,
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 25.0,
                        height: 25.0,
                        child: questionOwner.getAvatar(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(questionOwner.name, style: TextStyle(fontSize: 18.0)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(question, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 3.0,
                ),
                child: Text(topicName, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Answer {

  int id;
  int likes;
  User user;
  int timestamp;
  int questionId;
  TaggedText content;

  Answer({this.id, this.questionId, this.content, this.user, this.timestamp, this.likes});

  static List<Answer> generateDummyData(){
    List<Answer> dummy = [];
    dummy.add(new Answer(likes: 0, id: 1, questionId: 1, content: TaggedText('Yo tambien quisiera saber esto.'), user: User.generateDummyUser(), timestamp: new DateTime.now().millisecondsSinceEpoch - 3458));
    dummy.add(new Answer(likes: 100, id: 2, questionId: 1, content: TaggedText.generateTagsExample()[0], user: User.generateDummyUser(), timestamp: new DateTime.now().millisecondsSinceEpoch));
    return dummy;
  }


  Widget createListItem({double elevation = 0.0, VoidCallback onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.0),
        child: Material(
          animationDuration: Duration(milliseconds: 300),
          elevation: elevation,
          borderRadius: BorderRadius.circular(0.0),
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Text(user.name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                      ),
                      new Container(
                        child: new Text('Nivel ${user.level}', textAlign: TextAlign.start, style: new TextStyle(fontSize: 12.0, color: Question.parseColor(user.currentLevelColor), fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: content.createRichText(),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.thumb_up, color: Colors.grey[400], size: 18.0),
                            ),
                            Container(
                              child: Text('$likes', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

