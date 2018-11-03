import 'package:appfolio/screens/demos/social/SocialImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Business
{
  int id;
  bool liked;
  String name;
  bool hasOwner;
  int likesCount;
  String address;
  String description;
  String label;
  String tags;
  String features;
  int priceRating;
  int ratingCount;
  double latitude;
  double longitude;
  String avatarUrl;
  int qualityRating;
  String phones;
  BusinessPromo promo;
  String categoryName;
  List<SocialImage> images;
  String mainSubcategory;


  Business({this.id, this.name, this.liked, this.description, this.likesCount, this.label, this.address,
    this.qualityRating, this.priceRating, this.ratingCount, this.latitude, this.phones,
    this.longitude, this.avatarUrl, this.images, this.categoryName, this.promo,
    this.features, this.tags, this.mainSubcategory, this.hasOwner});

  static List<Business> generateDummyData()
  {
    List<Business> dummy = [];

    dummy.add(
        new Business(
          id: 1,
          hasOwner: false,
          name: 'User',
          liked: true,
          label: '',
          likesCount: 10,
          description: 'This is a place',
          address: 'address',
          qualityRating: 4,
          priceRating: 2,
          ratingCount: 154,
          latitude: 0.0,
          longitude: 0.0,
          tags: '',
          features: '',
          phones: '',
          categoryName: '',
          mainSubcategory: '',
          avatarUrl: 'https://pbs.twimg.com/media/BxKPl0NIIAAPR9p.jpg',
          images: [
            new SocialImage(url: 'https://ichef-1.bbci.co.uk/news/976/media/images/83351000/jpg/_83351965_explorer273lincolnshirewoldssouthpicturebynicholassilkstone.jpg', width: 976.0, height: 649.0),
            new SocialImage(url: 'http://www.hamnisenja.no/pictures/activity/northern-lights/Tyngeneset-picture-by-Dieter-Wieninger-2.jpg', width: 1065.0, height: 710.0),
          ],
          promo: BusinessPromo.generateDummyData()[0],
        )
    );

    return dummy;
  }

  List<String> get businessPhones
  {
    List<String> list = [];
    if(phones != null)
      list = phones.split(',');
    return list;
  }

  List<String> get businessTags
  {
    List<String> list = [];
    if(tags != null)
      list = tags.split(',');
    return list;
  }

  List<String> get businessFeatures
  {
    List<String> list = [];
    if(features != null)
      list = features.split(',');
    return list;
  }

  Widget createSearchResultItem({VoidCallback onTap})
  {
    return new Container(
      decoration: new BoxDecoration(color: Colors.grey[100], borderRadius: new BorderRadius.circular(10.0)),
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
            onTap: onTap,
            child: new Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                      flex: 1,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: getAvatar(),
                          )
                        ],
                      )),

                  new Expanded(
                      flex: 2,
                      child: new Container(
                        margin: new EdgeInsets.only(left: 5.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(name, style: new TextStyle(color: Colors.grey[700], fontSize: 18.0)),
                            new Text(mainSubcategory, style: new TextStyle(color: Colors.grey, fontSize: 14.0)),
                            new Text(categoryName, style: new TextStyle(color: Colors.grey, fontSize: 12.0)),
                          ],
                        ),
                      )),

                  new Flexible(
                      flex: 1,
                      child: _generateRating()),
                ],
              ),
            )),
      ),
    );
  }

  double get distanceFromUser{
    return 100.0;
  }

  String get distanceText{
    return distanceFromUser > 700 ? 'a ${distanceFromUser.toStringAsFixed(1)}Km' : 'a ${distanceFromUser.toStringAsFixed(0)}m';
  }

  Widget _generateRating()
  {
    Color ratingsColors = Colors.orange;
    if(priceRating == null && qualityRating == null)
      return new Container();

    if(qualityRating != null && qualityRating >= 4.5)
      ratingsColors = Colors.yellow[700];

    else if(priceRating != null && priceRating >= 3)
      ratingsColors = Colors.grey[400];

    List<Widget> dollars = new List();

    for(int i = 0; i < 5; i ++)
    {
      dollars.add( new Container(
        child: new Text('\$', style: new TextStyle(color: priceRating != null && priceRating > i ? Colors.teal : Colors.grey[400], fontSize: 12.0)),
      ));
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            qualityRating != null ? new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      child: new Text('${qualityRating.toStringAsFixed(1)}', style: new TextStyle(fontSize: 18.0, color: ratingsColors))
                  ),
                  new Container(
                    child: new Icon(Icons.star, color: ratingsColors, size: 20.0),
                  ),
                ],
              ),
            )
                : new Container(),
          ],
        ),

        priceRating != null ? new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: dollars,
        ) : new Container(),

        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ratingCount != null && ratingCount > 0 ? new Container(
              margin: new EdgeInsets.only(top: 5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Icon(Icons.thumb_up, color: Colors.cyan, size: 15.0),
                  ),
                  new Container(
                      margin: new EdgeInsets.only(left: 5.0),
                      child: new Text('$ratingCount', style: new TextStyle(fontSize: 14.0, color: Colors.cyan))
                  ),
                ],
              ),
            )
                : new Container(),
          ],
        ),
      ],
    );
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

    return new Container(
      decoration: new BoxDecoration(borderRadius: new BorderRadius.circular(100.0), border: new Border.all(color: Colors.black, width: .5)),
      child: avatar,
    );
  }

  Widget createLikeButton()
  {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new AnimatedContainer(
            padding: new EdgeInsets.only(left: 15.0, right: 5.0, top: 10.0, bottom: 10.0),
            duration: new Duration(milliseconds: 50),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                new SizedBox(
                  child: new Icon(Icons.thumb_up, color: liked ? Colors.cyan[300] : Colors.grey, size: 20.0),
                  width:  22.0,
                  height: 22.0,
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 5.0),
                  child: new AnimatedDefaultTextStyle(
                      child: new Text(likesCount.toString()),
                      style: new TextStyle(fontSize: 15.0, color: liked ? Colors.cyan[300] : Colors.grey),
                      duration: new Duration(milliseconds: 50)
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );


  }

  Widget phoneListItem(int i)
  {
    return new Container(
      margin: new EdgeInsets.only(bottom: 10.0),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(right: 16.0),
            width: 8.0,
            height: 8.0,
            decoration: new BoxDecoration(color: Colors.black, borderRadius:  new BorderRadius.circular(100.0)),
          ),
          new Text(businessPhones[i], style: new TextStyle(color: Colors.black, fontSize: 14.0)),
        ],
      ),
    );
  }

  Widget tagListItem(int i)
  {
    return Container(
      child: Chip(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.blueGrey[700].withOpacity(0.7),
        label: Text(businessTags[i], style: new TextStyle(color: Colors.white, fontSize: 14.0)),
      ),
    );
  }

  Widget featureListItem(int i)
  {
    return new Container(
      margin: new EdgeInsets.only(bottom: 5.0),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(right: 10.0),
            width: 7.0,
            height: 7.0,
            decoration: new BoxDecoration(color: Colors.black, borderRadius:  new BorderRadius.circular(100.0)),
          ),
          new Text(businessFeatures[i], style: new TextStyle(color: Colors.black, fontSize: 14.0)),
        ],
      ),
    );
  }
}


class BusinessPromo
{
  String title;
  SocialImage image;
  String description;
  int endDate;
  bool hasCoupon;

  BusinessPromo({this.title, this.image, this.description, this.endDate, this.hasCoupon});

  static List<BusinessPromo> generateDummyData()
  {
    List<BusinessPromo> dummy = [];

    DateTime tomorrow = new DateTime.now()
      ..add(Duration(days: 1));

    dummy.add(
        new BusinessPromo(
          title: 'Awesome',
          image: new SocialImage(url: 'http://drugo-more.hr/wp-content/uploads/2015/04/party-06.jpg', width: 1920.0, height: 1200.0),
          description: 'Something cool',
          hasCoupon: true,
          endDate: tomorrow.millisecondsSinceEpoch,
        )
    );


    return dummy;
  }

}