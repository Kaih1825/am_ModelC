import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const HomeContainer());
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> with TickerProviderStateMixin {
  late AnimationController? animation;
  late AnimationController? animation2;
  late Animation tween;
  late Animation tween2;
  var scrollController = ScrollController();
  var scrollController2 = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    animation = AnimationController(vsync: this, duration: Duration(seconds: 1));
    tween = Tween(begin: 0.5, end: 0.0).animate(animation!);
    animation!.addListener(() {
      if (scrollController.hasClients) {
        if (scrollController.position.pixels > (Get.width * 3)) {
          scrollController.jumpTo(0);
        }
        if (scrollController2.position.pixels > (Get.width * 3) + 200) {
          scrollController2.jumpTo(200);
        }
        scrollController.animateTo(scrollController.position.pixels + 100, duration: Duration(milliseconds: 500), curve: Curves.linear);
        scrollController2.animateTo(scrollController2.position.pixels + 100, duration: Duration(milliseconds: 500), curve: Curves.linear);
      }
      setState(() {});
    });
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed
        animation!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Reverse animation completed
        animation!.forward();
      }
    });
    animation!.forward();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                          gradient:
                              LinearGradient(colors: [Color(0xff335F82), Color(0xff053A67)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
                      child: Stack(
                        children: [
                          animation == null
                              ? Container()
                              : ClipRRect(
                                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 100,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ListView.builder(
                                          controller: scrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) {
                                            return SizedBox(
                                              width: Get.width + 200,
                                              child: CustomPaint(
                                                painter: PathPainter(tween.value, Color(0x52000000)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          animation == null
                              ? Container()
                              : ClipRRect(
                                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 100,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ListView.builder(
                                          controller: scrollController2,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(left: index == 0 ? Get.width / 2 : 0),
                                              child: SizedBox(
                                                width: Get.width + 200,
                                                child: CustomPaint(
                                                  painter: PathPainter(tween.value, Color(0xA91C5985)),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                              child: Image.asset(
                                "res/logo.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: const TabBar(
                      indicatorColor: Colors.white,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 40),
                      tabs: [
                        Tab(
                          text: "News",
                        ),
                        Tab(
                          text: "Results",
                        ),
                        Tab(
                          text: "History",
                        ),
                      ],
                    ),
                    expandedHeight: 300,
                    collapsedHeight: 100,
                    pinned: true,
                  )
                ];
              },
              body: Column(
                children: [
                  // WaveWidget(
                  //   config: CustomConfig(
                  //     durations: [5000, 4000],
                  //     colors: [Colors.purple, Colors.green],
                  //     heightPercentages: [0.66, 0.66],
                  //   ),
                  //   size: Size(double.infinity, 100),
                  // )
                ],
              )),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final double h1;
  final Color color;

  PathPainter(this.h1, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;
    var path = Path();
    var w = size.width;
    var h = size.height;

    path = Path();
    path.moveTo(0, h);
    path.quadraticBezierTo(w / 2, h1 * h, w, h);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
