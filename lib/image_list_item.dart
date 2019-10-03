import 'package:flutter/material.dart';

class ImageListItem extends StatelessWidget {
  String currentPhoto;
  // Function deletePhoto;

  ImageListItem({@required this.currentPhoto,});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              currentPhoto,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}