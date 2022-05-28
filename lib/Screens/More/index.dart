import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Helpers/myColors.dart';
import 'package:movies_app/Screens/Details/index.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  List<dynamic> myList = Get.arguments;

  Widget ShowContainer() {
    return Expanded(
      child: ListView.separated(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => Details(),
                  arguments: myList[index],
                  duration: Duration(milliseconds: 700),
                  transition: Transition.leftToRightWithFade);
            },
            child: Container(
              // color: index % 2 == 0 ? Colors.deepPurple : Colors.pinkAccent,
              width: MediaQuery.of(context).size.width,
              height: 185,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: NetworkImage(myList[index].Image),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myList[index].Title,
                            style: TextStyle(fontSize: 23),
                          ),
                          Text(
                            myList[index].Year,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            myList[index].Crew,
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: yellow,
                                size: 23,
                              ),
                              Text(
                                ' ' + myList[index].IMDbRating,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: black54,
            indent: 8,
            endIndent: 8,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar,
      backgroundColor: grey,
      body: Column(
        children: [
          ShowContainer(),
        ],
      ),
    );
  }
}
