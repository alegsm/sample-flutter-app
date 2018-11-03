import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AppLink
{
  String android;
  String ios;
  String imageUrl;
  String name;
  String description;
  Color color;

  AppLink({this.ios, this.android, this.imageUrl, this.name, this.description, this.color});

  static List<AppLink> generateAppLinks()
  {
    var list = <AppLink>[];

    String cuballama = 'https://lh3.ggpht.com/IupAF7MK9vPzEMkmsf-pru8VJFyMg9BuKYqdWUysF1_j9WEFcF-RvqSbrqhYsqE22lc=w1440-h620-rw';
    String cuballamaIos ='https://itunes.apple.com/us/app/keynote/id902114323?mt=8';
    String cuballamaAndroid = 'https://play.google.com/store/apps/details?id=com.touwolf.cllappmovil&hl=en';
    list.add(AppLink(color: Colors.blue, ios: cuballamaIos, android: cuballamaAndroid, imageUrl:  cuballama, name: 'Cuballama', description: 'Comunications, web calls, sms, payments.'));

    String cubaviaja = 'https://lh3.googleusercontent.com/2HH_h64LnB4o9yc3u9f8esCPwE4zc_Ea8iBaCgao8BKK9KgnN6CzoENHxdESU-fXmtfp=w1440-h620-rw';
    String cubaviajaAndroid = 'https://play.google.com/store/apps/details?id=com.cubaviaja';
    String cubaviajaIos = 'https://itunes.apple.com/us/app/keynote/id1257926772?mt=8';
    list.add(AppLink(color: Colors.blue[700], ios: cubaviajaIos, android: cubaviajaAndroid, imageUrl: cubaviaja, name: 'Cubaviaja', description: 'Flights booking, scheduling and payments.'));

    String tufacturero = 'https://lh3.googleusercontent.com/MluhParkBbnR-wLA7geMoTuYuMWS7lRoUUE0hK25dtnbYB_jKLhgZDNrxQ2f8J-X4g=w720-h310-rw';
    String tufactureroAndroid = 'https://play.google.com/store/apps/details?id=com.touwolf.tufacturero';
    String tufactureroIos;
    list.add(AppLink(color: Colors.blue[900], ios: tufactureroIos, android: tufactureroAndroid, imageUrl: tufacturero, name: 'Tufacturero', description: 'Electronic invoice app for everyone. The invoices generated are official fiscal documments in Ecuador.'));

    String aqh = 'https://lh3.googleusercontent.com/H3esfTz1zCF9fLLuewkrIfmLIOw1-9zkaGUZdTPr-e9PPln0yTTHREHDWYxhmokJOR8E=w720-h310-rw';
    String aqhAndroid = 'https://play.google.com/store/apps/details?id=com.touwolf.aquiquehay';
    String aqhIos = 'https://itunes.apple.com/ec/app/aquiquehay/id1293344377?l=en&mt=8';
    list.add(AppLink(color: Colors.grey[800], ios: aqhIos, android: aqhAndroid, imageUrl: aqh, name: 'AquiQueHay', description: 'Social place descovery and rating app. Heavily geolocalized'));

    return list;
  }

  Widget createListItem(context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Material(
            color: Colors.transparent,
            elevation: 1.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.network(imageUrl, fit: BoxFit.fitWidth),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            margin: EdgeInsets.only(
                              bottom: 15.0
                            ),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(description, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.0)),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: 20.0
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text('android', textAlign: TextAlign.center, style: TextStyle(color: android != null ? Colors.white : Colors.grey[300], fontSize: 16.0)),
                                  ),
                                  onTap:
                                    ()
                                    {
                                      if(android != null)
                                      {
                                        canLaunch(android).then(
                                          (can)
                                          {
                                            if(can)
                                              launch(android);
                                          }
                                        );
                                      }
                                    },
                                ),
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text('ios', textAlign: TextAlign.center, style: TextStyle(color: ios != null ? Colors.white : Colors.grey[300], fontSize: 16.0)),
                                  ),
                                  onTap:
                                  ()
                                  {
                                    if(ios != null)
                                    {
                                      canLaunch(ios).then(
                                        (can)
                                        {
                                          if(can)
                                            launch(ios);
                                        }
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
      ],
    );
  }
}