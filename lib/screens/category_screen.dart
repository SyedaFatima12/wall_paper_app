import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_paper_app/controller/api_operations.dart';
import 'package:wall_paper_app/screens/full_screen.dart';
import 'package:wall_paper_app/widgets/category_block.dart';
import 'package:wall_paper_app/widgets/custom_search_bar.dart';
import '../model/photo_model.dart';
import '../widgets/custom_appbar.dart';


class CategoryScreen extends StatefulWidget {
  String imgSrc;
  String imgName;


  CategoryScreen({super.key, required this.imgSrc, required this.imgName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  late List<PhotosModel> wallpaperList=[];

  getWallPaper()async{
    wallpaperList=await ApiOperations.searchWallPaperLis(widget.imgName);
    setState(() {

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallPaper();
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
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  widget.imgSrc,
                ),
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.black38,
              ),
              Positioned(
                left: 120,
                top: 40,
                child: Column(
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.imgName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
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
                    mainAxisExtent: 400,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 800,
                      width: 50,
                      // color: Colors.orangeAccent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              return FullScreen(imgSrc: wallpaperList[index].src);
                              
                            }));
                          },
                          child: Image.network(
                            height: 800,
                            width: 50,
                            wallpaperList[index].src,
                            fit: BoxFit.cover,
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
