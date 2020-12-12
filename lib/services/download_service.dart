import 'dart:io';
import 'dart:async';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:petcode_app/models/Vaccination.dart';

class DownloadService {
  Future<void> downloadVaccination(Vaccination vaccination) async {
    bool canDownload = await Permission.storage.request().isGranted;
    if (canDownload) {
      String directory = await _findLocalPath();
      FlutterDownloader.enqueue(
          url: vaccination.imageUrl,
          savedDir: directory,
          showNotification: true,
          openFileFromNotification: true,
          fileName:
              vaccination.name + ' ' + vaccination.date.toDate().toString());
    }
  }

  Future<String> _findLocalPath() async {
    if (Platform.isIOS) {
      Directory directory = await path.getApplicationDocumentsDirectory();
      return directory.path;
    } else {
      Directory directory = await path.getExternalStorageDirectory();
      print('DIRECTORY: ' + directory.path);
      return directory.path;
    }
  }
}
