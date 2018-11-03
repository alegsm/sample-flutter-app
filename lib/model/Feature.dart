import 'package:flutter/material.dart';
class Feature {
  String name;
  String description;
  IconData icon;
  Color color;

  Feature({this.name, this.description, this.icon, this.color});

 static  List<Feature> generateAppFeatures(){
    var features = <Feature> [];
    features.add(Feature(name: 'Location', description: 'Handling device locaiton', icon: Icons.location_on, color: Colors.black));
    return features;
  }

  static List<Feature> generateDesigns(){
    var features = <Feature> [];
    features.add(
      Feature(
        name: 'Social',
        description: 'Timeline demo. Based on a released app.',
        icon: Icons.supervisor_account,
        color: Colors.cyan[700],
      )
    );
    features.add(Feature(name: 'Shop', description: 'Shopping app demo. Based on a released app.', icon: Icons.shopping_cart, color: Colors.pink[900]));
    features.add(Feature(name: 'Corporate', description: 'Corporate receipt design. Based on a released app.', icon: Icons.business, color: Colors.grey[700]));
    return features;
  }

  Widget createFeatureItem(context, onTap)
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
        width: MediaQuery.of(context).size.width - 80,
        height: MediaQuery.of(context).size.height / 3 - 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                  color: color,
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    margin: EdgeInsets.all(
                      15.0,
                    ),
                    child: Icon(icon, color: Colors.white, size: 20.0),
                  ),
                ),
              ],
            ),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.only(left: 15.0),
                   child: Text(name, style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w300)),
                 ),
                 Container(
                   margin: EdgeInsets.only(
                     left: 15.0,
                   ),
                   child: Text(description, style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.w300)),
                 )
               ],
             ),
           )
          ],
        ),
      ),
    );
  }


}