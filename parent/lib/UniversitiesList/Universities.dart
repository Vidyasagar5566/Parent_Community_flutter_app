import 'package:flutter/material.dart';

Map<int, Map<String, String>> dataSets = {
  4: {"name": "IIT Bombay", "image": "images/colleges/bombay.jpeg"},
  2: {"name": "IIT Madras", "image": "images/colleges/chennai.jpg"},
  5: {"name": "IIT Delhi", "image": "images/colleges/delhi.png"},
  9: {"name": "NIT Trichy", "image": "images/colleges/trichy.jpeg"},
  1: {"name": "NIT Warangal", "image": "images/colleges/warangal.jpeg"},
  8: {"name": "IIT Kharagpur", "image": "images/colleges/karaghpure.png"},
  6: {"name": "IIT Hyderabad", "image": "images/colleges/IIT_Hyderabad.png"},
  7: {"name": "NIT Surathkal", "image": "images/colleges/NITK.png"},
  3: {"name": "NIT Calicut", "image": "images/colleges/calicut.jpeg"},
  0: {"name": "IIT Roorke", "image": "images/colleges/iit_toorkee.jpeg"},
};

List<double> stars = [4.7, 4.9, 4.2, 3.9, 4.0, 5, 4.6, 4.4, 3.0, 3.7];

class Given_Rating extends StatefulWidget {
  double sub_rating;
  Given_Rating(this.sub_rating);

  @override
  State<Given_Rating> createState() => _Given_RatingState();
}

class _Given_RatingState extends State<Given_Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.sub_rating.floor() >= 1
            ? const Icon(Icons.star, color: Colors.green, size: 16)
            : const Icon(Icons.star_border, color: Colors.black, size: 16),
        widget.sub_rating.floor() >= 2
            ? const Icon(Icons.star, color: Colors.green, size: 16)
            : const Icon(Icons.star_border, color: Colors.black, size: 16),
        widget.sub_rating.floor() >= 3
            ? const Icon(Icons.star, color: Colors.green, size: 16)
            : const Icon(Icons.star_border, color: Colors.black, size: 16),
        widget.sub_rating.floor() >= 4
            ? const Icon(Icons.star, color: Colors.green, size: 16)
            : const Icon(Icons.star_border, color: Colors.black, size: 16),
        widget.sub_rating.floor() >= 5
            ? const Icon(Icons.star, color: Colors.green, size: 16)
            : const Icon(Icons.star_border, color: Colors.black, size: 16),
      ],
    );
  }
}

List<Container> tabs = [
  Container(
    width: 110,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: const Tab(
        child: Text(
      "Universities",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )),
  ),
  Container(
    width: 90,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: const Tab(
        child: Text(
      "Colleges",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )),
  ),
  Container(
    width: 80,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: const Tab(
        child: Text(
      "Schools",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )),
  ),
  Container(
    width: 100,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: const Tab(
        child: Text(
      "Coaching's",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )),
  ),
  Container(
    width: 110,
    padding: EdgeInsets.only(left: 5, right: 5),
    child: const Tab(
        child: Text(
      "Organization",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )),
  )
];

class universitiesList extends StatefulWidget {
  const universitiesList({super.key});

  @override
  State<universitiesList> createState() => _universitiesListState();
}

class _universitiesListState extends State<universitiesList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          Container(
            height: 50,
            child: AppBar(
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(21), // Creates border
                    color: Colors.blue),
                indicatorColor: Colors.blueGrey,
                isScrollable: true,
                labelColor: Colors.black,
                tabs: tabs,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buid_loading_screen(),
                _buid_loading_screen(),
                _buid_loading_screen(),
                _buid_loading_screen(),
                _buid_loading_screen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buid_loading_screen() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 4),
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var val = dataSets[index * 2];
                var val1 = dataSets[(index * 2) + 1];
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (width - 100) / 2,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Shadow color
                                offset: Offset(0,
                                    1), // Offset of the shadow (horizontal, vertical)
                                blurRadius: 4, // Spread of the shadow
                                spreadRadius: 0, // Expansion of the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    width: (width - 20) / 3,
                                    child: Text(val!["name"]!,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis)),
                                index % 2 == 0
                                    ? Icon(Icons.verified, color: Colors.green)
                                    : Container()
                              ],
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Container();
                                }));
                              },
                              child: Container(
                                width: (width - 50) / 2,
                                height: (width - 100) / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(val["image"]!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Given_Rating(stars[index * 2]),
                                const SizedBox(width: 4),
                                Text(stars[index * 2].toString()),
                                const Text(
                                  "(" + "2.3k" + ")",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                                margin: EdgeInsets.only(left: 4),
                                height: 30,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: OutlinedButton(
                                    onPressed: () async {},
                                    child: const Center(
                                        child: Text(
                                      "Fallowing",
                                      style: TextStyle(color: Colors.white),
                                    ))))
                          ],
                        ),
                      ),
                      Container(
                        width: (width - 100) / 2,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Shadow color
                                offset: Offset(0,
                                    1), // Offset of the shadow (horizontal, vertical)
                                blurRadius: 4, // Spread of the shadow
                                spreadRadius: 0, // Expansion of the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: (width - 20) / 3,
                                    padding: EdgeInsets.all(5),
                                    child: Text(val1!['name']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)),
                                index % 3 == 0
                                    ? Icon(Icons.verified, color: Colors.green)
                                    : Container()
                              ],
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Container();
                                }));
                              },
                              child: Container(
                                width: (width - 50) / 2,
                                height: (width - 100) / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(val1["image"]!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Given_Rating(stars[index * 2 + 1]),
                                const SizedBox(width: 4),
                                Text(stars[index * 2 + 1].toString()),
                                const Text(
                                  "(" + "4.5k" + ")",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                                width: 130,
                                margin: EdgeInsets.only(left: 4),
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: OutlinedButton(
                                    onPressed: () async {},
                                    child: const Center(
                                        child: Text(
                                      "Fallowing",
                                      style: TextStyle(color: Colors.white),
                                    ))))
                          ],
                        ),
                      )
                    ]);
              })
        ]),
      ),
    );
  }
}
