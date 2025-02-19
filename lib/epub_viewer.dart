library ethiobook_epub_viewer;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'model/enum/epub_scroll_direction.dart';
part 'model/epub_locator.dart';
part 'utils/util.dart';

class EtBookEpub {
  static const MethodChannel _channel = const MethodChannel('ethiobook_epub_viewer');
  static const EventChannel _pageChannel = const EventChannel('page');

  static void setConfig({
    Color themeColor = Colors.blue,
    String identifier = 'book',
    bool nightMode = false,
    bool sepiaMode = false,
    EpubScrollDirection scrollDirection = EpubScrollDirection.ALLDIRECTIONS,
    bool allowSharing = false,
    bool enableTts = false,
  }) async {
    Map<String, dynamic> args = { // Corrected map name to 'args'
      "identifier": identifier,
      "themeColor": Util.getHexFromColor(themeColor),
      "scrollDirection": Util.getDirection(scrollDirection),
      "allowSharing": allowSharing,
      'enableTts': enableTts,
      'nightMode': nightMode,
      'sepiaMode': sepiaMode,
    };
    await _channel.invokeMethod('setConfig', args); // Corrected argument name
  }

  static void open(String bookPath, {EpubLocator? lastLocation}) async {
    Map<String, dynamic> args = { // Corrected map name to 'args'
      "bookPath": bookPath,
      'lastLocation': lastLocation == null ? '' : jsonEncode(lastLocation.toJson()),
    };
    await _channel.invokeMethod('open', args); // Corrected argument name
  }

  static void closeReader() async {
    await _channel.invokeMethod('close');
  }

  static Future openAsset(String bookPath, {EpubLocator? lastLocation}) async {
    if (extension(bookPath) == '.epub') {
      Map<String, dynamic> args = { // Corrected map name to 'args'
        "bookPath": (await Util.getFileFromAsset(bookPath)).path,
        'lastLocation': lastLocation == null ? '' : jsonEncode(lastLocation.toJson()),
      };
      await _channel.invokeMethod('open', args); // Corrected argument name
    } else {
      throw ('${extension(bookPath)} cannot be opened, use an EPUB File');
    }
  }

  // REMOVE THIS FUNCTION COMPLETELY
  // static Future setChannel() async {
  //   await _channel.invokeMethod('setChannel');
  // }

  static Stream get locatorStream {
    return _pageChannel.receiveBroadcastStream().map((value) => value);
  }
}