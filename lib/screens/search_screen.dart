import 'package:flutter/material.dart';
import 'package:wall_paper_app/widgets/category_block.dart';
import 'package:wall_paper_app/widgets/custom_search_bar.dart';
import '../controller/api_operations.dart';
import '../model/photo_model.dart';
import '../widgets/custom_appbar.dart';
import 'full_screen.dart';

class SearchScreen extends StatefulWidget {
  String query;

  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchList = [];

  getSearchWallpapers(String query) async {
    searchList = await ApiOperations.searchWallPaperLis(query);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpapers(widget.query);
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
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    //crossAxisSpacing: 11,
                    mainAxisExtent: 400,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return FullScreen(imgSrc:  searchList[index].src);
                        }));
                      },
                      child: Hero(
                        
                        tag: searchList[index].src,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: 800,
                          width: 50,
                          // color: Colors.orangeAccent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              height: 800,
                              width: 50,
                              searchList[index].src,
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
