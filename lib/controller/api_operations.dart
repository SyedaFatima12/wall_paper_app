import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wall_paper_app/model/category_model.dart';
import 'package:wall_paper_app/model/photo_model.dart';
List<PhotosModel> trendingWallpapers = [];
List<PhotosModel> searchWallpapersList = [];
List<CategoryModel> categoryList = [];

class ApiOperations {
  static Future<List<PhotosModel>> getTrendingWallPapers() async {

    String baseUrl = "https://api.pexels.com/v1/curated";
    Uri postUri = Uri.parse(baseUrl);

    try {
      http.Response response = await http.get(postUri, headers: {
        "Authorization":
        "pmOUOv93Ybdz3nZQwm90lvm44F2udzfHfimdqPEvqpe7Z7YH6T2DYBkp",
      });

      if (response.statusCode == 200) {
        var data = response.body;
        var json = jsonDecode(data);
        List photos = json['photos'];

        if (photos != null && photos.isNotEmpty) {
          photos.forEach((element) {
            trendingWallpapers.add(PhotosModel.fromJson(element));
          });
        } else {
          // Handle case where photos array is empty or null
          print("No photos found in the API response.");
        }
      } else {
        // Handle HTTP error
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network and decoding errors
      print("Error: $e");
    }

    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallPaperLis(String query)async{

    String baseUrl ="https://api.pexels.com/v1/search?query=$query&per_page=30&page=1";
    Uri postUri = Uri.parse(baseUrl);

    try {
      http.Response response = await http.get(postUri, headers: {
        "Authorization":
        "pmOUOv93Ybdz3nZQwm90lvm44F2udzfHfimdqPEvqpe7Z7YH6T2DYBkp",
      });

      if (response.statusCode == 200) {
        var data = response.body;
        var json = jsonDecode(data);
        List photos = json['photos'];
        searchWallpapersList.clear();
        if (photos != null && photos.isNotEmpty) {
          photos.forEach((element) {
            searchWallpapersList.add(PhotosModel.fromJson(element));
          });
        } else {
          // Handle case where photos array is empty or null
          print("No photos found in the API response.");
        }
      } else {
        // Handle HTTP error
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network and decoding errors
      print("Error: $e");
    }

    return searchWallpapersList;

  }


  static Future<List<CategoryModel>> getCategoryList()async{
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryList.clear();
    for(var catName in cateogryName){
      final random=new Random();
      PhotosModel photoModel=(await searchWallPaperLis(catName))[random.nextInt(10)] ;
      print("IMG SRC IS HERE");
      print(photoModel.src);
      categoryList.add(CategoryModel(categoryName: catName, catImgUrl: photoModel.src));
      

    };
    return categoryList;

}


}


//     .then((value) {
// print(value.body);
// });
// var src=element['src'];
// print(src['portrait']);
