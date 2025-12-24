import 'dart:math';

import 'package:calculator/data/notifiers.dart';
import 'package:calculator/pages/result_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({super.key});

  @override
  State<BmiCalculatorPage> createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  bool isMale = true;
  bool isFeMale = false;

  final Color inactiveColor = const Color.fromARGB(255, 97, 97, 97);
  final Color activeColor = const Color.fromARGB(255, 52, 52, 52);

  double height = 150;
  double weight = 50;
  double age = 20;

  Timer? _timer;

  double calculateResult(double a, double b) {
    return (a / (pow(b / 100, 2)));
  }

  void increaseTimerage() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        age++;
      });
    });
  }

  void minusTimerage() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        age--;
      });
    });
  }

  void increaseTimerweight() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        weight++;
      });
    });
  }

  void minusTimerWeight() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        weight--;
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bmi Calculator'),
        backgroundColor: const Color.fromARGB(206, 255, 153, 0),
        actions: [
          PopupMenuButton(
            popUpAnimationStyle: AnimationStyle(
              curve: FlippedCurve(Curves.slowMiddle),
            ),
            shadowColor: Colors.orange,
            elevation: 2,
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Text('Calculator'),
                    onTap: () {
                      Navigator.pushNamed(context, 'Calculator');
                    },
                  ),
                  PopupMenuItem(
                    child: Text('Settings'),
                    onTap: () {
                      Navigator.pushNamed(context, 'Settings');
                    },
                  ),
                  PopupMenuItem(
                    child: Text('About'),
                    onTap: () {
                      Navigator.pushNamed(context, 'About');
                    },
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          //!-------------------------------------------(1)--------------------------------------------------------
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                        isFeMale = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMale == false ? inactiveColor : activeColor,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.male, color: Colors.white, size: 75),
                          Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFeMale = true;
                        isMale = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isFeMale == false ? inactiveColor : activeColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.female, color: Colors.white, size: 75),
                          Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //!----------------------------------------------(2)-----------------------------------------------------
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: inactiveColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Height", style: TextStyle(fontSize: 30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        height.round().toString(),
                        style: TextStyle(fontSize: 26),
                      ),
                      Text("cm", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Slider(
                    activeColor: Colors.amber,
                    min: 100,
                    max: 220,
                    value: height,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          //!----------------------------------------------(3)-------------------------------------------------------
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: inactiveColor,
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("weight", style: TextStyle(fontSize: 25)),
                        Text(
                          weight.round().toString(),
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                if (weight > 0) {
                                  minusTimerWeight();
                                }
                              },
                              onLongPressEnd: (details) {
                                stopTimer();
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (weight > 0) {
                                      weight--;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  fixedSize: Size(50, 50),
                                  iconColor: Colors.amber,
                                ),
                                child: Icon(Icons.remove),
                              ),
                            ),

                            GestureDetector(
                              onLongPress: () {
                                if (weight < 200) {
                                  increaseTimerweight();
                                }
                              },
                              onLongPressEnd: (details) {
                                stopTimer();
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (weight < 200) {
                                      weight++;
                                    }
                                  });
                                },

                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  fixedSize: Size(50, 50),
                                  iconColor: Colors.amber,
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: inactiveColor,
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Age", style: TextStyle(fontSize: 25)),
                        Text(
                          age.round().toString(),
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                if (age > 0) {
                                  minusTimerage();
                                }
                              },
                              onLongPressEnd: (details) {
                                stopTimer();
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (age > 0) {
                                      age--;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  fixedSize: Size(50, 50),
                                  iconColor: Colors.amber,
                                ),
                                child: Icon(Icons.remove),
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                if (age < 100) {
                                  increaseTimerage();
                                }
                              },
                              onLongPressEnd: (details) {
                                stopTimer();
                              },

                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (age < 100) {
                                      age++;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  fixedSize: Size(50, 50),
                                  iconColor: Colors.amber,
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //!----------------------------------------------(The Button)-----------------------------------------------
          SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                final result = calculateResult(weight, height);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ResultScreen(result: result);
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDarkModeNotifier.value
                        ? const Color.fromARGB(255, 46, 51, 57)
                        : inactiveColor,
                fixedSize: Size(350, 20),
              ),
              child: Text(
                "Calculate",
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
