import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_paper_app/screens/category_screen.dart';

class CategoryBlock extends StatelessWidget {
   String imgSrc;
   String imgName;
   CategoryBlock({super.key,required this.imgSrc,required this.imgName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context) {
              return  CategoryScreen(imgSrc: imgSrc, imgName: imgName,);
            }));
          },
          child: Stack(
          children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(12),
      child: Image.network(
        height: 50,
        width: 100,
        fit: BoxFit.cover,
        imgSrc,
      ),
    ),
    Container(
    height: 50,
    width: 100,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.black12,
    ),
    ),

     Positioned(
    top: 15,
    left: 30,
    child: Text(imgName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),))
    ],
    ),
    ),
    );
    }
}
