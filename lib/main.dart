import 'dart:async';

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
    animation = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation2 = AnimationController(vsync: this, duration: Duration(seconds: 2));
    tween = Tween(begin: 0.5, end: 0.0).animate(animation!);
    tween2 = Tween(begin: 0.5, end: 0.0).animate(animation2!);
    animation!.addListener(() {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.pixels + 100, duration: Duration(seconds: 1), curve: Curves.linear);
        scrollController2.animateTo(scrollController2.position.pixels + 100, duration: Duration(seconds: 1), curve: Curves.linear);
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
    Timer(Duration(seconds: 1), () {
      animation2!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Animation completed
          animation2!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // Reverse animation completed
          animation2!.forward();
        }
      });
      animation2!.forward();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NestedScrollView(
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
                                              painter: PathPainter(tween.value, tween2.value, Color(0x52000000)),
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
                                                painter: PathPainter(tween.value, tween2.value, Color(0xA91C5985)),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              "res/logo.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandedHeight: 300,
                  collapsedHeight: 100,
                  pinned: true,
                )
              ];
            },
            body: Text("")),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final double h1;
  final double h2;
  final Color color;

  PathPainter(this.h1, this.h2, this.color);

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
