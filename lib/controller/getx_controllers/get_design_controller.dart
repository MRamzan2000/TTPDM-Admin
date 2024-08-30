import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AddDesignController extends GetxController{
  //create instance for Image Picker
  var pickedMediaList = <Map<String, String>>[].obs;

  Future<void> pickMedia() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'avi', 'mov', 'mkv'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            final mediaFile = File(file.path!);
            final mediaSize = _getFileSize(mediaFile.lengthSync(), 2);
            final mediaType = _getFileExtension(mediaFile.path);

            final mediaInfo = {
              'path': mediaFile.path,
              'size': mediaSize,
              'type': mediaType,
              'isVideo': isVideo(mediaFile.path) ? 'true' : 'false',
            };

            pickedMediaList.add(mediaInfo);
            log('${isVideo(mediaFile.path) ? 'Video' : 'Image'} size $mediaSize');
          }
        }
      } else {
        log('Sorry, no media selected');
      }
    } catch (e) {
      log('Something went wrong: ${e.toString()}');
    }
  }

  String _getFileSize(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (bytes.bitLength - 1) ~/ 10;
    double size = bytes / (1 << (i * 10));
    return '${size.toStringAsFixed(size < 10 ? decimals : 0)} ${suffixes[i]}';
  }

  String _getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  bool isVideo(String filePath) {
    final fileExtension = _getFileExtension(filePath);
    const videoExtensions = ['mp4', 'avi', 'mov', 'mkv'];
    return videoExtensions.contains(fileExtension);
  }

  void removeMedia(int index) {
    pickedMediaList.removeAt(index);
  }
}