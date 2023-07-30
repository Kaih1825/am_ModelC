import 'dart:convert';

import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

var allResults = [];
var allCounturuyCount = [];

class _ResultState extends State<Result> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
  }

  void parseJson() async {
    var jsonText =
        await DefaultAssetBundle.of(context).loadString("res/results.json");
    allResults = jsonDecode(jsonText);
    var allCounturuyCountMap = {};
    for (var i in allResults) {
      allCounturuyCountMap[i["Member"]] = {
        "Gold": 0,
        "Silver": 0,
        "Bronze": 0,
        "Medallion for Excellence": 0
      };
    }
    for (var i in allResults) {
      allCounturuyCountMap[i["Member"]][i["Medal"]]++;
    }
    allCounturuyCountMap.forEach((key, value) {
      allCounturuyCount.add({
        "Country": key,
        "Gold": value["Gold"],
        "Silver": value["Silver"],
        "Bronze": value["Bronze"],
        "Medallion for Excellence": value["Medallion for Excellence"]
      });
    });
    allCounturuyCount.sort((a, b) {
      int aT =
          a["Gold"] + a["Silver"] + a["Bronze"] + a["Medallion for Excellence"];
      int bT =
          b["Gold"] + b["Silver"] + b["Bronze"] + b["Medallion for Excellence"];
      return bT.compareTo(aT);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Mock Data",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "res/r1.png",
                          width: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "res/r2.png",
                          width: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "res/r3.png",
                          width: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "res/r4.png",
                          width: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 15),
                itemCount: allCounturuyCount.isNotEmpty ? 20 : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: SizedBox(
                      height: 100,
                      child: Card(
                        elevation: 0,
                        color: Colors.grey.shade300,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(
                                      "res/Countries/${allCounturuyCount[index]["Country"]}.png"),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allCounturuyCount[index]["Country"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "#${index + 1}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff0F4175),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 23,
                                      child: FittedBox(
                                        fit: BoxFit.none,
                                        child: Text(
                                          allCounturuyCount[index]["Gold"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffE79E29)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 23,
                                      child: FittedBox(
                                        fit: BoxFit.none,
                                        child: Text(
                                          allCounturuyCount[index]["Silver"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffB4B4B4)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 23,
                                      child: FittedBox(
                                        fit: BoxFit.none,
                                        child: Text(
                                          allCounturuyCount[index]["Bronze"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xffB96B0E)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 23,
                                      child: FittedBox(
                                        fit: BoxFit.none,
                                        child: Text(
                                          allCounturuyCount[index]
                                                  ["Medallion for Excellence"]
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff72D0EA)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
