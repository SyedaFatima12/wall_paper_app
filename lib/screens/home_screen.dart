import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_paper_app/controller/api_operations.dart';
import 'package:wall_paper_app/model/category_model.dart';
import 'package:wall_paper_app/screens/full_screen.dart';
import 'package:wall_paper_app/widgets/category_block.dart';
import 'package:wall_paper_app/widgets/custom_search_bar.dart';
import '../model/photo_model.dart';
import '../widgets/custom_appbar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<PhotosModel> wallpaperList=[];
 late List<CategoryModel> categoryList=[];

  getTrendingWallpaper()async{
    wallpaperList=await ApiOperations.getTrendingWallPapers();
    setState(() {

    });

    //print(wallpaperList[0].src);

  }

  getCateList()async{
    categoryList=await ApiOperations.getCategoryList();
    setState(() {

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrendingWallpaper();
    getCateList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const CustomAppBar(),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
           CustomSearchBar(),
          Container(
            height: 50,
            //color: Colors.lightBlue,
            margin: const EdgeInsets.only(top: 15),
            child: ListView.builder(
             // itemCount: wallpaperList.length,
              itemCount: categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
               // return  CategoryBlock(imgSrc: wallpaperList[index].src,);
                return  CategoryBlock(imgSrc: categoryList[index].catImgUrl,imgName: categoryList[index].categoryName);
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: wallpaperList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      //crossAxisSpacing: 11,
                  mainAxisExtent: 400,),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return FullScreen(imgSrc:  wallpaperList[index].src);
                        }));
                      },
                      child: Hero(
                        tag: wallpaperList[index].src,
                        child: Container(
                        
                          margin: const EdgeInsets.symmetric(horizontal: 10,),
                          height:800,
                          width: 50,
                         // color: Colors.orangeAccent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              height:800,
                              width: 50,
                              wallpaperList[index].src,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}

// Text(
// 'Item $index',
// style: Theme.of(context).textTheme.headlineSmall,
// ),

// GridView.count(crossAxisCount: 2,children:List.generate(20, (index){
// return Container(
// child: Image.network("https://images.pexels.com/photos/5651223/pexels-photo-5651223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",fit: BoxFit.cover,),
// );
// }),),
