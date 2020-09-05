import 'package:cached_network_image/cached_network_image.dart';

class PlacePhoto {
  CachedNetworkImageProvider photo;
  List<String> attributionNames;
  List<String> attributionLinks;

  PlacePhoto({this.photo, this.attributionNames, this.attributionLinks});

}