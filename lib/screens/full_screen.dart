import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreen extends StatelessWidget {
  final String imgSrc;

  const FullScreen({super.key, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          savedWallpaper(context, imgSrc);
        },
        child: const Text("Download"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Hero(
        tag: imgSrc,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(imgSrc), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

Future<void> savedWallpaper(BuildContext context, String imgUrl) async {
  try {
    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required to download images.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Download Started")),
    );

    // Get the directory to save the file
   // final directory = await getExternalStorageDirectory();
    final directory = await getDownloadsDirectory();
    final path = '${directory?.path}/wallpaper.jpg';

    // Download the image
    final response = await Dio().download(imgUrl, path);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Download completed!'),action: SnackBarAction(label: "file location", onPressed: (){
           OpenFilex.open(path);
           print(path);

        }),),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download failed.')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download failed: $error')),
    );
  }
  // final flutterMediaDownloaderPlugin = MediaDownload();
  // flutterMediaDownloaderPlugin.downloadMedia(context,imgUrl);
  // try {
  //   // Attempt to download the image
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text("Download Started")));
  //   var imageId = await ImageDownloader.downloadImage(imgUrl);
  //
  //   if (imageId != null) {
  //     if(context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text("Download Complete"),
  //           action: SnackBarAction(label: "open file", onPressed: () {}),
  //         ),
  //       );
  //     }
  //
  //   }else{
  //     if(context.mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(const SnackBar(content: Text("Download Failed")));
  //     }
  //     return;
  //   }
  //   // Optionally, get the file name, size, and MIME type
  //   var fileName = await ImageDownloader.findName(imageId);
  //   var path = await ImageDownloader.findPath(imageId);
  //   var size = await ImageDownloader.findByteSize(imageId);
  //   var mimeType = await ImageDownloader.findMimeType(imageId);
  //
  //   // Print image details or handle them as needed
  //   // print('File Name: $fileName');
  //   // print('Path: $path');
  //   // print('Size: $size');
  //   // print('MIME Type: $mimeType');
  //
  //
  // } on PlatformException catch (error) {
  //   print(error.message);
  //   if(context.mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Error: ${error.message}"),
  //     ),
  //   );
  //   }
  // }
}
