// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ohtun = true; //the first player is 0
  List<String> decode = ["", "", "", "", "", "", "", "", ""];
  int tab = 0;
  void _ontab(int index) {
    tab += 1;
    setState(() {
      if (ohtun && decode[index] == '') {
        decode[index] = "0";
      } else if (ohtun == false && decode[index] == '') {
        decode[index] = "x";
      }
      ohtun = !ohtun;
      cheakwinnner();
    });
  }

  int score0 = 0;
  int scorex = 0;
  var mystyle = const TextStyle(color: Colors.white, fontSize: 30);
  bool shouldPop = true;

  Future<bool?> backbuttonpress(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          // ignore: prefer_const_constructors
          return AlertDialog(
            title: const Text("Do You Want to close it?"),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("No")),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text("Yes"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: WillPopScope(
        onWillPop: () async {
          return await backbuttonpress(context) ?? false;
        },
        child: Column(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player-0",
                        style: mystyle,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        score0.toString(),
                        style: mystyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player-x",
                        style: mystyle,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        scorex.toString(),
                        style: mystyle,
                      )
                    ],
                  ),
                )
              ],
            )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    var textStyle =
                        const TextStyle(color: Colors.white, fontSize: 40);
                    return GestureDetector(
                      onTap: () {
                        _ontab(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red.shade100),
                        ),
                        child: Center(
                          child: Text(
                            decode[index],
                            style: textStyle,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void cheakwinnner() {
    if (decode[0] == decode[1] && decode[0] == decode[2] && decode[0] != '') {
      _showdialog(decode[0]);
    }

    // checks 2nd row
    if (decode[3] == decode[4] && decode[3] == decode[5] && decode[3] != '') {
      _showdialog(decode[3]);
    }

    // checks 3rd row
    if (decode[6] == decode[7] && decode[6] == decode[8] && decode[6] != '') {
      _showdialog(decode[6]);
    }

    // checks 1st column
    if (decode[0] == decode[3] && decode[0] == decode[6] && decode[0] != '') {
      _showdialog(decode[0]);
    }

    // checks 2nd column
    if (decode[1] == decode[4] && decode[1] == decode[7] && decode[1] != '') {
      _showdialog(decode[1]);
    }

    // checks 3rd column
    if (decode[2] == decode[5] && decode[2] == decode[8] && decode[2] != '') {
      _showdialog(decode[2]);
    }

    // checks diagonal
    if (decode[6] == decode[4] && decode[6] == decode[2] && decode[6] != '') {
      _showdialog(decode[6]);
    }

    // checks diagonal
    if (decode[0] == decode[4] && decode[0] == decode[8] && decode[0] != '') {
      _showdialog(decode[0]);
    } else if (tab == 9) {
      _showdialog('NO-');
    }
  }

  _showdialog(var value) {
    tab = 0;
    print(value);
    if (value == "0") {
      score0 = score0 + 1;
      print(score0);
    } else if (value == "x") {
      scorex = scorex + 1;
      print(scorex);
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(value + " -winner"),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < 9; i++) {
                        decode[i] = "";
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Agin!")),
            ],
          );
        });
  }
}
