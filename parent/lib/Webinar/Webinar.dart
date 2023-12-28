import 'package:flutter/material.dart';
import '/User_Star_Mark/User_Profile_Star_Mark.dart';
import 'Models.dart';
import '/User_profile/Models.dart';
import 'package:flutter/services.dart';
import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class webinarSection1 extends StatefulWidget {
  List<EVENT_LIST> event_list;
  Username app_user;
  String domain;
  bool profile;
  webinarSection1(this.event_list, this.app_user, this.domain, this.profile);

  @override
  State<webinarSection1> createState() => _webinarSection1State();
}

class _webinarSection1State extends State<webinarSection1> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 10),
              itemBuilder: (BuildContext context, int index) {
                return _building(widget.app_user, index);
              }),
        ],
      ),
    );
  }

  Widget _building(Username app_user, int index) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // Shadow color
              offset:
                  Offset(0, 1), // Offset of the shadow (horizontal, vertical)
              blurRadius: 2, // Spread of the shadow
              spreadRadius: 0, // Expansion of the shadow
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child: index == 1
                    ? Text(
                        utf8convert(
                            "IIT Dreams and life lessions to reach here, placement struggles etc. "),
                        //"Description",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      )
                    : Text(
                        utf8convert(
                            "My whole journey from highschool to IIT and present life at university, join the webinar to solve your career doubts"),
                        //"Description",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      )),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  child: Center(
                      child: Container(
                    height: width / 1.5,
                    width: width,
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: index == 0
                            ? const DecorationImage(
                                image:
                                    AssetImage("images/colleges/webinar.jpeg"),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                                image:
                                    AssetImage("images/colleges/webinar1.jpg"),
                                fit: BoxFit.cover)),
                  )),
                ),
                const Positioned(
                    top: 100,
                    left: 170,
                    child: Center(
                        child: InkWell(
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.blue,
                        size: 60,
                      ),
                    )))
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              UserProfileMark(app_user, user_min(app_user)),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: OutlinedButton(
                          onPressed: () async {},
                          child: const Center(
                              child: Text(
                            "Join",
                            style: TextStyle(color: Colors.blue),
                          ))),
                    ),
                    // Text(post.likes.toString() + "likes")
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "2.7k",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 4)
          ],
        ),
      ),
    );
  }
}
