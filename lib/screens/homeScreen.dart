import 'package:appfolio/model/AppLink.dart';
import 'package:appfolio/model/Feature.dart';
import 'package:appfolio/screens/demos/corporate/CoorporateDemo.dart';
import 'package:appfolio/screens/demos/social/SocialDemo.dart';
import 'package:appfolio/screens/demos/store/StoreDemoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback whenVisible;
  HomeScreen({Key key, this.whenVisible}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation curve;
  double value = 0.8;
  bool visible = false;
  double avatarElevation = 0.0;
  ScrollController scrollController = ScrollController();
  List<Feature> designDemoList = Feature.generateDesigns();
  List<AppLink> appDemos = AppLink.generateAppLinks();
  int page = 0;
  double secondPageOpacity = 0.0;
  double thirdPageOpacity = 0.0;
  double fourthPageOpacity = 0.0;
  bool flip = false;
  bool loggedIn = false;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axisDirection == AxisDirection.down ||
        notification.metrics.axisDirection == AxisDirection.up) {
      final double elevation = notification.metrics.extentBefore / 3 <= 40.0
          ? notification.metrics.extentBefore / 3
          : 40.0;

      page = (notification.metrics.extentBefore /
              MediaQuery.of(context).size.height)
          .floor();

      if (elevation != avatarElevation) {
        setState(() {
          avatarElevation = elevation;
        });
      }

      if (page == 0) {
        setState(() {
          secondPageOpacity = 0.0;
          thirdPageOpacity = 0.0;
          fourthPageOpacity = 0.0;
        });
      }
      if (page == 1 && secondPageOpacity != 1.0) {
        setState(() {
          secondPageOpacity = 1.0;
        });
      }
      if (page == 2 && thirdPageOpacity != 1.0) {
        setState(() {
          thirdPageOpacity = 1.0;
        });
      }
      if (page == 3 && fourthPageOpacity != 1.0) {
        setState(() {
          fourthPageOpacity = 1.0;
        });
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) if (widget.whenVisible != null) {
      widget.whenVisible();
      visible = true;
    }
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Container(
          child: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.cyanAccent,
                        Colors.cyan[600],
                        Colors.cyan[900],
                        Colors.blue[900],
                        Colors.purple[900],
                        Colors.pink[900],
                        Colors.pinkAccent
                      ], radius: 9.0, center: Alignment.topRight),
                    ),
                    child: Column(
                      children: <Widget>[
                        createFirstPage(),
                        createSecondPage(),
                        createThirdPage(),
                        createFourthPage(),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: page == 3
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
            page == 3 ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: page == 3 ? Colors.pinkAccent : Colors.white),
        backgroundColor: page == 3 ? Colors.white : Colors.cyan,
        onPressed: () {
          if (page != 3) {
            setState(() {
              page++;
              double position = page * MediaQuery.of(context).size.height;
              scrollController.animateTo(position,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.decelerate);
            });
          } else {
            setState(() {
              page = 0;
              double position = page * MediaQuery.of(context).size.height;
              scrollController.animateTo(position,
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.decelerate);
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget createFirstPage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100.0),
              elevation: avatarElevation,
              child: SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CircleAvatar(
                      backgroundColor:
                          Colors.pink[900].withOpacity(avatarElevation / 40),
                      child: Text('A',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 80.0)),
                      radius: 400.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text('AppFolio',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.center),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 15.0, bottom: 10.0, left: 20.0, right: 20.0),
            child: Text('An app design and development portfolio.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget createSecondPage() {
    List<Widget> demos = [];
    Widget title = Container(
      child: Container(
        child: Text('AppDemos',
            style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.w200),
            textAlign: TextAlign.center),
      ),
    );
    demos.add(title);
    designDemoList.forEach((demo) {
      final d = demo;
      demos.add(demo.createFeatureItem(context, () {
        if (designDemoList.indexOf(d) == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return SocialDemoPage();
          }));
        }
        if (designDemoList.indexOf(d) == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return StoreDemoPage();
          }));
        }
        if (designDemoList.indexOf(d) == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return CorporateDemo();
          }));
        }
      }));
    });
    return Container(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: secondPageOpacity,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: demos,
          ),
        ),
      ),
    );
  }

  Widget createThirdPage() {
    List<Widget> demos = [];
    Widget title = Container(
      margin: EdgeInsets.only(top: 100.0),
      child: Text('Real Apps',
          style: TextStyle(
              fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.w200),
          textAlign: TextAlign.center),
    );
    demos.add(title);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: thirdPageOpacity,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              title,
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c, i) {
                    return appDemos[i].createListItem(context);
                  },
                  itemCount: appDemos.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createFourthPage() {
    Widget title = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Text('Get in touch',
          style: TextStyle(
              fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w200),
          textAlign: TextAlign.center),
    );
    Widget subTitle = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: Text('Want a an awesome app? \nChat with me.',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w200),
          textAlign: TextAlign.center),
    );

    return AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: fourthPageOpacity,
        child: AnimatedContainer(
            height: MediaQuery.of(context).size.height,
            duration: Duration(milliseconds: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                title,
                subTitle,
                IconButton(
                  icon: Icon(Icons.mail, color: Colors.white, size: 50.0),
                  iconSize: 50.0,
                  onPressed:
                      /*(){
                setState(() {
                  flip = !flip;
                });
                logIn();
              }),*/
                  () {
                    String subject = 'I want an awesome app';
                    String body = 'Your project goes here:';
                    String email = 'projects@apollosoft.app';
                    String encodedSubject = Uri.encodeComponent(subject);
                    String encoded = Uri.encodeComponent(body);
                    String url =
                        'mailto:$email?subject=$encodedSubject&body=$encoded';
                    print(url);
                    canLaunch(url).then((can) {
                      if (can) launch(url);
                    });
                  },
                )
              ],
            )));
  }
}
