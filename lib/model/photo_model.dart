class PhotosModel {
   String src;
  String photoName;

   PhotosModel({required this.src,required this.photoName});
  
  static PhotosModel fromJson(Map<String,dynamic> photoMap){
    return PhotosModel(src: photoMap["src"]["portrait"], photoName: photoMap["photographer"]);
  }



}
