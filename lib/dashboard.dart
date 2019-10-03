import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:toast/toast.dart';
import './image_list_item.dart';

class Dashboard extends StatefulWidget {
  static const dashboardroute = "/dashboard_path";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Color color = Colors.orange;
  final List<String> photos = [
    "assets/images/beach.jpg",
    "assets/images/forrest.jpg",
    "assets/images/hill.jpg",
    "assets/images/mount.jpg",
    "assets/images/river.jpg",
  ];

  void deletePhoto() {
    if (photos.length != 0) {
      setState(() {
        photos.removeLast();
        Toast.show("Last image deleted", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
    } else {
      Toast.show("No images to delete", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  color,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 4, bottom: 3, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "PhotoFlip",
                      style: TextStyle(
                          fontFamily: "Lobster",
                          color: Colors.orange,
                          fontWeight: FontWeight.w900,
                          fontSize: 35),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        signOutProviders();
                        Toast.show("Logged Out", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                        Navigator.of(context).pop(null);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              photos.length != 0
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      width: double.infinity,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          return ImageListItem(
                            currentPhoto: photos[index],
                          );
                        },
                        itemCount: photos.length,
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 240),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Sorry No Images",
                              style: TextStyle(
                                fontSize: 50,
                                fontFamily: "Lobster",
                                color: Colors.white70,
                              ),
                            )),
                      ),
                    )
            ],
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          backgroundColor: Colors.white54,
          onPressed: deletePhoto,
        ),
      ),
    );
  }
}
