class CategoryModel{

  String categoryName;
  String catImgUrl;

  CategoryModel({required this.categoryName, required this.catImgUrl});
  
  static CategoryModel fromJson(Map<String,dynamic> category){

    return CategoryModel(categoryName: category["CategoryName"], catImgUrl: category["imgUrl"]);
  }
  

}