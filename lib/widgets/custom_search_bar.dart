import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_paper_app/screens/search_screen.dart';

class CustomSearchBar extends StatelessWidget {
   CustomSearchBar({super.key});
  var myController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),

     child:  TextField(
       controller: myController,
       decoration: InputDecoration(
         fillColor: Colors.black12 ,
         filled: true,

         suffixIcon:  InkWell(child: const Icon(Icons.search),onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
             return  SearchScreen(query: myController.text,);

           }));

         },),

         hintText: "Search WallPapers..",

         border: const OutlineInputBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(20),
           ),
         ),
         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
         enabledBorder: const OutlineInputBorder(
           borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
           borderRadius: BorderRadius.all(
             Radius.circular(32.0),
           ),
         ),
         focusedBorder: const OutlineInputBorder(
           borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
           borderRadius: BorderRadius.all(
             Radius.circular(32.0),
           ),
         ),
       ),
     ),
            );
  }
}
