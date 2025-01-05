import 'package:carousel_slider/carousel_slider.dart';
import 'package:db_finalproject/common/components/AnnDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/common/logic/AnnouncementService.dart';
import 'package:db_finalproject/data/Announcement.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: const Navbar(),
          body: CarouselSlidePage(width: screenWidth)
    );
  }
}

class CarouselSlidePage extends StatelessWidget{
  const CarouselSlidePage({super.key, required this.width});
  final double width;
  
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
                const Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width: iswidthful?1000:width,
                  child: const CarouselSlide(),
                ),

                const Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width:iswidthful?1000:width,
                  child: const LatestAnn(),
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

class CarouselSlide extends StatefulWidget{
  const CarouselSlide({super.key});

  @override
  State<CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List<String> list = [
    // 'http://localhost:8081/images/testpic1.png',
    'http://localhost:8080/images/carousel/display1.jpg',
    'http://localhost:8080/images/carousel/display2.png'
    ];

  @override
  Widget build(BuildContext context){
    

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 30/12,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            scrollPhysics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
                setState(() {
                  _current = index; // 更新當前索引
                });
              },
          ),
          items: list.map((item) => GestureDetector(
            child: Image.network(item),
          )).toList(),
          carouselController: _controller
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.asMap().entries.map((entry){
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white:Colors.black).withOpacity(_current == entry.key? 0.9:0.4)
                ),
              ),
            );
          }).toList(),
        )
      ]
    );
  }
}

//最新公告，表格上只會顯示data、title，其他資訊要點進去才看得到
class LatestAnn extends StatefulWidget{
  const LatestAnn({super.key});

  @override
  State<LatestAnn> createState() => _LastestAnnState();
}

class _LastestAnnState extends State<LatestAnn>{
  final AnnouncementService _announcementService = AnnouncementService();
  List<Announcement> AnnList = [];

  Future<void> fetchAnnouncements() async {
    Announcement test1=Announcement(id: 1,date: '2024-12-11',title: '我是測試資料1');
    Announcement test2=Announcement(id: 2,date: '2024-12-10',title: '我是測試資料1');
    try {
      AnnList = await _announcementService.getBasicAnnouncement();
      setState((){});
    } catch (e) {
      print('Error: fectch Announments');
      setState((){
        AnnList = [test1,test2];
      });
    }
  }

   @override
  void initState() {
    super.initState();
    fetchAnnouncements(); // 在初始化時開始異步加載資料
  }

  @override
  Widget build(BuildContext context) {
    bool _hoveredRowIndex=false;
    // print("AnnList:");
    // print(AnnList.isNotEmpty ? AnnList.first.date : "No data");
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10,bottom: 10),
          child: const Text(
            "最新消息",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 2,
          color: Colors.black26,
        ),
        AnnList.isEmpty
            ? const Center(child: CircularProgressIndicator()) // 顯示載入中
            : Table(
                children: AnnList.map((item) => TableRow(children: [
                    InkWell(
                        onHover: (hovering){
                          setState(() {
                            _hoveredRowIndex = hovering;
                          });
                        },
                        onTap: () {
                          print(item.title);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnnDetailPage(AnnID: item.id),
                            ),
                          );

                        } ,
                        child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top:16.0,left: 10.0,right:32.0,bottom: 16.0),
                                child: Text(
                                  item.date!,
                                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w100),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.only(right:16.0),
                                child: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                      ),
                ])).toList(),
              ),
      ],
    );
  }
}