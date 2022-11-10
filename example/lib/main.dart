import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  Dio dio = new Dio();
  String filePath = "";

  @override
  void initState() {
    download();
    super.initState();
  }

  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await downloadFile();
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vocsy Plugin E-pub example'),
        ),
        body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        EpubViewer.setConfig(
                          themeColor: Theme.of(context).primaryColor,
                          identifier: "iosBook",
                          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                          allowSharing: true,
                          enableTts: true,
                          nightMode: true,
                        );

                        // get current locator
                        EpubViewer.locatorStream.listen((locator) {
                          print('LOCATOR: $locator');
                        });

                        EpubViewer.open(
                          filePath,
                          lastLocation: EpubLocator.fromJson({
                            "bookId": "2239",
                            "href": "/OEBPS/ch06.xhtml",
                            "created": 1539934158390,
                            "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
                          }),
                        );
                      },
                      child: Text('Open Online E-pub'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        EpubViewer.setConfig(
                          themeColor: Theme.of(context).primaryColor,
                          identifier: "iosBook",
                          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                          allowSharing: true,
                          enableTts: true,
                          nightMode: true,
                        );
                        // get current locator
                        EpubViewer.locatorStream.listen((locator) {
                          print('LOCATOR: $locator');
                        });
                        await EpubViewer.openAsset(
                          'assets/4.epub',
                          lastLocation: EpubLocator.fromJson({
                            "bookId": "2239",
                            "href": "/OEBPS/ch06.xhtml",
                            "created": 1539934158390,
                            "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
                          }),
                        );
                      },
                      child: Text('Open Assets E-pub'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future downloadFile() async {
    if (await Permission.storage.isGranted) {
      await Permission.storage.request();
      await startDownload();
    } else {
      await startDownload();
    }
  }

  startDownload() async {
    Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/chair.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        "https://vocsyinfotech.in/envato/cc/flutter_ebook/uploads/22566_The-Racketeer---John-Grisham.epub",
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
          if (receivedBytes == totalBytes) {
            loading = false;
            setState(() {
              filePath = path;
            });
          }
        },
      );
    } else {
      loading = false;
      setState(() {
        filePath = path;
      });
    }
  }
}
