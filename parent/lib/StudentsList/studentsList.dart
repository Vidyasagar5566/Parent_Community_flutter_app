import 'package:flutter/material.dart';
import '/UniversitiesList/Universities.dart';
import '/User_Star_Mark/User_Profile_Star_Mark.dart';
import '/User_profile/Models.dart';
import '../Servers_Fcm_Notif_Domains/servers.dart';
import 'Servers.dart';
import '/Firstpage.dart';

class studentsList extends StatefulWidget {
  Username app_user;
  String domain;
  studentsList(this.app_user, this.domain);

  @override
  State<studentsList> createState() => _studentsListState();
}

class _studentsListState extends State<studentsList> {
  String username_match = "s";
  @override
  Widget build(BuildContext context) {
    return Container(
      // Scaffold(
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.deepPurple, Colors.purple.shade300],
      //         begin: Alignment.topLeft,
      //         end: Alignment.bottomRight,
      //       ),
      //     ),
      //   ),
      //   iconTheme: IconThemeData(color: Colors.black),
      //   title: TextField(
      //     //controller: ,
      //     autofocus: true,
      //     style: const TextStyle(color: Colors.white),
      //     cursorColor: Colors.white,
      //     decoration: const InputDecoration(
      //         hintText: 'Search...',
      //         hintStyle: TextStyle(color: Colors.white54),
      //         border: InputBorder.none),
      //     onChanged: (value) {
      //       setState(() {
      //         username_match = value;
      //       });
      //     },
      //   ),
      //   backgroundColor: Colors.white70,
      // ),
      // body:
      child: FutureBuilder<List<SmallUsername>>(
        future: messanger_servers()
            .get_searched_user_list(username_match, widget.domain, 0),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              List<SmallUsername> users_list = snapshot.data;
              if (users_list.isEmpty) {
                return Container(
                    margin: EdgeInsets.all(30),
                    padding: EdgeInsets.all(30),
                    child: const Text("No Users starting with this Name/Email",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24)));
              } else {
                all_search_users = users_list;
                return user_list_display(
                    users_list, widget.app_user, username_match, widget.domain);
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

List<int> star_marks = [0, 1, 2, 3, 4];
List<bool> is_student_admins = [true, false];
List<bool> is_admins = [true, false];

class user_list_display extends StatefulWidget {
  List<SmallUsername> all_search_users;
  Username app_user;
  String username_match;
  String domain;

  user_list_display(
      this.all_search_users, this.app_user, this.username_match, this.domain);

  @override
  State<user_list_display> createState() => _user_list_displayState();
}

class _user_list_displayState extends State<user_list_display> {
  bool _circularind = false;
  bool total_loaded = true;
  void load_data_fun() async {
    List<SmallUsername> latest_search_users = await messanger_servers()
        .get_searched_user_list(widget.username_match, domains1[widget.domain]!,
            all_search_users.length);
    if (latest_search_users.length != 0) {
      all_search_users += latest_search_users;
      setState(() {
        widget.all_search_users = all_search_users;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("all the feed was shown..",
              style: TextStyle(color: Colors.white))));
    }
    setState(() {
      total_loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton<String>(
                value: "Location",
                underline: Container(),
                elevation: 0,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.black,
                items:
                    ["Location"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {}),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton<String>(
                value: "Language",
                underline: Container(),
                elevation: 0,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.black,
                items:
                    ["Language"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {}),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton<String>(
                value: "Jee ranks",
                underline: Container(),
                elevation: 0,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.black,
                items:
                    ["Jee ranks"].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {}),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton<String>(
                value: "universities",
                underline: Container(),
                elevation: 0,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.black,
                items: ["universities"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {}),
          ),
        ]),
        Expanded(child: _buildFirstScreeen())
      ],
    );
  }

  Widget _buildFirstScreeen() {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: _circularind == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                const Center(child: CircularProgressIndicator()),
                Container()
              ],
            )
          : Column(
              children: [
                ListView.builder(
                    itemCount: widget.all_search_users.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      SmallUsername search_user =
                          widget.all_search_users[index];
                      return _buildLoadingScreen(search_user, index);
                    }),
                const SizedBox(height: 10),
                total_loaded
                    ? Container(
                        width: width,
                        height: 100,
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    total_loaded = false;
                                  });
                                  load_data_fun();
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.add_circle_outline,
                                        size: 40, color: Colors.blue),
                                    Text(
                                      "Tap To Load more",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ))))
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.blue))
              ],
            ),
    );
  }

  Widget _buildLoadingScreen(SmallUsername search_user, int index) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {},
      child: Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 48,
                          child: search_user.fileType! == '1'
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(search_user.profilePic!))
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("images/profile.jpg"))),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        width: (width - 36) / 1.8,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: (width - 36) / 2.4),
                                    child: Text(
                                      search_user.username!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  userMarkNotation(search_user.starMark!)
                                ],
                              ),
                              Text(
                                domains[search_user.domain!]! +
                                    " (" +
                                    search_user.userMark! +
                                    ")",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ]),
                      ),
                    ],
                  ),
                  OutlinedButton(onPressed: () {}, child: Text("Contact"))
                ],
              ),
              const SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(left: 12, top: 8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.apartment_outlined),
                      SizedBox(width: 25),
                      Text('Academic Skills', style: TextStyle(fontSize: 17)),
                    ]),
                    Icon(Icons.arrow_forward, color: Colors.blue, size: 10)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, top: 8),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.grade_outlined),
                      SizedBox(width: 25),
                      Text('Profficinal Skills',
                          style: TextStyle(fontSize: 17)),
                    ]),
                    Icon(Icons.arrow_forward, color: Colors.blue, size: 10),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      Given_Rating(stars[index * 2 + 1]),
                      const SizedBox(width: 4),
                      Text(stars[index * 2 + 1].toString()),
                      const Text(
                        "(" + "1.5k" + ")",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
