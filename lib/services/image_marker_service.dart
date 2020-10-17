import 'dart:async';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImageMarkerService {
  Future<ui.Image> getImageFromUrl(String imageUrl) async {
    http.Response response = await http.get(
      imageUrl,
    );
    Uint8List imageBytes = response.bodyBytes;

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Future<BitmapDescriptor> getMarkerIcon(
      String imageUrl, Size size, Color outlineColor) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint outlinePaint = Paint()..color = outlineColor;
    final double outlineWidth = 5.0;

    final double imageOffset = outlineWidth; // + borderWidth;

    // Add outline circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        outlinePaint);

    canvas.drawPath(
        Path()
          ..moveTo(size.width * 0.5 - size.width * 0.25, size.height * 0.9)
          ..lineTo(size.width * 0.5, size.height * 1.15)
          ..lineTo(size.width * 0.5 + size.width * 0.25, size.height * 0.9)
          ..close(),
        outlinePaint);

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromUrl(imageUrl);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(), (size.height + size.height * 0.15).toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
