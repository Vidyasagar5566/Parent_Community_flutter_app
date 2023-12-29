import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Servers_Fcm_Notif_Domains/servers.dart';
import '/Firstpage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Circular_designs/Circular_Indicator.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io';
import 'Servers.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name = "";
String google_email = "";
String imageUrl = "";

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignIn googleuser = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleuser.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user!;

  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName!;
    google_email = user.email!;
    imageUrl = user.photoURL!;

    // Only taking the first part of the name, i.e., First Name
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser!;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return google_email;
  }

  return googleSignInAccount.email; // "buddala_b190838ec@nitc.ac.in";
}

Future<void> signOutGoogle() async {
  await GoogleSignIn().signOut();

  print("User Signed Out");
}

class loginpage extends StatefulWidget {
  String error;
  String domain;
  loginpage(this.error, this.domain);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  List imageList = [
    {"id": 1, "image_path": 'images/sliders/events.png'},
    {"id": 2, "image_path": 'images/sliders/academic.png'},
    {"id": 3, "image_path": 'images/sliders/parents.png'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ESMUS",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CarouselSlider(
                      items: imageList
                          .map((item) => Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(item['image_path']),
                                        fit: BoxFit.cover)),
                              ))
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        // aspectRatio: 1,
                        // viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? Colors.red
                                    : Colors.teal),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80, bottom: 100),
              decoration: const BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            await signOutGoogle();
                            String google_email = "";

                            google_email = await signInWithGoogle();

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        email_check(google_email)),
                                (Route<dynamic> route) => false);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          label: Text("Sign In With Email")),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(25),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("close"))
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Center(
                                          child: Text(
                                              "1. If you continue as guest, you are not allowed to receive any notifications and updates from this app",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      const SizedBox(height: 20),
                                      const Center(
                                          child: Text(
                                              "2. Also You are not allowed to share any type of posts, and liking any contents",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      const SizedBox(height: 20),
                                      const Center(
                                          child: Text(
                                              "3. Guests are only allowed to read the data inside the app shared by students",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      const SizedBox(height: 30),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Institute : ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            DropdownButton<String>(
                                                value: widget.domain,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                underline: Container(),
                                                elevation: 0,
                                                items: domains_list_ex_all.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.domain = value!;
                                                  });
                                                })
                                          ]),
                                      const SizedBox(height: 1),
                                      Container(
                                        margin: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: OutlinedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                if (widget.domain != "All") {
                                                  return logincheck1(
                                                      "guest" +
                                                          domains1[
                                                              widget.domain]!,
                                                      "@Vidyasag5566");
                                                } else {
                                                  return logincheck1(
                                                      "guest@nitc.ac.in",
                                                      "@Vidyasag5566");
                                                }
                                              }),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                            child: const Center(
                                                child: Text(
                                              "Continue as guest?",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      child: const Text("Continue As Guest",
                          style: TextStyle(color: Colors.white))),
                )
              ]),
            )
          ],
        ));
  }
}

class email_check extends StatefulWidget {
  String email;
  email_check(this.email);

  @override
  State<email_check> createState() => _email_checkState();
}

class _email_checkState extends State<email_check> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: login_servers().register_email_check(widget.email),
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
            List<dynamic> result = snapshot.data;
            if (!result[0]) {
              return logincheck1(widget.email, result[1]);
            } else {
              return loginpage(
                  "please login with student email_id/check your connection",
                  'Nit Calicut');
            }
          }
        }
        return crclr_ind_appbar();
      },
    );
  }
}

class logincheck1 extends StatefulWidget {
  String email;
  String password;
  logincheck1(this.email, this.password);

  @override
  State<logincheck1> createState() => _logincheck1State();
}

class _logincheck1State extends State<logincheck1> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: login_servers().loginNow(widget.email, widget.password),
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
            bool error = snapshot.data;
            if (!error) {
              return get_ueser_widget(0);
            } else {
              return loginpage(
                  "Invalid credidentials/check your connection", 'Nit Calicut');
            }
          }
        }
        return crclr_ind_appbar();
      },
    );
  }
}



/*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    Container(
                        decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage("images/google.png"),
                        fit: BoxFit.cover,
                      ),
                    )),

                    SizedBox(width: 25),

                    // apple button
                  Container(
                      decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("images/apple.png"),
                      fit: BoxFit.cover,
                    ),
                  )),
                ],
              ),

                const SizedBox(height: 50),

*/