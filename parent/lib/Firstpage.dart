import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Webinar/Webinar.dart';
import '/StudentsList/studentsList.dart';
import '/Circular_designs/Circular_Indicator.dart';
import '/Login/Servers.dart';
import '/Login/login.dart';
import '/Posts/post.dart';
import '/Register_Update/Register.dart';
import '/UniversitiesList/Universities.dart';
import '/User_Star_Mark/User_Profile_Star_Mark.dart';
import '/Activities/Models.dart';
import '/Threads/Models.dart';
import '/User_profile/Models.dart';
import '/Posts/Models.dart';

List<POST_LIST> all_posts = [];
List<ALERT_LIST> all_alerts = [];
List<EVENT_LIST> all_events = [];
List<POST_LIST> user_posts = [];
List<SmallUsername> all_search_users = [];
Username app_user = Username();

class get_ueser_widget extends StatefulWidget {
  int curr_index;
  get_ueser_widget(this.curr_index);

  @override
  State<get_ueser_widget> createState() => _get_ueser_widgetState();
}

class _get_ueser_widgetState extends State<get_ueser_widget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Username>(
      future: login_servers().get_user(''),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return crclr_ind_error();
          } else if (snapshot.hasData) {
            app_user = snapshot.data;
            if (app_user.email == null) {
              return loginpage(
                  "error occured please login again", 'Nit Calicut');
            }
            app_user = app_user;

            star_user_mark(app_user);

            if (!app_user.isDetails!) {
              return LoginRegister(app_user);
            }
            if (Platform.isAndroid) {
              if (app_user.updateMark != "instabook4") {
                return appUpdate();
              } else {
                return firstPage(
                    curr_index: widget.curr_index, app_user: app_user);
              }
            } else if (Platform.isIOS) {
              if (app_user.updateMark != "instabook4") {
                return appUpdate();
              } else {
                return firstPage(
                    curr_index: widget.curr_index, app_user: app_user);
              }
            }
          }
        }
        return crclr_ind_appbar();
      },
    );
  }
}

class firstPage extends StatefulWidget {
  int curr_index;
  Username app_user;
  firstPage({super.key, required this.curr_index, required this.app_user});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  var comment;
  bool sending_cmnt = false;
  TextEditingController _controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: RefreshIndicator(
          displacement: 150,
          //backgroundColor: Colors.yellow,
          color: Colors.blue,
          strokeWidth: 2,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            all_posts = [];
            all_alerts = [];
            all_events = [];
            user_posts = [];
            all_search_users = [];
            await Future.delayed(Duration(milliseconds: 400));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        get_ueser_widget(widget.curr_index)),
                (Route<dynamic> route) => false);
          },
          child: Scaffold(
            appBar: widget.curr_index == 0 //|| widget.curr_index == 3
                ? AppBar(
                    title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("images/sagar.jpeg"),
                      ),
                      const SizedBox(width: 40),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.only(right: 7),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 32,
                                width: width * 0.60,
                                child: TextField(
                                  controller: _controller1,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      comment = value;
                                      if (comment == "") {
                                        comment = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Icon(Icons.search, size: 20)
                            ],
                          )),
                    ],
                  ))
                : widget.curr_index == 1
                    ? AppBar(title: Text("Institutions"), centerTitle: false)
                    : widget.curr_index == 2
                        ? AppBar(
                            title: Text("Freelancing"),
                            actions: [
                              TextButton(
                                  onPressed: () {}, child: Text("Filters"))
                            ],
                            centerTitle: false)
                        : AppBar(
                            title: Text("Webinars"),
                            centerTitle: false,
                          ),
            body: widget.curr_index == 0
                ? all_posts.isEmpty
                    ? postwidget(widget.app_user, "All")
                    : postwidget1(all_posts, widget.app_user, 'All', false)
                : widget.curr_index == 1
                    ? universitiesList()
                    : widget.curr_index == 2
                        ? all_search_users.isEmpty
                            ? studentsList(widget.app_user, 'All')
                            : user_list_display(
                                all_search_users, widget.app_user, '', 'All')
                        : webinarSection1([], app_user, 'All', false),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.blue,
              backgroundColor: Colors.white70,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(
                      Icons.home,
                    )),
                BottomNavigationBarItem(
                    label: "Universities",
                    icon: FaIcon(Icons.apartment_outlined)),
                BottomNavigationBarItem(
                    label: "Students",
                    icon: Icon(
                      Icons.group_add_outlined,
                      size: 30,
                    )),
                BottomNavigationBarItem(
                    label: "Guidance",
                    icon: Icon(
                      Icons.video_call_outlined,
                    )),
              ],
              currentIndex: widget.curr_index,
              onTap: (int index) {
                setState(() {
                  widget.curr_index = index;
                });
              },
            ),
          )),
    );
  }
}
