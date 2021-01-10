import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:photo_view/photo_view.dart';

class PreviewVaccinationWidget extends StatelessWidget {
  final String vaccinationImageUrl;

  PreviewVaccinationWidget({Key key, this.vaccinationImageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
              imageProvider: CachedNetworkImageProvider(vaccinationImageUrl)),
          Positioned(
            top: height * 0.068,
            left: width * 0.085,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
