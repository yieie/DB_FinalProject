import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'Navbar.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    final double screenHeight = scrSize.height;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: const Navbar(),
          body: CarouselSlidePage(width: screenWidth, height: screenHeight)
    );
  }
}

class CarouselSlidePage extends StatelessWidget{
  CarouselSlidePage({required this.width,required this.height});
  final double width;
  final double height;
  
  @override
  Widget build(BuildContext context) {
    bool iswidthful = width > 1000 ? true : false;
    return  SafeArea(
        child: Row(
          children: [

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
            
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width: iswidthful?1000:width,
                  child: CarouselSlide(
                    didSelected: (int index) {
                      print("didTapped $index");
                    },
                   ),
                ),

                Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width:iswidthful?1000:width,
                  child: LatestANN(),
                )

              ],
            ),
            

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
          ],
        )
    );
  }
}

class CarouselSlide extends StatelessWidget {
  CarouselSlide({
    super.key,
    required this.didSelected
  });
  final Function(int index) didSelected;

  @override
  Widget build(BuildContext context){
    return CarouselSlider(
      options:CarouselOptions(
        aspectRatio: 30/12,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: List<Widget>.generate(5,(int index){
        return GestureDetector(
          onTap: () => didSelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                ),
                Positioned(
                  child: Text(
                    "$index",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

//最新公告
class LatestANN extends StatelessWidget{
  LatestANN({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10),
          child: Text("最新消息"),
        ),

        Container(
          height: 2,
          //doesn't work
          // padding: EdgeInsets.only(bottom: 50),
          color: Colors.black26,
        ),

        Table(
          columnWidths: {
            0:FlexColumnWidth(1),
            1:FlexColumnWidth(5),
            2:FlexColumnWidth(1)
          },
          children: [
            TableRow(
              children: [
                Container(
                  child: Text("時間1"),
                ),

                Container(
                  child: Text("標題1"),
                ),

                Container(
                  child: Text("詳細資料1"),
                ),
              ]
            ),
            TableRow(
              children: [
                Container(
                  child: Text("時間2"),
                ),

                Container(
                  child: Text("標題2"),
                ),

                Container(
                  child: Text("詳細資料2"),
                ),
              ]
            )
          ],
        )
      ],
    );
  }
}

class ANN {
  String date;
  String title;
  String info;

  ANN(this.date,this.title,this.info);
}